//
//  GWPhotoAlbum.h
//  CameraDemo
//
//  Created by will on 14/11/25.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//  相册模型，用来装相片分组

#import <Foundation/Foundation.h>

@interface GWPhotoAlbum : NSObject
/**  某一相册里的所有照片，装的GWPhoto模型 */
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) UIImage *posterImage;
@property (nonatomic, copy) NSNumber *type;
@property (nonatomic, copy) NSString *persistentID;
@property (nonatomic, copy) NSURL *url;
@end
