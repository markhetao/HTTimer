//
//  HTTimer.h
//  HTTimer
//
//  Created by ht on 2020/11/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^TimeOverCallBlock)(void);
typedef void (^TimeInCallBlock)(void);

@interface HTTimer : NSObject

/// 单例
+ (instancetype)sharedInstance;

/// 单例直接启动
/// @param duration 总时长
/// @param repeats 重复
/// @param overBlock 结束回调
/// @param inBlock 每次间隔回调
+ (instancetype)sharedStartWithDuration: (double)duration Repeats:(BOOL)repeats TimeOverCallBlock: (TimeOverCallBlock)overBlock TimeInCallBlock: (TimeInCallBlock)inBlock;

/// Init (默认间隔1秒)
/// @param duration 总时长
/// @param repeats 重复
/// @param overBlock 结束回调
/// @param inBlock 每次间隔回调
+ (instancetype)initWith: (double)duration Repeats:(BOOL)repeats TimeOverCallBlock: (TimeOverCallBlock)overBlock TimeInCallBlock: (TimeInCallBlock)inBlock;

/// Init (默认间隔1秒，无每次间隔回调)
/// @param duration 总时长
/// @param repeats 重复
/// @param overBlock 结束回调

+ (instancetype)initWith: (double)duration Repeats:(BOOL)repeats TimeOverCallBlock: (TimeOverCallBlock)overBlock;

/// Init (默认间隔1秒)
/// @param interval 时间间隔（多少秒一次）
/// @param duration 总时长
/// @param repeats 重复
/// @param overBlock 结束回调
/// @param inBlock 每次间隔回调
+ (instancetype)initWith: (double)interval Duration: (double)duration Repeats:(BOOL)repeats TimeOverCallBlock: (TimeOverCallBlock)overBlock TimeInCallBlock: (TimeInCallBlock)inBlock;

/// 时间间隔
@property (nonatomic, assign) double interval;

/// 总时长
@property (nonatomic, assign) double duration;

/// 重复
@property (nonatomic, assign) BOOL repeats;

/// 运行状态
@property (nonatomic, assign, readonly) BOOL isRunning;

/// 计时结束Block
@property (nonatomic, copy) TimeOverCallBlock timeOverCallBlock;

/// 计时中Block(每interval秒一次)
@property (nonatomic, copy) TimeInCallBlock timeInCallBlock;

/// 开始
- (void)start;

/// 暂停
- (void)suspendTimer;

/// 启动
- (void)resumeTimer;

/// 取消
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
