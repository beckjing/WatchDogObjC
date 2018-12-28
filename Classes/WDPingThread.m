//
//  WDPingThread.m
//  Pods
//
//  Created by yuecheng on 2018/12/28.
//

#import "WDPingThread.h"

static double WDDefaultThreshold = 0.04;

@interface WDPingThread ()

@property (nonatomic, strong) NSObject *pingTaskIsRunngingLock;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, assign) double threshold;
@property (nonatomic,   copy) void(^handler)(void);

@end

@implementation WDPingThread

@synthesize pingTaskIsRunning = _pingTaskIsRunning;


- (instancetype)initWithThreshold:(double)threshold handler:(void (^)(void))handler {
    self = [self init];
    if (self) {
        _threshold = threshold;
        _handler = handler;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _threshold = WDDefaultThreshold; //defaultValue
        _pingTaskIsRunngingLock = [[NSObject alloc] init];
        _semaphore = dispatch_semaphore_create(0);
    }
    self.name = @"pingThread";
    return self;
}

- (BOOL)pingTaskIsRunning {
    @synchronized(self.pingTaskIsRunngingLock) {
        return _pingTaskIsRunning;
    }
}

- (void)setPingTaskIsRunning:(BOOL)pingTaskIsRunning {
    @synchronized(self.pingTaskIsRunngingLock) {
        _pingTaskIsRunning = pingTaskIsRunning;
    }
}

- (void)main {
    while (!self.isCancelled) {
        self.pingTaskIsRunning = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pingTaskIsRunning = NO;
            dispatch_semaphore_signal(self.semaphore);
        });
        
        [NSThread sleepForTimeInterval:self.threshold];
        if (self.pingTaskIsRunning && self.handler) {
            self.handler();
        }
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    }
}

@end
