//
//  GTVideoCoverView.h
//  SampleApp1
//
//  Created by user on 2020/3/9.
//  Copyright © 2020 user. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 视频ViewController collectionView Item
 */
@interface GTVideoCoverView : UICollectionViewCell

/**
 根据数据布局，封面图&播放 url
 */
- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl;
@end

NS_ASSUME_NONNULL_END
