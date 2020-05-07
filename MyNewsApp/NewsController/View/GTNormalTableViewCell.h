//
//  GTNormalTableViewCell.h
//  SampleApp1
//
//  Created by user on 2020/2/23.
//  Copyright © 2020 user. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class GTListItem;

@protocol GTNormalTableViewCellDelegate <NSObject>


/// 点击删除按钮
/// @param tableViewCell
/// @param deleteButton
- (void)deleteTableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton;

@end


/// 新闻列表cell
@interface GTNormalTableViewCell : UITableViewCell

@property (nonatomic, weak, readwrite) id<GTNormalTableViewCellDelegate> delegate;

- (void)layoutGTNormalTableViewCellWithItem:(GTListItem *)item;

@end

NS_ASSUME_NONNULL_END
