//
//  GWPhotoViewController.m
//  CameraDemo
//
//  Created by will on 14/11/26.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//
#define kIdentifier  @"Identifier"
#define kMaxPhotoNumber 10

#import "GWPhotoViewController.h"
#import "GWPhotoEditViewController.h"
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
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
        [self.navigationItem setRightBarButtonItem:rightItem];
    }
    return self;
}

- (NSMutableArray *)selectedPhotos
{
    if (_selectedPhotos == nil)
    {
        self.selectedPhotos = [NSMutableArray array];
    }
    return _selectedPhotos;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
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
    [cell.photoImageButton addTarget:self action:@selector(photoButtonPress:event:) forControlEvents:UIControlEventTouchUpInside];
    cell.photo = self.photos[indexPath.row];
    return cell;
}

- (void)photoButtonPress:(UIButton *)button event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.mCollectionView];
    NSIndexPath *indexPath = [self.mCollectionView indexPathForItemAtPoint:currentTouchPosition];
    
    if (indexPath)
    {
        GWPhoto *photo = self.photos[indexPath.row];
        
        if (self.selectedPhotos.count < kMaxPhotoNumber || photo.isSelected)
        {
            photo.isSelected = !photo.isSelected;
            if (photo.isSelected)
            {
                [self.selectedPhotos addObject:photo];
            }
            else
            {
                [self.selectedPhotos removeObject:photo];
            }
            
            [self.mCollectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        }
        else
        {
            NSString *msg = [NSString stringWithFormat:@"最多只能上传%d张图片！", kMaxPhotoNumber];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}

- (void)rightItemClick:(UIButton *)button
{
    if (self.selectedPhotos > 0)
    {
        GWPhotoEditViewController *photoEdit = [[GWPhotoEditViewController alloc] init];
        photoEdit.photo = self.selectedPhotos.firstObject;
        [self.navigationController pushViewController:photoEdit animated:YES];
    }
}

- (void)dealloc
{
    for (GWPhoto *p in self.selectedPhotos) {
        p.isSelected = NO;
    }
}

@end
