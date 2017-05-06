//
//  SelectDataPicker.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "SelectDataPicker.h"
#import "DVYearMonthDatePicker.h"

typedef enum : NSUInteger {
    SelectStatusOne,
    SelectStatusTwo,
} SelectStatus;


@interface SelectDataPicker ()<UIPickerViewDelegate, UIPickerViewDataSource, DVYearMonthDatePickerDelegate>
{
    UIDatePicker * _datePicker;
    DVYearMonthDatePicker * _dvDatePicker;
    SelectStatus _ss;
    UILabel * _label;
    UIPickerView * _pickerView;
    UIView * _backgroundView;
    ShuRuKuangTFView * _money;
    
    NSMutableArray * _numArr;
    SeleCtType _type;
    NSString * _selectPercentage;
    CGFloat _selectHeight;
    
    MyLabel * _timeLabel;
    //选择
    NSInteger _index;
    
    NSArray *_shengArr;
    
    NSArray *_classTimeArr;
    
    NSArray *_eduArr;
    
    NSArray *_sexArr;
    
    NSArray *_kmArr;
    
    NSMutableArray *_keMuArr;
    
    NSArray *_gzArr;
    
    NSMutableArray *_gradeArr;
    
    NSArray *_plusMoneyArr;
}
@end

@implementation SelectDataPicker

-(instancetype)initWithType:(SeleCtType)type {
    if (self = [super init]) {
        _type = type;
        if (_type == SeleCtTypeMoney) {
            _selectHeight = 40;
            // 监听键盘改变
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
        }else {
            _selectHeight = 260;
        }
        [self setPicker];
    }
    return self;
}
// 移除监听
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
// 监听键盘的frame即将改变的时候调用
- (void)keyboardWillChange:(NSNotification *)note{
    // 获得键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _backgroundView.frame = CGRectMake(0, frame.origin.y - _selectHeight, kScreenW, _selectHeight);
    // 执行动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        // 如果有需要,重新排版
        [self layoutIfNeeded];
    }];
}

-(void)setPicker {
    self.frame = kScreen;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
//    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)]];

    UIView * back = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH+_selectHeight, kScreenW, _selectHeight)];
    _backgroundView = back;
    _backgroundView.backgroundColor = [UIColor whiteColor];
//    _backgroundView.layer.cornerRadius = 5.f;
//    _backgroundView.layer.masksToBounds = YES;
    [self addSubview:_backgroundView];
    _backgroundView.alpha = 0;
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kScreenW, 0.5)];
    view.backgroundColor = [SLFCommonTools colorHex:@"bfbfbf"];
    [back addSubview:view];
    
    kWeakSelf(weakSelf);
    MyButton * cancelBtn = [MyButton buttonWithType:(UIButtonTypeCustom)];
    [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [cancelBtn setOnClickBlock:^(MyButton *sender) {
        [weakSelf cancelTap];
    }];
    [cancelBtn setTitleColor:k666666 forState:(UIControlStateNormal)];
    cancelBtn.titleLabel.font = [SLFCommonTools pxFont:32];
    [_backgroundView addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(8);
    }];
    
    UIButton * doneBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [doneBtn setTitle:@"完成" forState:(UIControlStateNormal)];
    [doneBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [doneBtn setTitleColor:kFF0000 forState:(UIControlStateNormal)];
    doneBtn.titleLabel.font = [SLFCommonTools pxFont:32];
    [_backgroundView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.top.offset(8);
//        make.size.mas_equalTo(CGSizeMake(90, 20));
    }];
    
    _timeLabel = [[MyLabel alloc] initWithFontSize:26 fontColor:@"111111" setText:@""];
    [_backgroundView addSubview:_timeLabel];
    
    [self setSelectPicker:_type];
    
    if (_type != SeleCtTypeMoney) {
    }else {
        [doneBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_backgroundView);
        }];
    }
    
    
    [self show];
}

