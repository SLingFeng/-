//
//  SLFSpeak.m
//  
//
//  Created by Hale on 17/3/22.
//  Copyright © 2017年 SADF. All rights reserved.
//

#import "SLFSpeak.h"


@implementation SLFSpeak

singleton_implemetntion(SLFSpeak)

- (NSArray<AVSpeechSynthesisVoice *> *)laungeVoices {
    if (_laungeVoices == nil) {
        _laungeVoices = @[
                          //美式英语
                          [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"],
                          //英式英语
                          [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"],
                          //中文
                          [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]
                          ];
    }
    return _laungeVoices;
}

- (AVSpeechSynthesizer *)synthesizer {
    if (_synthesizer == nil) {
        _synthesizer = [[AVSpeechSynthesizer alloc] init];
        _synthesizer.delegate = self;
    }
    return _synthesizer;
}

#pragma mark - 事件处理 
/** 语音播放 */
- (void)playVoice {     //创建一个会话
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:_playStr];
    //选择语言发音的类别，如果有中文，一定要选择中文，要不然无法播放语音
    utterance.voice = self.laungeVoices[2];
    //播放语言的速率，值越大，播放速率越快
    utterance.rate = 0.4f;
    //音调  --  为语句指定pitchMultiplier ，可以在播放特定语句时改变声音的音调、pitchMultiplier的允许值一般介于0.5(低音调)和2.0(高音调)之间
//    utterance.pitchMultiplier = 0.8f;
    //让语音合成器在播放下一句之前有短暂时间的暂停，也可以类似的设置preUtteranceDelay
    utterance.postUtteranceDelay = 1.f;
    //播放语言
    [self.synthesizer speakUtterance:utterance];
}
/** 暂停语音播放/回复语音播放 */
- (void)playAndPause {
    if (self.synthesizer.isPaused == YES) {
        //暂停状态
        //继续播放
        [self.synthesizer continueSpeaking];
    }     else {
        //现在在播放
        //立即暂停播放
        [self.synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}
/** 停止播放语音 */
- (void)stopPlayVoice {
    if (self.synthesizer.isSpeaking) {
        //正在语音播放
        //立即停止播放语音
        [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}
/**********************AVSpeechSynthesizerDelegate(代理方法)***********************/
#pragma mark - AVSpeechSynthesizerDelegate(代理方法)
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"开始播放语音的时候调用");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"语音播放结束的时候调用");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"暂停语音播放的时候调用");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"继续播放语音的时候调用");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"取消语音播放的时候调用");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance {
    /** 将要播放的语音文字 */
    NSString *willSpeakRangeOfSpeechString = [utterance.speechString substringWithRange:characterRange];
    NSLog(@"即将播放的语音文字:%@",willSpeakRangeOfSpeechString);
}


@end
