//
//  WatchDog.h
//  WatchDogObjCDemo
//
//  Created by 景悦诚 on 2018/5/27.
//  Copyright © 2018 NanoSparrow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WatchDog : NSObject

- (instancetype)initWithThreshold:(double)threshold strictMode:(BOOL)strictMode;
- (instancetype)initWithThreshold:(double)threshold watchdogFiredCallback:(void(^)(NSString *backtrace))watchdogFiredCallback;

@end
