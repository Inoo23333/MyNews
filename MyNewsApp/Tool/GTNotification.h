//
//  GTNotification.h
//  SampleApp1
//
//  Created by user on 2020/3/17.
//  Copyright © 2020 user. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 APP 推送管理
 */
@interface GTNotification : NSObject

+ (GTNotification *)notificationManager;

- (void)checkNotificationAuthorization;

@end

NS_ASSUME_NONNULL_END
