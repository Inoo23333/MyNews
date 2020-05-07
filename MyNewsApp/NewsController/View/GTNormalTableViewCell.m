//
//  GTNormalTableViewCell.m
//  SampleApp1
//
//  Created by user on 2020/2/23.
//  Copyright © 2020 user. All rights reserved.
//

#import "GTNormalTableViewCell.h"
#import "GTListItem.h"
#import <SDWebImage.h>

@interface GTNormalTableViewCell ()

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *sourceLabel;
@property (nonatomic, strong, readwrite) UILabel *commentLabel;
@property (nonatomic, strong, readwrite) UILabel *timeLabel;

@property (nonatomic, strong, readwrite) UIImageView *GTImageView;
@property (nonatomic, strong, readwrite) UIButton *deleteButton;

@end

@implementation GTNormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:({
            self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 270, 50)];
            self.titleLabel.font = [UIFont systemFontOfSize:16];
            self.titleLabel.textColor = [UIColor blackColor];
            self.titleLabel.numberOfLines = 2;
            self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            self.titleLabel;
        })];

        [self.contentView addSubview:({
            self.sourceLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 50, 20)];
            self.sourceLabel.font = [UIFont systemFontOfSize:12];
            self.sourceLabel.textColor = [UIColor grayColor];
            self.sourceLabel;
        })];

        [self.contentView addSubview:({
            self.commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, 50, 20)];
            self.commentLabel.font = [UIFont systemFontOfSize:12];
            self.commentLabel.textColor = [UIColor grayColor];
            self.commentLabel;
        })];

        [self.contentView addSubview:({
            self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 70, 50, 20)];
            self.timeLabel.font = [UIFont systemFontOfSize:12];
            self.timeLabel.textColor = [UIColor grayColor];
            self.timeLabel;
        })];

        [self.contentView addSubview:({
            self.GTImageView = [[UIImageView alloc]initWithFrame:CGRectMake(300, 15, 100, 70)];
            self.GTImageView.contentMode = UIViewContentModeScaleAspectFit;
            self.GTImageView;
        })];

        [self.contentView addSubview:({
            self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(385, 85, 18, 13)];
            self.deleteButton.backgroundColor = [UIColor whiteColor];
            [self.deleteButton setTitle:@"x" forState:UIControlStateNormal];
            [self.deleteButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.deleteButton setTitle:@"y" forState:UIControlStateHighlighted];
            [self.deleteButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            [self.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];

            self.deleteButton.layer.cornerRadius = 5;
            self.deleteButton.layer.masksToBounds = YES;
            self.deleteButton.layer.borderColor = [UIColor grayColor].CGColor;
            self.deleteButton.layer.borderWidth = 0.5;

            self.deleteButton;
        })];
    }
    return self;
}

- (void)layoutGTNormalTableViewCellWithItem:(GTListItem *)item {
    
    if(item.title!=nil){
        self.titleLabel.text = item.title;
    }
    if(item.source!=nil){
        self.sourceLabel.text = item.source;
        [self.sourceLabel sizeToFit];
    }
    if(item.replyCount!=nil){
        self.commentLabel.text = item.replyCount;
        [self.commentLabel sizeToFit];
        self.commentLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x + self.sourceLabel.frame.size.width + 15, self.sourceLabel.frame.origin.y, self.commentLabel.frame.size.width, self.commentLabel.frame.size.height);
    }

    if(item.ptime!=nil){
        self.timeLabel.text = item.ptime;
        [self.timeLabel sizeToFit];
        self.timeLabel.frame = CGRectMake(self.commentLabel.frame.origin.x + self.commentLabel.frame.size.width + 15, self.commentLabel.frame.origin.y, self.timeLabel.frame.size.width, self.timeLabel.frame.size.height);
    }
    
    if(item.imgsrc!=nil){
        [self.GTImageView sd_setImageWithURL:[NSURL URLWithString:item.imgsrc] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            NSLog(@"");
        }];
    }

//    NSThread *downloadImageThread = [[NSThread alloc]initWithBlock:^{
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.picUrl]]];
//        self.GTImageView.image = image;
//    }];
//    downloadImageThread.name = @"downloadImageThread";
//    [downloadImageThread start];

//    dispatch_queue_global_t downloadQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_queue_main_t mainQueue = dispatch_get_main_queue();
//
//    dispatch_async(downloadQueue, ^{
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.picUrl]]];
//        dispatch_async(mainQueue, ^{
//            self.GTImageView.image = image;
//        });
//    });
//
    NSLog(@"");
}

- (void)deleteButtonClick {
    NSLog(@"deleteButtonClick");
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteTableViewCell:clickDeleteButton:)]) {
        [self.delegate deleteTableViewCell:self clickDeleteButton:self.deleteButton];
    }
}

@end
