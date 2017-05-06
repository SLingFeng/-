//
//  MyTextView.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setPlaceholder:@""];
    
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
}



- (id)initWithFrame:(CGRect)frame {
    
    if( (self = [super initWithFrame:frame]) ) {
        
        [self setPlaceholder:@""];
        
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];

        
    }
    
    return self;
    
}

- (void)textBeginEditing:(NSNotification *)notification {
    if (self.textBeginEditing) {
        self.textBeginEditing();
    }
}


- (void)textChanged:(NSNotification *)notification

{
    
    if([[self placeholder] length] == 0)
        
    {
        
        return;
        
    }
    
    
    
    if([[self text] length] == 0)
        
    {
        
        [[self viewWithTag:999] setAlpha:1];
        
    }
    
    else
        
    {
        
        [[self viewWithTag:999] setAlpha:0];
        
    }
    if (_enterNumber) {
        NSString *aString = self.text;
        UITextRange *selectedRange = [self markedTextRange];
        // 獲取被選取的文字區域（在打注音時，還沒選字以前注音會被選起來）
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 沒有被選取的字才限制文字的輸入字數
        if (!position) {
            if (aString.length > _enterNumber) {
                self.text = [aString substringToIndex:_enterNumber];
            }
        }
    }
    if (self.textViewChange) {
        self.textViewChange(self.text);
    }
}



- (void)setText:(NSString *)text {
    
    [super setText:text];
    
    [self textChanged:nil];
    
}



- (void)drawRect:(CGRect)rect {
    
    if( [[self placeholder] length] > 0 ) {
        
        if ( _placeHolderLabel == nil ) {
            
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
            
            _placeHolderLabel.lineBreakMode = UILineBreakModeWordWrap;
            
            _placeHolderLabel.numberOfLines = 0;
            
            _placeHolderLabel.font = [SLFCommonTools pxFont:28];
            
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            
            _placeHolderLabel.textColor = self.placeholderColor;
            
            _placeHolderLabel.alpha = 0;
            
            _placeHolderLabel.tag = 999;
            
            [self addSubview:_placeHolderLabel];
            
        }
        _placeHolderLabel.text = self.placeholder;
        
        [_placeHolderLabel sizeToFit];
        
        [self sendSubviewToBack:_placeHolderLabel];
        
    }
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
        
    {
        
        [[self viewWithTag:999] setAlpha:1];
        
    }
    
    [super drawRect:rect];
    
}

@end
