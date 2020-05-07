//
//  GTVideoToolbar.h
//  SampleApp1
//
//  Created by user on 2020/3/10.
//  Copyright © 2020 user. All rights reserved.
//

#import <UIKit/UIKit.h>


#define GTVideoToolbarHeight 50

/**
 视频ViewController Item下的Toolbar
 */
@interface GTVideoToolbar : UIView

/**
 根据数据布局Toolbar
 */
- (void)layoutWithModel:(id)model;

@end