-(void)setSelectPicker:(SeleCtType)type {
    switch (type) {
        case SeleCtTypeYearMonthDay:
        {
            UIDatePicker * datePicker = [[UIDatePicker alloc] init];
            [_backgroundView addSubview:datePicker];
            datePicker.datePickerMode = UIDatePickerModeDateAndTime;
            [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
            [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_backgroundView).with.offset(0);
                make.left.and.right.equalTo(_backgroundView).with.offset(0);
            }];
            _datePicker = datePicker;
        }
            break;
        case SeleCtTypeYearMonth:
        {
            DVYearMonthDatePicker *datePicker = [[DVYearMonthDatePicker alloc] init];
            datePicker.dvDelegate = self;
            [datePicker selectToday];
            [_backgroundView addSubview:datePicker];
            [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_backgroundView).with.offset(0);
                //                make.left.and.right.equalTo(_backgroundView).with.offset(0);
                make.left.offset(20);
                make.right.offset(-20);
            }];
            _dvDatePicker = datePicker;
        }
            break;
        case SeleCtTypePercentage:
        {
            [self dp];
            _selectPercentage = @"1%";
            
            _numArr = [NSMutableArray arrayWithCapacity:100];
            for (int i=1; i<100; i++) {
                [_numArr addObject:[NSString stringWithFormat:@"%d%%", i]];
            }
        }
            break;
        case SeleCtTypeMoney:
        {
            
            ShuRuKuangTFView * money = [[ShuRuKuangTFView alloc] initWithTitle:@"充值金额" placeholder:@"请输入充值的金额" image:nil custom:nil];
            [_backgroundView addSubview:money];
            money.TextField.keyboardType = UIKeyboardTypeNumberPad;
            [money.TextField becomeFirstResponder];
            money.enterNumber = 4;
            _money = money;
            [money mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_backgroundView);
                make.centerY.equalTo(_backgroundView);
                make.left.equalTo(_backgroundView).offset(0);
                make.right.offset(70);
                make.height.mas_equalTo(30);
            }];
        }
            break;
        case SeleCtTypeName: {
            [self dp];
            
        }
            break;
        case SeleCtTypeAdder: {
            _shengArr = [YGBAppConfigModel shareclass].addressTree;
            [self dp];
        }
            break;
        case SeleCtTypeClassTime: {
            [self getData:1];
            [self dp];
            
        }
            break;
        case SeleCtTypeEdu: {
            [self getData:2];
            [self dp];
            
        }
            break;
        case SeleCtTypeSex: {
            [self getData:3];
            [self dp];
            
        }
            break;
        case SeleCtTypeKm: {
            [self getData:4];
            [self dp];
            
        }
            break;
        case SeleCtTypeKeMu: {
            [self getData:5];
            [self dp];
            
        }
            break;
            //工种
        case SeleCtTypeGongZhong: {
            _gzArr = [YGBAppConfigModel shareclass].gzdjlist;
            [self dp];
            
        }
            break;
        case SeleCtTypeGrade: {
            [self getData:6];
            [self dp];
            
        }
            break;
        case SeleCtTypePlusMoney: {//加价金额
            [self getData:7];
            [self dp];
            
        }
            break;
        case SeleCtTypeGYear: {//加价金额
            [self getData:8];
            [self dp];
        }
            break;
        case SeleCtTypeTime: {
            UIDatePicker * datePicker = [[UIDatePicker alloc] init];
            [_backgroundView addSubview:datePicker];
            datePicker.datePickerMode = UIDatePickerModeDate;
            [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
            [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_backgroundView).with.offset(0);
                make.left.and.right.equalTo(_backgroundView).with.offset(0);
            }];
            _datePicker = datePicker;
        }
            break;
        default:
            break;
    }
    
}

- (void)getData:(NSInteger)index {
//    NSLog(@"-->>%@", [YGBAppConfigModel shareclass].datadictionary);
    
    if (index == 5) {
        _keMuArr = [NSMutableArray arrayWithCapacity:1];
        for (YGBKmlistModel * kemu in [YGBAppConfigModel shareclass].kmlist) {
            if ([kemu.classname isEqualToString:[GVUserDefaults standardUserDefaults].grade]) {
                for (YGBKmlistSubjectModel *sub  in kemu.subject) {
                    [_keMuArr addObject:sub];
                }
            }
        }
        return;
    }
    if (index == 6) {//年级
        _gradeArr = [NSMutableArray arrayWithCapacity:2];
        for (YGBKmlistModel * kemu in [YGBAppConfigModel shareclass].kmlist) {
            [_gradeArr addObject:kemu];
        }
        return;
    }
    for (YGBDatadictionaryModel *dc in [YGBAppConfigModel shareclass].datadictionary) {
        if (index == 1) {
            if ([dc.zlmc isEqualToString:@"上课时长"]) {
                _classTimeArr = dc.dmlist;
                return;
            }
        }else if (index == 2) {
            if ([dc.zlmc isEqualToString:@"学历"]) {
                _eduArr = dc.dmlist;
                return;
            }
        }else if (index == 3) {
            if ([dc.zlmc isEqualToString:@"性别"]) {
                _sexArr = dc.dmlist;
                return;
            }
        }else if (index == 4) {
            if ([dc.zlmc isEqualToString:@"公里数"]) {
                _kmArr = dc.dmlist;
                return;
            }
        }else if (index == 7) {
            if ([dc.zlmc isEqualToString:@"加价金额"]) {
                _plusMoneyArr = dc.dmlist;
                return;
            }
        }else if (index == 8) {
            if ([dc.zlmc isEqualToString:@"工龄"]) {
                _plusMoneyArr = dc.dmlist;
                return;
            }
        }
    }
}

