//
//  GWPhoto.h
//  CameraDemo
//
//  Created by will on 14/11/25.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//  单张相片模型

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface GWPhoto : NSObject

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, copy) UIImage *imageSmail;

- (id)initWithAsset:(ALAsset *)asset;
@end
