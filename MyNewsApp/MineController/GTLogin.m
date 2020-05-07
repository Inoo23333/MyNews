//
//  GTLogin.m
//  SampleApp1
//
//  Created by user on 2020/3/14.
//  Copyright © 2020 user. All rights reserved.
//

#import "GTLogin.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <time.h>

#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CommonCrypto/CommonDigest.h>

@interface GTLogin () <TencentSessionDelegate>
@property (nonatomic, strong, readwrite) TencentOAuth *oauth;
@property (nonatomic, copy, readwrite) GTLoginFinishBlock finishBlock;
@property (nonatomic, assign, readwrite) BOOL isLogin;
@end

@implementation GTLogin

- (NSMutableArray *)getPermissions
{
    NSMutableArray * g_permissions = [[NSMutableArray alloc] initWithObjects:kOPEN_PERMISSION_GET_USER_INFO,
                                kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                                kOPEN_PERMISSION_ADD_ALBUM,
                                kOPEN_PERMISSION_ADD_TOPIC,
                                kOPEN_PERMISSION_CHECK_PAGE_FANS,
                                kOPEN_PERMISSION_GET_INFO,
                                kOPEN_PERMISSION_GET_OTHER_INFO,
                                kOPEN_PERMISSION_LIST_ALBUM,
                                kOPEN_PERMISSION_UPLOAD_PIC,
                                kOPEN_PERMISSION_GET_VIP_INFO,
                                kOPEN_PERMISSION_GET_VIP_RICH_INFO, nil];
    
    return g_permissions;
}

+ (instancetype)sharedLogin {
    static GTLogin *login;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        login = [[GTLogin alloc] init];
    });
    NSLog(@"");
    return login;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _isLogin = NO;
        _oauth = [[TencentOAuth alloc] initWithAppId:@"222222" andDelegate:self];
    }
    NSLog(@"");
    return self;
}

- (BOOL)isLogin {
    //登陆态失效的逻辑
    NSLog(@"");
    return _isLogin;
}


- (void)loginWithFinishBlock:(GTLoginFinishBlock)finishBlock {
    NSLog(@"");
    
    _finishBlock = [finishBlock copy];
     NSLog(@"");
    _oauth.authMode = kAuthModeClientSideToken;
    [_oauth authorize:@[kOPEN_PERMISSION_GET_USER_INFO,
                        kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                        kOPEN_PERMISSION_ADD_ALBUM,
                        kOPEN_PERMISSION_ADD_TOPIC,
                        kOPEN_PERMISSION_CHECK_PAGE_FANS,
                        kOPEN_PERMISSION_GET_INFO,
                        kOPEN_PERMISSION_GET_OTHER_INFO,
                        kOPEN_PERMISSION_LIST_ALBUM,
                        kOPEN_PERMISSION_UPLOAD_PIC,
                        kOPEN_PERMISSION_GET_VIP_INFO,
                        kOPEN_PERMISSION_GET_VIP_RICH_INFO]];
    NSLog(@"");
}

- (void)logOut {
    [_oauth logout:self];
    _isLogin = NO;
}

#pragma mark - delegate

- (void)tencentDidLogin {
    _isLogin = YES;
    //保存openid
    [_oauth getUserInfo];
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (_finishBlock) {
        _finishBlock(NO);
    }
}

- (void)tencentDidNotNetWork {

}

- (void)tencentDidLogout {
   //退出登录，需要清理下存储在本地的登录数据
}

- (void)getUserInfoResponse:(APIResponse *)response {
    NSDictionary *userInfo = response.jsonResponse;
    _nick = userInfo[@"nickname"];
    _address = userInfo[@"city"];
    _avatarUrl = userInfo[@"figureurl_qq_2"];
    if (_finishBlock) {
        _finishBlock(YES);
    }
}

#pragma mark -

- (void)shareToQQWithArticleUrl:(NSURL *)articleUrl {

    //登陆校验
    //loginWithFinishBlock

    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:articleUrl title:@"iOS" description:@"LMS_MYNEWSAPP" previewImageURL:nil];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    __unused QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
}

@end
