//
//  ViewController.h
//  SampleApp1
//
//  Created by user on 2020/2/4.
//  Copyright © 2020 user. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 这是新闻tab对应的viewController
 */

@interface GTNewsViewController : UIViewController

@property(nonatomic,strong) NSString *newsTitle;

-(instancetype)initWithTitle:(NSString *)newsTitle;

@end

