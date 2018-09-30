//
//  WatchDog.m
//  WatchDogObjCDemo
//
//  Created by 景悦诚 on 2018/5/27.
//  Copyright © 2018 NanoSparrow. All rights reserved.
//

#import "WatchDog.h"
#import "PingThread.h"
#import "BSBacktraceLogger.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface WatchDog()
<
UIAlertViewDelegate
>

@property (nonatomic, strong) PingThread *pingThread;

@end

@implementation WatchDog

- (void)dealloc {
    [self.pingThread cancel];
}


- (instancetype)initWithThreshold:(double)threshold strictMode:(BOOL)strictMode {
    NSString *message = [NSString stringWithFormat:@"👮 Main thread was blocked for %.2fs 👮", threshold];
    if (strictMode) {
        self = [self initWithThreshold:threshold watchdogFiredCallback:^(NSString *backtrace) {
            [[NSUserDefaults standardUserDefaults] setObject:backtrace forKey:NSStringFromClass([WatchDog class])];
            [[NSUserDefaults standardUserDefaults] synchronize];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:backtrace delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                [alert show];
            });
        }];
    }
    else {
        self = [self initWithThreshold:threshold watchdogFiredCallback:^(NSString *backtrace) {
            NSLog(@"%@\n%@", message, backtrace);
        }];
    }
    return self;
}

- (instancetype)initWithThreshold:(double)threshold watchdogFiredCallback:(void (^)(NSString *))watchdogFiredCallback {
    self = [super init];
    if (self) {
        NSString *lastBacktrace = [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromClass([WatchDog class])];
        NSString *message = [NSString stringWithFormat:@"👮 Main thread was blocked for %.2fs 👮", threshold];
        if (lastBacktrace.length > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:lastBacktrace delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                [alert show];
            });
        }
        _pingThread = [[PingThread alloc] initWithThreshold:threshold handler:^{
            if (watchdogFiredCallback) {
                watchdogFiredCallback([BSBacktraceLogger bs_backtraceOfMainThread]);
            }
        }];
        _pingThread.name = @"WatchDog";
        [_pingThread start];
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSStringFromClass([WatchDog class])];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
