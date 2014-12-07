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

#pragma mark -  私有方法
+ (void)fetchPhotoAlbumWithType:(ALAssetsGroupType)groupType succes:(PhotoAlbumSuccessBlock)success error:(PhotoAlbumFailureBlock)errorBlock
{
    GWPhotoAlbumTool *photoAlbumTool = [GWPhotoAlbumTool sharePhotoAlbumTool];
    [photoAlbumTool.assetsLibrary enumerateGroupsWithTypes:groupType usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        GWPhotoAlbum *photoAlbum = [[GWPhotoAlbum alloc] initWithAssetsGruop:group];
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

+ (void)saveImage:(UIImage*)image toAlbum:(NSString*)albumName failure:(SaveImageFailureBlock)failureBlock
{
     GWPhotoAlbumTool *photoAlbumTool = [GWPhotoAlbumTool sharePhotoAlbumTool];
    [photoAlbumTool.assetsLibrary writeImageToSavedPhotosAlbum:image.CGImage orientation:(ALAssetOrientation)image.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error) {
        if (error)
        {
            failureBlock(error);
            return;
        }
        [GWPhotoAlbumTool addAssetURL:assetURL toAlbum:albumName failure:^(NSError *error) {
            
        }];
    }];
}

+ (void)addAssetURL:(NSURL*)assetURL toAlbum:(NSString*)albumName failure:(SaveImageFailureBlock)failureBlock
{
    __weak ALAssetsLibrary *assetsLibrary = [GWPhotoAlbumTool sharePhotoAlbumTool].assetsLibrary;
     __block BOOL isNotFind = YES;
    
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if ([albumName compare:[group valueForProperty:ALAssetsGroupPropertyName]] == NSOrderedSame)
        {
            *stop = YES;
            isNotFind = NO; // 找到同名相册
            [assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                [group addAsset:asset];
            } failureBlock:^(NSError *error) {
                if (failureBlock)
                {
                    failureBlock(error);
                }
            }];
        }
        // 遍历结束且没找到有同名相册时 新建相册
        if (group == nil && isNotFind)
        {
            [assetsLibrary addAssetsGroupAlbumWithName:albumName resultBlock:^(ALAssetsGroup *newgroup) {
                [assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                    // 增加照片到新建相册
                    [newgroup addAsset:asset];
                } failureBlock:^(NSError *error) {
                    if (failureBlock)
                    {
                        failureBlock(error);
                    }
                }];
            } failureBlock:^(NSError *error) {
                if (failureBlock)
                {
                    failureBlock(error);
                }
            }];
        }
 
    } failureBlock:^(NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

@end
