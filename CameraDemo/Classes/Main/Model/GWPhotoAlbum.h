//
//  GWPhotoAlbum.h
//  CameraDemo
//
//  Created by will on 14/11/25.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//  相册模型，用来装相片分组
@class ALAssetsGroup;
#import <Foundation/Foundation.h>
/**
 *  相册模型
 */
@interface GWPhotoAlbum : NSObject
/**  某一相册里的所有照片，装的GWPhoto模型 */
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) UIImage *foreImage;
@property (nonatomic, copy) UIImage *backImage;
@property (nonatomic, copy) NSNumber *type;
@property (nonatomic, copy) NSString *persistentID;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, strong) ALAssetsGroup *assetsGruop;
@property (nonatomic, assign) NSInteger count;

/**
 *  用ALAssetsGroup来初始化模型
 */
- (instancetype)initWithAssetsGruop:(ALAssetsGroup *)assetsGruop;
@end
