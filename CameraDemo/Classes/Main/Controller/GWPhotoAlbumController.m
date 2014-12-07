//
//  GWPhotoAlbumController.m
//  CameraDemo
//
//  Created by will on 14/11/25.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import "GWPhotoAlbumController.h"
#import "GWPhotoViewController.h"
#import "GWPhotoAlbumTool.h"
#import "GWPhotoAlbum.h"
#import "GWPhotoAlbumViewCell.h"

static NSString *ID = @"identifierCollectionViewCell";

@interface GWPhotoAlbumController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *mCollectionView;
@property (nonatomic, strong) NSArray *mPhotoAlbums;
@end

@implementation GWPhotoAlbumController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.title = @"相薄";
    }
    return self;
}

- (NSArray *)mPhotoAlbums
{
    if (_mPhotoAlbums == nil)
    {
        self.mPhotoAlbums = [NSArray array];
    }
    return _mPhotoAlbums;
}

- (void)loadView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(kPhotoAlbumWith, kPhotoAlbumHeight);
    flowLayout.minimumInteritemSpacing = 2;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, iPhoneW, iPhoneH) collectionViewLayout:flowLayout];
    collectionView.alwaysBounceVertical = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerNib:[UINib nibWithNibName:@"GWPhotoAlbumViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    self.view = collectionView;
    self.mCollectionView = collectionView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.获取相册数据，遍历相册里的图片
    [GWPhotoAlbumTool fetchPhotoAlbumsWithType:ALAssetsGroupAll succes:^(NSArray *photoAlbums) {
        self.mPhotoAlbums = photoAlbums;
        [self.mCollectionView reloadData];
    } error:^(NSError *error) {
        MyLog(@"%@",error.localizedDescription);
    }];
}

#pragma mark - CollectioinView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.mPhotoAlbums.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GWPhotoAlbumViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[GWPhotoAlbumViewCell alloc] initWithFrame:CGRectMake(0, 0, kPhotoAlbumWith, kPhotoAlbumHeight)];
    }
    cell.photoAlbum = self.mPhotoAlbums[indexPath.row];
    return cell;
}

#pragma mark - CollectioinView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GWPhotoViewController *photoViewController = [[GWPhotoViewController alloc] init];
    photoViewController.photos = [self.mPhotoAlbums[indexPath.row] photos];
    [self.navigationController pushViewController:photoViewController animated:YES];
}
@end
