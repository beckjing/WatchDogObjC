//
//  WatchDog.m
//  WatchDogObjCDemo
//
//  Created by 景悦诚 on 2018/5/27.
//  Copyright © 2018 NanoSparrow. All rights reserved.
//

#import "WatchDog.h"
#import "PingThread.h"
#import "TraceLogger.h"

@interface WatchDog()

@property (nonatomic, strong) PingThread *pingThread;

@end

@implementation WatchDog

- (void)dealloc {
    [self.pingThread cancel];
}


- (instancetype)initWithThreshold:(double)threshold strictMode:(BOOL)strictMode {
    NSString *message = [NSString stringWithFormat:@"👮 Main thread was blocked for %.2fs 👮", threshold];
    if (strictMode) {
        return [self initWithThreshold:threshold watchdogFiredCallback:^{
            NSLog(@"%@", [TraceLogger bs_backtraceOfMainThread]);
            NSAssert(false, message);
        }];
    }
    else {
        return [self initWithThreshold:threshold watchdogFiredCallback:^{
            NSLog(@"%@", message);
            NSLog(@"%@", [TraceLogger bs_backtraceOfMainThread]);
        }];
    }
}

- (instancetype)initWithThreshold:(double)threshold watchdogFiredCallback:(void (^)(void))watchdogFiredCallback {
    self = [super init];
    if (self) {
        _pingThread = [[PingThread alloc] initWithThreshold:threshold handler:watchdogFiredCallback];
        _pingThread.name = @"WatchDog";
        [_pingThread start];
    }
    return self;
}

@end
