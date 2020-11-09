# HTTimer


## Example

* 单例自动启动
``` objc
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
```

* 单例手动启动
``` objc
- (void)sharedCustomRunDemo{
    
    // 总时长
    [HTTimer sharedInstance].duration = 3;
    
    // 重复
//    [HTTimer sharedInstance].repeats = false;
    
    __block double currentTime = 0;
    
    // 每次间隔回调
    [HTTimer sharedInstance].timeInCallBlock = ^{
        NSLog(@"第%.0f次", currentTime);
        currentTime ++;
    };
    
    // 结束回调
    [HTTimer sharedInstance].timeOverCallBlock = ^{
        NSLog(@"已完成");
    };
    
    [[HTTimer sharedInstance] start];
}
```

* 自定义对象模式(需要持有timer对象，确保生命周期)
``` objc
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
```
## Requirements

## Installation

HTTimer is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HTTimer'
```

## Author

markhetao@sina.com

## License

HTTimer is available under the MIT license. See the LICENSE file for more info.
