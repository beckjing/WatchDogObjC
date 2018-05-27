//
//  PingThread.h
//  WatchDogObjCDemo
//
//  Created by 景悦诚 on 2018/5/27.
//  Copyright © 2018 NanoSparrow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PingThread : NSThread

@property (nonatomic, assign) BOOL pingTaskIsRunning;

- (instancetype)initWithThreshold:(double)threshold handler:(void (^)(void))handler;

@end
