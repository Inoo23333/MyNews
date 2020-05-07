//
//  ViewController.m
//  SampleApp
//
//  Created by user on 2020/1/19.
//  Copyright © 2020 user. All rights reserved.
//

#import "GTNewsViewController.h"
#import "GTNormalTableViewCell.h"
#import "GTDeleteCellView.h"
#import "GTListLoader.h"
#import "GTListItem.h"
#import "GTSearchBar.h"
#import "GTDetailViewController.h"


@interface GTNewsViewController ()<UITableViewDataSource,UITableViewDelegate,GTNormalTableViewCellDelegate>

@property(nonatomic,strong,readwrite)UITableView *tableView;
@property(nonatomic,strong,readwrite)NSArray *dataArray;
@property(nonatomic,strong,readwrite)GTListLoader *listLoader;

@end

@implementation GTNewsViewController



#pragma mark - life cycle
-(instancetype) init{
    self = [super init];
    if(self){
        
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)newsTitle{
    self = [super init];
    if(self){
        _newsTitle = newsTitle;
        self.listLoader = [[GTListLoader alloc]initWithTitle:_newsTitle];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    self.listLoader = [[GTListLoader alloc]initWithTitle:_newsTitle];

    
    __weak typeof(self) wself = self;
    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<GTListItem *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        strongSelf.dataArray = dataArray;
        [strongSelf.tableView reloadData];
        NSLog(@"");
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9];
    [self.tabBarController.navigationItem setTitleView:({
        GTSearchBar *searchBar = [[GTSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, self.navigationController.navigationBar.bounds.size.height)];
        searchBar;
        
        //拉起键盘和输入框
//        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - UI(20), self.navigationController.navigationBar.bounds.size.height)];
//        button.backgroundColor = [UIColor lightGrayColor];
//        [button addTarget:self action:@selector(_showCommentView) forControlEvents:UIControlEventTouchUpInside];
//        button;
    })];
}

#pragma mark -UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"100");
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectRowAtIndexPath");
    GTListItem *item = [self.dataArray objectAtIndex:indexPath.row];
    
    GTDetailViewController *controller = [[GTDetailViewController alloc]initWithUrlString:item.url];
    controller.title = _newsTitle;
    [self.navigationController pushViewController:controller animated:NO];
    
//    [GTMediator openUrl:@"detail" params:@{@"url":item.articleUrl,@"controller":self.navigationController}];
    
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:item.uniqueKey];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"15");
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GTNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    
    if(!cell){
        cell = [[GTNormalTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        cell.delegate = self;
    }
    
    GTListItem *item = [[GTListItem alloc]init];
    item = [self.dataArray objectAtIndex:indexPath.row];
    [cell layoutGTNormalTableViewCellWithItem:item];

    NSLog(@"");
    return cell;
}

//- (void)pushController{
//    UIViewController *v = [[UIViewController alloc]init];
//    v.view.backgroundColor = [UIColor whiteColor];
//    v.navigationItem.title = @"内容";
//    v.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"右侧标题"
//                                                                          style:UIBarButtonItemStylePlain target:self action:nil];
//    [self.navigationController pushViewController:v animated:YES];
//}

#pragma mark - GTNormalTableViewCellDelegate
-(void)deleteTableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton{
    GTDeleteCellView *deleteView = [[GTDeleteCellView alloc]initWithFrame:self.view.bounds];
    CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];
    
    __weak typeof(self) wself = self;
    [deleteView showDeleteViewFromPoint:rect.origin clickBlock:^{
         __strong typeof(wself) strongSelf = wself;
               NSIndexPath *delIndexPath = [strongSelf.tableView indexPathForCell:tableViewCell];
               if (strongSelf.dataArray.count > delIndexPath.row) {
                   //删除数据
                   NSMutableArray *dataArrayTmp = [strongSelf.dataArray mutableCopy];
                   [dataArrayTmp removeObjectAtIndex:delIndexPath.row];
                   strongSelf.dataArray = [dataArrayTmp copy];
                   //删除cell
                   [strongSelf.tableView deleteRowsAtIndexPaths:@[delIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
               }
    }];
    NSLog(@"deleteTableViewCell 2");
}


@end
