//
//  HTTimer.m
//  HTTimer
//
//  Created by ht on 2020/11/8.
//

#import "HTTimer.h"

@interface HTTimer()

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) dispatch_queue_t queue;

@property (nonatomic, assign) double currentDuration;
@property (nonatomic, assign) BOOL running;

@end

@implementation HTTimer

static HTTimer *shared = nil;

// 单例
+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shared = [HTTimer new];
    });
    return shared;
}

// 单例直接启动
+ (instancetype)sharedStartWithDuration: (double)duration Repeats:(BOOL)repeats TimeOverCallBlock: (TimeOverCallBlock)overBlock TimeInCallBlock: (TimeInCallBlock)inBlock {
    
    [HTTimer sharedInstance].duration = duration;
    [HTTimer sharedInstance].repeats = repeats;
    [HTTimer sharedInstance].timeOverCallBlock = overBlock;
    [HTTimer sharedInstance].timeInCallBlock = inBlock;
    
    [[HTTimer sharedInstance] start];
    
    return [HTTimer sharedInstance];
    
}

//MARK: - Init
/// 默认间隔：1秒
+ (instancetype)initWith: (double)duration Repeats:(BOOL)repeats TimeOverCallBlock: (TimeOverCallBlock)overBlock TimeInCallBlock: (TimeInCallBlock)inBlock {
    
    HTTimer * objc = [HTTimer new];
    objc.interval = 1;
    objc.repeats = repeats;
    objc.duration = duration;
    objc.timeOverCallBlock = overBlock;
    objc.timeInCallBlock = inBlock;
    
    return objc;
}

/// 默认间隔：1秒 无每次间隔回调
+ (instancetype)initWith: (double)duration Repeats:(BOOL)repeats TimeOverCallBlock: (TimeOverCallBlock)overBlock {
    
    HTTimer * objc = [HTTimer new];
    objc.interval = 1;
    objc.duration = duration;
    objc.repeats = repeats;
    objc.timeOverCallBlock = overBlock;
    
    return objc;
}

+ (instancetype)initWith: (double)interval Duration: (double)duration Repeats:(BOOL)repeats TimeOverCallBlock: (TimeOverCallBlock)overBlock TimeInCallBlock: (TimeInCallBlock)inBlock {
    
    HTTimer * objc = [HTTimer new];
    objc.interval = interval;
    objc.duration = duration;
    objc.repeats = repeats;
    objc.timeOverCallBlock = overBlock;
    objc.timeInCallBlock = inBlock;
    
    return objc;
}

//MARK: - Action
- (void)start {
    
    if (self.interval <= 0) self.interval = 1;
    
    self.currentDuration = self.duration;
    
    if (_timer == nil) {
        _queue = dispatch_queue_create("HT_dispatch_source_timer", DISPATCH_QUEUE_PRIORITY_DEFAULT);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.queue);
    }
    
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, self.interval * NSEC_PER_SEC, 0);
    
    __weak typeof(self) weakself = self;
    
    dispatch_source_set_event_handler(self.timer, ^{
       
        weakself.currentDuration > 0 ? [weakself tiemIn] : [weakself timeOver];
        
        weakself.currentDuration -= weakself.interval;
    });
    
    [self resumeTimer];
}

- (void)suspendTimer {
    
    if (!self.isRunning) return;
    
    self.running = false;
    
    if (self .timer) dispatch_suspend(self.timer);
    
}

- (void)resumeTimer {
    
    if (self.running) return;
    
    self.running = true;
    
    if (self .timer) dispatch_resume(self.timer);
    
}

- (void)cancel {
    
    if (!self.running) return;
    
    self.running = false;
    self.timer = nil;
    if (self .timer) dispatch_cancel(self.timer);
    
}

//MARK: - Event
- (void)timeOver {
    
    // 重复
    if (self.repeats) {
        [self start];
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.timeOverCallBlock) self.timeOverCallBlock();
    });
    
    [self cancel];
}

- (void)tiemIn {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.timeInCallBlock) self.timeInCallBlock();
    });
}

//MARK: - 外部属性
- (BOOL)isRunning {
    return self.running;
}

- (void)dealloc {
    NSLog(@"HTTimer 释放了");
}

@end
