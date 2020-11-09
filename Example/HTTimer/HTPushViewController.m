//
//  HTPushViewController.m
//  HTTimer_Example
//
//  Created by ht on 2020/11/8.
//  Copyright © 2020 markhetao@sina.com. All rights reserved.
//

#import "HTPushViewController.h"
#import <HTTimer/HTTimer.h>

@interface HTPushViewController ()
@property (nonatomic, strong) HTTimer * timer;
@end

@implementation HTPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    // 单例自动启动
//    [self sharedAutoRunDemo];
    
    // 单例手动启动
//    [self sharedCustomRunDemo];
    
    // 自定义对象模式(需要持有timer对象，确保生命周期)
    [self customDemo];
}

/// 单例自动启动
- (void)sharedAutoRunDemo {
    
    //单例模式
    __block double currentTime = 0;
    [HTTimer sharedStartWithDuration:3 Repeats:true TimeOverCallBlock:^{
        NSLog(@"已完成");
    } TimeInCallBlock:^{
        NSLog(@"第%.0f次", currentTime);
        currentTime ++;
    }];
}

/// 单例手动启动
- (void)sharedCustomRunDemo{
    
    /// 总时长
    [HTTimer sharedInstance].duration = 3;
    
    /// 重复
//    [HTTimer sharedInstance].repeats = false;
    
    __block double currentTime = 0;
    
    /// 每次间隔回调
    [HTTimer sharedInstance].timeInCallBlock = ^{
        NSLog(@"第%.0f次", currentTime);
        currentTime ++;
    };
    
    /// 结束回调
    [HTTimer sharedInstance].timeOverCallBlock = ^{
        NSLog(@"已完成");
    };
    
    [[HTTimer sharedInstance] start];
    
}

/// 自定义对象模式(需要持有timer对象，确保生命周期)
- (void)customDemo {
    
    __block double currentTime = 0;
    
    // 0.5秒间隔 3秒总时长 不重复
    self.timer = [HTTimer initWith:0.5 Duration:3 Repeats:false TimeOverCallBlock:^{
        NSLog(@"已完成");
    } TimeInCallBlock:^{
        NSLog(@"第%.0f次", currentTime);
        currentTime ++;
    }];

    [self.timer start];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 点击暂停或继续
    [HTTimer sharedInstance].isRunning ? [[HTTimer sharedInstance] suspendTimer] : [[HTTimer sharedInstance] resumeTimer];
    
    self.timer.isRunning ? [self.timer suspendTimer] : [self.timer resumeTimer];
}

- (void)dealloc {
    NSLog(@"HTPushViewController 已释放");
}

@end
