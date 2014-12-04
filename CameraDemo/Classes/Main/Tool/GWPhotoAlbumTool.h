//
//  GWPhotoAlbumTool.h
//  CameraDemo
//
//  Created by will on 14/11/26.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

@class GWPhotoAlbum;

typedef void (^PhotoAlbumsSuccessBlock)(NSArray *photoAlbums);
typedef void (^PhotoAlbumsFailureBlock)(NSError *error);

typedef void (^PhotoAlbumSuccessBlock)(GWPhotoAlbum *photoAlbum);
typedef void (^PhotoAlbumFailureBlock)(NSError *error);

typedef void(^SaveImageFailureBlock)(NSError* error);

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

/**
 *  相册工具类
 */
@interface GWPhotoAlbumTool : NSObject

@property (nonatomic, strong, readonly) ALAssetsLibrary *assetsLibrary;

/**
 *  创建一个相册工具类单例对象
 */
+ (instancetype)sharePhotoAlbumTool;

/**
 *  获取需要的相册
 *
 *  @param groupType  资源组的数据类型，参数不能为空
 *  @param success    成功的Block
 *  @param errorBlock 失败的Block
 */
+ (void)fetchPhotoAlbumsWithType:(ALAssetsGroupType)groupType succes:(PhotoAlbumsSuccessBlock)success error:(PhotoAlbumsFailureBlock)errorBlock;
/**
 *  保存图片到指定的相册
 *
 *  @param image           需要保存的图片
 *  @param albumName       相册名称
 *  @param saveFailureBlock 保存失败的Block
 */
+ (void)saveImage:(UIImage*)image toAlbum:(NSString*)albumName failure:(SaveImageFailureBlock)failureBlock;

/**
 *  保存指定的AssertURL到指定相册
 *
 *  @param assetURL     assetURL
 *  @param albumName    相册名称
 *  @param failureBlock 保存失败的Block
 */
+ (void)addAssetURL:(NSURL*)assetURL toAlbum:(NSString*)albumName failure:(SaveImageFailureBlock)failureBlock;

@end
