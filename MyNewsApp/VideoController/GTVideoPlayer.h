//
//  GTVideoPlayer.h
//  SampleApp1
//
//  Created by user on 2020/3/10.
//  Copyright © 2020 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 播放器
 */
@interface GTVideoPlayer : NSObject

/**
 全局播放器单例
 */
+ (GTVideoPlayer *)Player;

/**
 在指定View上 通过url播放视频
 */
- (void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *)attachView;

@end

NS_ASSUME_NONNULL_END
