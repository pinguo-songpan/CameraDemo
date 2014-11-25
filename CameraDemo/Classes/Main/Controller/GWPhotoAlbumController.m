//
//  GWPhotoAlbumController.m
//  CameraDemo
//
//  Created by will on 14/11/25.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import "GWPhotoAlbumController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "GWPhotoAlbum.h"
#import "GWPhoto.h"

@interface GWPhotoAlbumController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *mTableView;
@end

@implementation GWPhotoAlbumController

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
    ALAssetsLibrary *assetsLibray = [[ALAssetsLibrary alloc] init];
    [assetsLibray enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        GWPhotoAlbum *photoAlbum = [[GWPhotoAlbum alloc] initWithGroup:group];
        photoAlbum.name = [group valueForProperty:ALAssetsGroupPropertyName];
        photoAlbum.posterImage = [[UIImage alloc] initWithCGImage:group.posterImage];
        photoAlbum.type = [group valueForProperty:ALAssetsGroupPropertyType];
        photoAlbum.persistentID = [group valueForProperty:ALAssetsGroupPropertyPersistentID];
        photoAlbum.URL = [group valueForProperty:ALAssetsGroupPropertyURL];
        
        [group enumerateAssetsUsingBlock:^(ALAsset *resultAlAsset, NSUInteger index, BOOL *stop) {
            NSString *assetType = [resultAlAsset valueForProperty:ALAssetPropertyType];
            if ([assetType isEqualToString:ALAssetTypePhoto]) {
                GWPhoto *photo = [[GWPhoto alloc] initWithAsset:resultAlAsset];
                [photoAlbum.photos addObject:photo];
            }
            if (index == group.numberOfAssets-1) {
                *stop = YES;
            }
        }];
        NSLog(@"%@",photoAlbum);
        
    } failureBlock:^(NSError *error) {
        
    }];
    
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%li行",(long)indexPath.row];
    
    return cell;
}
@end
