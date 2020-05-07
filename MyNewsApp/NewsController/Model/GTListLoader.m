//
//  GTListLoader.m
//  SampleApp1
//
//  Created by user on 2020/3/1.
//  Copyright © 2020 user. All rights reserved.
//

#import "GTListLoader.h"
#import <AFNetworking.h>
#import "GTListItem.h"

@implementation GTListLoader

//@[@"头条",@"精选",@"娱乐",@"汽车",@"运动",@"房产",@"科技",@"流行"]

-(instancetype)initWithTitle:(NSString *) title{
    self = [super init];
    
    //每个链接返回dict的key不同！！！！！接口不统一。。。没办法只好一个一个个对应确认了了
    if([title isEqualToString:@"首页"]){
        _title = title;
        _key = @"T1348647853363";
        _urlString = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-40.html";
        //  http://v.juhe.cn/toutiao/index?type=top&key=3dc86b09a2ee2477a5baa80ee70fcdf
        //有每日请求次数限制
    }else if([title isEqualToString:@"头条"]){
        _title = title;
        _key = @"T1467284926140";
        _urlString = @"http://c.3g.163.com/nc/article/list/T1467284926140/0-20.html";
    }else if ([title isEqualToString:@"精选"]){
        _title = title;
        _key = @"T1348648517839";
        _urlString = @"http://c.3g.163.com/nc/article/list/T1348648517839/0-20.html";
    }else if ([title isEqualToString:@"娱乐"]){
        _title = title;
        _key = @"T1348649079062";
        _urlString = @"http://c.3g.163.com/nc/article/list/T1348649079062/0-20.html";
    }else if ([title isEqualToString:@"汽车"]){
        _title = title;
        _key = @"list";
        _urlString = @"http://c.m.163.com/nc/auto/list/5bmz6aG25bGx/0-20.html";
    }else if ([title isEqualToString:@"运动"]){
        _title = title;
        _key = @"T1348647853363";
        _urlString = @"https://3g.163.com/touch/reconstruct/article/list/BAI67OGGwangning/0-20.html";
    }else if ([title isEqualToString:@"房产"]){
        _title = title;
        _key = @"T1348647853363";
        _urlString = @"https://3g.163.com/touch/reconstruct/article/list/BA8D4A3Rwangning/0-20.html";
    }else if ([title isEqualToString:@"科技"]){
        _title = title;
        _key = @"T1348647853363";
        _urlString = @"https://3g.163.com/touch/reconstruct/article/list/BAI6JOD9wangning/0-20.html";
    }else if ([title isEqualToString:@"流行"]){
        _title = title;
        _key = @"T1348647853363";
        _urlString = @"https://3g.163.com/touch/reconstruct/article/list/BA8F6ICNwangning/0-20.html";
    }
    return self;
}


/// 加载数据传入finishBlock中
/// @param finishBlock
- (void)loadListDataWithFinishBlock:(GTListLoaderFinishBlock)finishBlock {

//    [[AFHTTPSessionManager manager] GET:@"http://v.juhe.cn/toutiao/index?type=top&key=3dc86b09a2ee2477a5baa80ee70fcdf" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"?");
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"Y");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"N");
//    }];

//    NSArray<GTListItem*> *list =  [self _readDataFromLocal];
//    if(list){
//        finishBlock(YES, list);
//    }
    
    
//    urlString = _urlString;
    
    NSURL *listURL = [NSURL URLWithString:_urlString];
    __unused NSURLRequest *listRequest = [NSURLRequest requestWithURL:listURL];

    NSURLSession *session = [NSURLSession sharedSession];

    __weak typeof(self) wself = self;

    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        __strong typeof(wself) strongSelf = wself;
        
        //将网络请求传回来的json数据序列化成NSDictionary字典对象
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //从字典对象中取出数据存在数组中
        
        
        NSArray *dataArray = [dict objectForKey:strongSelf.key];
        
        NSMutableArray *listItemArray = @[].mutableCopy;
        for (NSDictionary *info in dataArray) {
            GTListItem *listItem = [[GTListItem alloc]init];
            [listItem configWithDictionary:info];
            [listItemArray addObject:listItem];
        }

        //将网络数据序列化到文件中
        [strongSelf _archiveListDataWithArray:listItemArray.copy];

        //在主线程中加载UI
        dispatch_async(dispatch_get_main_queue(), ^{
                           if (finishBlock) {
                               finishBlock(error == nil, listItemArray.copy);
                           }
                       });
    }];

    [dataTask resume];
}

#pragma mark - private method


/// 在本地文件中读取数据
- (NSArray<GTListItem *> *)_readDataFromLocal {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
    NSString *listDataPath = [cachePath stringByAppendingPathComponent:@"GTData/list"];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSData *readListData = [fileManager contentsAtPath:listDataPath];

    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class],[GTListItem class], nil]  fromData:readListData error:nil];
    
    if ([unarchiveObj isKindOfClass:[NSArray class]] && [unarchiveObj count] > 0) {
        return (NSArray<GTListItem *> *)unarchiveObj;
    }
    return nil;
}


/// 将数据序列化储存在文件中
/// @param array 包含数据到GTListItem数组
- (void)_archiveListDataWithArray:(NSArray<GTListItem *> *)array {
    
    //获取沙盒地址
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];

    //NSFileManager的使用
    NSFileManager *fileManager = [NSFileManager defaultManager];

    //创建GTData文件夹
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"GTData"];
    [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:nil];

    //创建list文件
    NSString *listDataPath = [dataPath stringByAppendingPathComponent:@"list"];

    //将对象数组序列化成数据流
    NSData *listData =  [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];

    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];

//    NSData *readistData = [fileManager contentsAtPath:listDataPath];

//    //将数据流反序列化成对象数组
//    id unarchiverObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [GTListItem class], nil] fromData:readistData error:nil];
//
//
//
//    //使用NSUserDefaults
//    [[NSUserDefaults standardUserDefaults] setObject:listData forKey:@"listData"];
//    NSData *test = [[NSUserDefaults standardUserDefaults] dataForKey:@"listData"];
//
//    id unarchiverObj2 = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [GTListItem class], nil] fromData:test error:nil];
//
//    NSLog(@"");
//

//    //查询文件
//    BOOL fileExist = [fileManager fileExistsAtPath:listDataPath];

    //删除文件
//    if(fileExist){
//        [fileManager removeItemAtPath:listDataPath error:nil];
//    }
    //
////NSFileManager的使用
//    NSFileHandle *fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:listDataPath];
//    [fileHandler seekToEndOfFile];
//    [fileHandler writeData:[@"def" dataUsingEncoding:NSUTF8StringEncoding]];
//
//    [fileHandler synchronizeFile];
//    [fileHandler closeFile];
}

@end
