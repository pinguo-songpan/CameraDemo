//
//  GWPhoto.h
//  CameraDemo
//
//  Created by will on 14/11/25.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
/**
 *  单张相片模型
 */
@interface GWPhoto : NSObject

@property (nonatomic, assign) BOOL isSelected;

/**
 *  小图
 */
@property (nonatomic, copy) UIImage *imageSmail;

/**
 *  原图
 */
@property (nonatomic, copy) UIImage *imageSource;

/**
 *  用ALAsset初始化模型
 */
- (id)initWithAsset:(ALAsset *)asset;
@end
