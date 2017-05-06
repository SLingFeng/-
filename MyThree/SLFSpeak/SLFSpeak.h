//
//  SLFSpeak.h
//
//
//  Created by Hale on 17/3/22.
//  Copyright © 2017年 SADF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define singleton_Interface(class)  +(class *)shareclass;

#define singleton_implemetntion(class)\
static class * instance = nil;\
+(class *)shareclass\
{\
if (!instance) {\
instance = [[class alloc]init];\
}\
return instance;\
}\
+(class *)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onece;\
dispatch_once(&onece, ^{\
instance = [super allocWithZone:zone];\
});\
return instance;\
}

@interface SLFSpeak : NSObject <AVSpeechSynthesizerDelegate>

singleton_Interface(SLFSpeak)

/** 语音合成器 */
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;
/** 语言数组 */
@property (nonatomic, strong) NSArray<AVSpeechSynthesisVoice *> *laungeVoices;

@property (nonatomic, copy) NSString *playStr;

- (void)playVoice;

- (void)playAndPause;
@end
