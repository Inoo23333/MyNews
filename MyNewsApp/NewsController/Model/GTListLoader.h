//
//  GTListLoader.h
//  SampleApp1
//
//  Created by user on 2020/3/1.
//  Copyright © 2020 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTListItem;

NS_ASSUME_NONNULL_BEGIN

typedef void(^GTListLoaderFinishBlock)(BOOL success,NSArray<GTListItem *> *dataArray);

/// 列表请求
@interface GTListLoader : NSObject

@property(nonatomic,strong) NSString *urlString;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *key;

-(void)loadListDataWithFinishBlock:(GTListLoaderFinishBlock)finishBlock;
-(instancetype)initWithTitle:(NSString *) title;

@end

NS_ASSUME_NONNULL_END
