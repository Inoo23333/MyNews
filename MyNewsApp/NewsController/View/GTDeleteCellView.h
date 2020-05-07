//
//  GTDeleteCellView.h
//  SampleApp1
//
//  Created by user on 2020/2/28.
//  Copyright © 2020 user. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTDeleteCellView : UIView

@property(nonatomic,strong,readwrite) UIView *backgroundView;
@property(nonatomic,strong,readwrite) UIButton *deleteButton;
@property(nonatomic,copy,readwrite) dispatch_block_t deleteBlock;


/// 出现deleteVIew
/// @param point 点击的位置
/// @param clickBlock 点击删除后执行的操作
-(void) showDeleteViewFromPoint:(CGPoint) point clickBlock:(dispatch_block_t) clickBlock;
-(void) dismissDeleteView;
-(void)_clickButton;

@end

NS_ASSUME_NONNULL_END
