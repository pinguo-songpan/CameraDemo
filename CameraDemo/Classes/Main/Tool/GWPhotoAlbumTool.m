//
//  GWPhotoAlbumTool.m
//  CameraDemo
//
//  Created by will on 14/11/26.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import "GWPhotoAlbumTool.h"
#import "GWPhotoAlbum.h"
#import "GWPhoto.h"

static GWPhotoAlbumTool *_instance = nil;
@interface GWPhotoAlbumTool ()

@end

@implementation GWPhotoAlbumTool

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharePhotoAlbumTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return self;
}

+ (void)fetchPhotoAlbumsWithType:(ALAssetsGroupType)groupType succes:(PhotoAlbumsSuccessBlock)success error:(PhotoAlbumsFailureBlock)errorBlock
{
    NSMutableArray *photoAlbums = [NSMutableArray array];
    [GWPhotoAlbumTool fetchPhotoAlbumWithType:groupType succes:^(GWPhotoAlbum *photoAlbum) {
        if (photoAlbum.name != nil)
        {
            [photoAlbums addObject:photoAlbum];
        }
        if (success!=nil && photoAlbum.name == nil)
        {
            success(photoAlbums);
        }
    } error:^(NSError *error) {
        if (errorBlock)
        {
            errorBlock(error);
        }
    }];
}

#pragma mark - 私有方法
+ (void)fetchPhotoAlbumWithType:(ALAssetsGroupType)groupType succes:(PhotoAlbumSuccessBlock)success error:(PhotoAlbumFailureBlock)errorBlock
{
    GWPhotoAlbumTool *photoAlbumTool = [GWPhotoAlbumTool sharePhotoAlbumTool];
    [photoAlbumTool.assetsLibrary enumerateGroupsWithTypes:groupType usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        GWPhotoAlbum *photoAlbum = [[GWPhotoAlbum alloc] init];
        photoAlbum.name = [group valueForProperty:ALAssetsGroupPropertyName];
        photoAlbum.posterImage = [[UIImage alloc] initWithCGImage:group.posterImage];
        photoAlbum.type = [group valueForProperty:ALAssetsGroupPropertyType];
        photoAlbum.persistentID = [group valueForProperty:ALAssetsGroupPropertyPersistentID];
        photoAlbum.url = [group valueForProperty:ALAssetsGroupPropertyURL];
        NSMutableArray *photos = [NSMutableArray array];
        [group enumerateAssetsUsingBlock:^(ALAsset *resultAlAsset, NSUInteger index, BOOL *stop) {
            if (index == group.numberOfAssets-1)
            {
                *stop = YES;
            }
            NSString *assetType = [resultAlAsset valueForProperty:ALAssetPropertyType];
            if ([assetType isEqualToString:ALAssetTypePhoto])
            {
                GWPhoto *photo = [[GWPhoto alloc] initWithAsset:resultAlAsset];
                [photos addObject:photo];
            }
        }];
        photoAlbum.photos = photos;
            if (success)
            {
                success(photoAlbum);
            }
    } failureBlock:^(NSError *error){
        if (error)
        {
            errorBlock(error);
        }
    }];
}

@end
