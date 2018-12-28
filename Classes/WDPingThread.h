//
//  WDPingThread.h
//  Pods
//
//  Created by yuecheng on 2018/12/28.
//

#import <Foundation/Foundation.h>

@interface WDPingThread : NSThread

@property (nonatomic, assign) BOOL pingTaskIsRunning;

- (instancetype)initWithThreshold:(double)threshold handler:(void (^)(void))handler;

@end