#pragma mark -

-(UIPickerView *)dp {
    UIPickerView * pv = [[UIPickerView alloc] init];
    [_backgroundView addSubview:pv];
    pv.delegate = self;
    pv.dataSource = self;
    for (UIView *separatorLine in pv.subviews) {
        if (separatorLine.frame.size.height < 1) {
            separatorLine.backgroundColor = [SLFCommonTools colorHex:kLineColor];
        }
    }
    _pickerView = pv;
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_backgroundView).with.offset(0);
        make.left.offset(20);
        make.right.offset(-20);
    }];
    return pv;
}



-(void)nextBtnClick:(UIButton *)btn {
    switch (_type) {
        case SeleCtTypeYearMonthDay:{
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            _timeDate = [[NSMutableString alloc] initWithString:[dateFormatter stringFromDate:_datePicker.date]];
            if (self.backTimeDate) {
                self.backTimeDate(_timeDate, _datePicker.date, _index);
                [self cancelTap];
            }
            
        }
            break;
        case SeleCtTypeYearMonth:{
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM"];
            _timeDate = [[NSMutableString alloc] initWithString:[dateFormatter stringFromDate:_datePicker.date]];
            if (self.backTimeDate) {
                self.backTimeDate(_timeDate, _dvDatePicker.date, _index);
                [self cancelTap];
            }
            
        }
            break;
        case SeleCtTypePercentage:{
            if (self.backTimeDate) {
                self.backTimeDate(_selectPercentage, _datePicker.date, _index);
                [self cancelTap];
            }
        }
            break;
        case SeleCtTypeMoney:{
            if (self.backTimeDate) {
                self.backTimeDate(_money.TextField.text, _datePicker.date, _index);
                [self cancelTap];
            }
        }
            break;
        case SeleCtTypeName:{
            if (self.backTimeDate) {
                self.backTimeDate(_selectPercentage, nil, _index);
                [self cancelTap];
            }
        }
            break;
        case SeleCtTypeAdder:{
            if (self.backAdder) {
                NSInteger row1 = [_pickerView selectedRowInComponent:0];
                NSInteger row2 = [_pickerView selectedRowInComponent:1];
                NSInteger row3 = [_pickerView selectedRowInComponent:2];
                
                YGBAddressTreeShengModel * sheng = _shengArr[row1];
                YGBAddressTreeShiModel * shi = sheng.sub[row2];
                YGBAddressTreeQuModel * qu = shi.sub[row3];
                self.backAdder(sheng, shi, qu);
                [self cancelTap];
            }
        }
            break;
        case SeleCtTypeClassTime: {
            if (self.backDataDicModel) {
                NSInteger row = [_pickerView selectedRowInComponent:0];
                self.backDataDicModel(_classTimeArr[row]);
            }
        }
            break;
        case SeleCtTypeEdu: {
            if (self.backDataDicModel) {
                NSInteger row = [_pickerView selectedRowInComponent:0];
                self.backDataDicModel(_eduArr[row]);
            }
        }
            break;
        case SeleCtTypeSex: {
            if (self.backDataDicModel) {
                NSInteger row = [_pickerView selectedRowInComponent:0];
                self.backDataDicModel(_sexArr[row]);
            }
        }
            break;
        case SeleCtTypeKm: {
            if (self.backDataDicModel) {
                NSInteger row = [_pickerView selectedRowInComponent:0];
                self.backDataDicModel(_kmArr[row]);
            }
        }
            break;
        case SeleCtTypeKeMu: {
            if (self.backKeMu) {
                NSInteger row = [_pickerView selectedRowInComponent:0];
                self.backKeMu(_keMuArr[row]);
            }
        }
            break;
        case SeleCtTypeGrade: {
            if (self.backGrade) {
                NSInteger row = [_pickerView selectedRowInComponent:0];
                YGBKmlistModel *nj = _gradeArr[row];
                [GVUserDefaults standardUserDefaults].grade = nj.classname;
                self.backGrade(nj);
            }
        }
            break;
            //工种
        case SeleCtTypeGongZhong: {
            if (self.backGongZhong) {
                NSInteger row = [_pickerView selectedRowInComponent:0];
                self.backGongZhong(_gzArr[row]);
            }
        }
            break;
        case SeleCtTypePlusMoney: {//加价金额
            if (self.backDataDicModel) {
                NSInteger row = [_pickerView selectedRowInComponent:0];
                if (row == 0) {
                    self.backDataDicModel(nil);
                }else {
                    self.backDataDicModel(_plusMoneyArr[row - 1]);
                }
            }
            
        }
            break;
        case SeleCtTypeGYear: {//工龄
            if (self.backDataDicModel) {
                NSInteger row = [_pickerView selectedRowInComponent:0];
                self.backDataDicModel(_plusMoneyArr[row]);
            }
            
        }
            break;

        default:
            break;
    }
    [self cancelTap];
}

