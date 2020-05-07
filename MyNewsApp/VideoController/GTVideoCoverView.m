//
//  GTVideoCoverView.m
//  SampleApp1
//
//  Created by user on 2020/3/9.
//  Copyright © 2020 user. All rights reserved.
//

#import "GTVideoCoverView.h"
#import "GTVideoPlayer.h"
#import "GTVideoToolbar.h"

@interface GTVideoCoverView ()

@property (nonatomic, strong, readwrite) UIImageView *coverView;
@property (nonatomic, strong, readwrite) UIImageView *playButton;
@property (nonatomic, copy, readwrite) NSString *videoUrl;

@property (nonatomic, copy, readwrite) GTVideoToolbar *toolbar;

@end

@implementation GTVideoCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:({
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - GTVideoToolbarHeight)];
            _coverView;
        })];

        [_coverView addSubview:({
            _playButton = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - 50) / 2, (frame.size.height - 50) / 2, 50, 50)];
            _playButton;
        })];
        
        [self addSubview:({
            _toolbar = [[GTVideoToolbar alloc] initWithFrame:CGRectMake(0, _coverView.bounds.size.height, frame.size.width, GTVideoToolbarHeight)];
            _toolbar;
        })];

        UITapGestureRecognizer *tapGeusture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_touchToPlay)];
        [self addGestureRecognizer:tapGeusture];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mask - public method

- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl {
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    _playButton.image = [UIImage imageNamed:@"icon.bundle/videoPlay.png"];
    _videoUrl = videoUrl;
    [_toolbar layoutWithModel:nil];
}

#pragma mask - private method

- (void)_touchToPlay {
    [[GTVideoPlayer Player]playVideoWithUrl:_videoUrl attachView:_coverView];
    
}


@end
