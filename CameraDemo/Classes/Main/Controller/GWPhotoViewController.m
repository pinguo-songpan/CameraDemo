//
//  GWPhotoViewController.m
//  CameraDemo
//
//  Created by will on 14/11/26.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//
#define kIdentifier  @"Identifier"

#import "GWPhotoViewController.h"
#import "GWPhotoViewCell.h"
#import "GWPhoto.h"

@interface GWPhotoViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *mCollectionView;

@end

@implementation GWPhotoViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.title = @"照片";
        self.view.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}
- (void)viewDidLoad
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2;
    layout.itemSize = CGSizeMake(kPhotoW, kPhotoH);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, iPhoneW, iPhoneH) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.alwaysBounceVertical = YES;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[GWPhotoViewCell class] forCellWithReuseIdentifier:kIdentifier];
    [self.view addSubview:collectionView];
    self.mCollectionView = collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = kIdentifier;
    GWPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[GWPhotoViewCell alloc] initWithFrame:CGRectMake(0, 0, kPhotoW, kPhotoH)];
    }
    cell.photo = self.photos[indexPath.row];
    return cell;
}
@end
