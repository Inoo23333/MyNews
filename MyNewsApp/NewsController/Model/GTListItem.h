//
//  GTListItem.h
//  SampleApp1
//
//  Created by user on 2020/3/6.
//  Copyright © 2020 user. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 列表结构化数据
@interface GTListItem : NSObject<NSSecureCoding>

@property (nonatomic, copy, readwrite) NSString *source;
@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, copy, readwrite) NSString *ptime;
@property (nonatomic, copy, readwrite) NSString *url;
@property (nonatomic, copy, readwrite) NSString *imgsrc;
@property (nonatomic, copy, readwrite) NSString *replyCount;

- (void)configWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