-(void)dateChange:(UIDatePicker *)dp {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSLog(@"%@<>%@", dp.date, [dateFormatter stringFromDate:dp.date]);
}

-(void)setNameDataArr:(NSMutableArray *)NameDataArr {
    if (_NameDataArr != NameDataArr) {
        _NameDataArr = NameDataArr;
        if (NameDataArr != nil) {
            _selectPercentage = _NameDataArr[0];
            [_pickerView reloadAllComponents];
        }
    }
}
#pragma mark - picker delegete
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (_type == SeleCtTypeAdder) {
        return 3;
    }
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (_type == SeleCtTypeName) {
        return _NameDataArr.count;
    }
//    上课时长
    if (_type == SeleCtTypeClassTime) {
        return _classTimeArr.count;
    }
//    学历
    if (_type == SeleCtTypeEdu) {
        return _eduArr.count;
    }
//    性别
    if (_type == SeleCtTypeSex) {
        return _sexArr.count;
    }
//    公里数
    if (_type == SeleCtTypeKm) {
        return _kmArr.count;
    }
//    科目
    if (_type == SeleCtTypeKeMu) {
        return _keMuArr.count;
    }
    //工种
    if (_type == SeleCtTypeGongZhong) {
        return _gzArr.count;
    }
    //年级
    if (_type == SeleCtTypeGrade) {
        return _gradeArr.count;
    }
    //加价金额
    if (_type == SeleCtTypePlusMoney) {
        return _plusMoneyArr.count + 1;
    }
    //工龄
    if (_type == SeleCtTypeGYear) {
        return _plusMoneyArr.count;
    }
    //地址
    if (_type == SeleCtTypeAdder) {
        if (component == 0){
            return _shengArr.count;
        }else if (component == 1) {
            NSInteger row = [pickerView selectedRowInComponent:0];
            YGBAddressTreeShengModel * sheng = _shengArr[row];
            return kArrayIsEmpty(sheng.sub)?0:sheng.sub.count;
        }else {
            NSInteger row = [pickerView selectedRowInComponent:0];
            NSInteger row1 = [pickerView selectedRowInComponent:1];
            YGBAddressTreeShengModel * sheng = _shengArr[row];
            if (kArrayIsEmpty(sheng.sub)) {
                return 0;
            }
            YGBAddressTreeShiModel * shi = sheng.sub[row1];
            return kArrayIsEmpty(shi.sub)?0:shi.sub.count;
        }
    }
    return 99;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (_type == SeleCtTypeName) {
        return _NameDataArr[row];
    }
    //    上课时长
    if (_type == SeleCtTypeClassTime) {
        YGBDatadictionaryModel *dc = _classTimeArr[row];
        return dc.dmmc;
    }
    //    学历
    if (_type == SeleCtTypeEdu) {
        YGBDatadictionaryModel *dc = _eduArr[row];
        return dc.dmmc;
    }
    //    性别
    if (_type == SeleCtTypeSex) {
        YGBDatadictionaryModel *dc = _sexArr[row];
        return dc.dmmc;
    }
    //    公里数
    if (_type == SeleCtTypeKm) {
        YGBDatadictionaryModel *dc = _kmArr[row];
        return dc.dmmc;
    }
    //    科目
    if (_type == SeleCtTypeKeMu) {
        YGBKmlistSubjectModel * subkm = _keMuArr[row];
        return subkm.subjectname;
    }
    //工种
    if (_type == SeleCtTypeGongZhong) {
        YGBGzdjlistModel * gz = _gzArr[row];
        return gz.ygblcname;
    }
    //年级
    if (_type == SeleCtTypeGrade) {
        YGBKmlistModel * nj = _gradeArr[row];
        return nj.classname;
    }
    //加价金额
    if (_type == SeleCtTypePlusMoney) {
        if (row == 0) {
            return @"";
        }
        YGBDatadictionaryModel *dc = _plusMoneyArr[row - 1];
        return [NSString stringWithFormat:@"%@元",dc.dmmc];
    }
    //工龄
    if (_type == SeleCtTypeGYear) {
        YGBDatadictionaryModel *dc = _plusMoneyArr[row];
        return dc.dmmc;
    }
    if (_type == SeleCtTypeAdder) {
        NSInteger row1 = [pickerView selectedRowInComponent:0];
        NSInteger row2 = [pickerView selectedRowInComponent:1];
        if (component == 0){
            YGBAddressTreeShengModel * sheng = _shengArr[row];
            return sheng.addname;
        }else if (component == 1) {
            YGBAddressTreeShengModel * sheng = _shengArr[row1];
            YGBAddressTreeShiModel * shi = sheng.sub[row];
            return shi.addname;
        }else {
            
            YGBAddressTreeShengModel * sheng = _shengArr[row1];
            YGBAddressTreeShiModel * shi = sheng.sub[row2];
            YGBAddressTreeQuModel * qu = shi.sub[row];
            return qu.addname;
        }
    }
    return _numArr[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _index = row;
    if (_type == SeleCtTypeName) {
        _selectPercentage = _NameDataArr[row];
    }else if (_type == SeleCtTypeAdder) {
        if (component == 0) {
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
        if (component == 1) {
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
    }
    
    //    上课时长
//    if (_type == SeleCtTypeClassTime) {
//         _classTimeArr.count;
//    }
//    //    学历
//    if (_type == SeleCtTypeEdu) {
//         _eduArr.count;
//    }
//    //    性别
//    if (_type == SeleCtTypeSex) {
//         _sexArr.count;
//    }
//    //    公里数
//    if (_type == SeleCtTypeKm) {
//         _kmArr.count;
//    }
    
    _selectPercentage = _numArr[row];
    
}

- (void)getCity {
    NSInteger row1 = [_pickerView selectedRowInComponent:0];
    NSInteger row2 = [_pickerView selectedRowInComponent:1];
    NSInteger row3 = [_pickerView selectedRowInComponent:2];
    
    YGBAddressTreeShengModel * sheng = _shengArr[row1];
    YGBAddressTreeShiModel * shi = sheng.sub[row2];
    YGBAddressTreeQuModel * qu = shi.sub[row3];
    
    NSLog(@"%@", [NSString stringWithFormat:@"%@-%@-%@", sheng.addname, shi.addname, qu.addname]);
}

//dv
- (void)yearMonthDatePicker:(DVYearMonthDatePicker *)yearMonthDatePicker didSelectedDate:(NSDate *)date {
    NSLog(@"%@", date);
}

-(void)show {
    kWeakSelf(weakSelf);
    kWeakObj(weakOBJ, _backgroundView);
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
        weakSelf.alpha = 1;
        weakOBJ.alpha = 1;
        weakOBJ.frame = CGRectMake(0, kScreenH-_selectHeight, kScreenW, _selectHeight);
    } completion:^(BOOL finished) {
        
    }];
//    [UIView animateWithDuration:0.35 animations:^{
//        weakSelf.alpha = 1;
//        weakOBJ.alpha = 1;
//        weakOBJ.frame = CGRectMake(0, kScreenH-_selectHeight, kScreenW, _selectHeight);
//    }];
}

-(void)cancelTap {
    kWeakSelf(weakSelf);
    kWeakObj(weakOBJ, _backgroundView);
    [UIView animateWithDuration:0.35 animations:^{
        weakSelf.alpha = 0;
        weakOBJ.alpha = 0;
        weakOBJ.frame = CGRectMake(0, kScreenH+_selectHeight, kScreenW, _selectHeight);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end
