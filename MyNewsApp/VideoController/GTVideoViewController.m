//
//  GTVideoViewController.m
//  SampleApp1
//
//  Created by user on 2020/2/18.
//  Copyright © 2020 user. All rights reserved.
//

#import "GTVideoViewController.h"
#import "GTVideoCoverView.h"
#import "GTVideoToolbar.h"


@interface GTVideoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation GTVideoViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"视频";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/video@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/video_selected@2x.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width / 16 * 9 + GTVideoToolbarHeight );

    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];

    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor blackColor];
    [collectionView  registerClass:[GTVideoCoverView class]
        forCellWithReuseIdentifier:@"GTVideoCoverView"];

    [self.view addSubview:collectionView];
    // Do any additional setup after loading the view.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GTVideoCoverView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GTVideoCoverView" forIndexPath:indexPath];

    if ([cell isKindOfClass:[GTVideoCoverView class]]) {
        [cell layoutWithVideoCoverUrl:@"icon.bundle/videoCover.png" videoUrl:@"http://flv.bn.netease.com/videolib3/1611/02/ECURs3951/SD/ECURs3951-mobile.mp4"];
    }

    return cell;
}

/*
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.item % 3 == 0){
//        return CGSizeMake(self.view.frame.size.width, 100);
//    }
//    else{
//        return CGSizeMake((self.view.frame.size.width - 10)/2, 300);
//    }
//}

@end
