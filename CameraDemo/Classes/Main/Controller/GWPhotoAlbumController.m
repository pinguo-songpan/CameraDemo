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
#import "GWPhoto.h"

@interface GWPhotoAlbumController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *mTableView;
@property (nonatomic, strong) NSArray *mPhotoAlbums;
@end

@implementation GWPhotoAlbumController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"相薄";
    }
    return self;
}

- (void)setPhotoAlbums:(NSMutableArray *)photoAlbums
{
    if (_mPhotoAlbums == nil) {
        _mPhotoAlbums = [NSMutableArray array];
    }
    _mPhotoAlbums = photoAlbums;
}

- (void)loadView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneW, iPhoneH)];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    self.view = tableView;
    self.mTableView = tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.遍历相册里的图片
    [GWPhotoAlbumTool fetchPhotoAlbumsWithType:ALAssetsGroupAll succes:^(NSArray *photoAlbums) {
        self.mPhotoAlbums = photoAlbums;
        [self.mTableView reloadData];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mPhotoAlbums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    GWPhotoAlbum *photoAlbum = self.mPhotoAlbums[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@  %lu张",photoAlbum.name,(unsigned long)photoAlbum.photos.count];
    cell.imageView.image = photoAlbum.posterImage;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    GWPhotoViewController *photoViewController = [[GWPhotoViewController alloc] init];
    GWPhotoAlbum *photoAlbum = self.mPhotoAlbums[indexPath.row];
    photoViewController.photos = photoAlbum.photos;
    [self.navigationController pushViewController:photoViewController animated:YES];
}
@end
