//
//  GWPhotoAlbumViewCell.h
//  CameraDemo
//
//  Created by will on 14/11/27.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//
#define kPhotoAlbumWith 120
#define kPhotoAlbumHeight 140
#import <UIKit/UIKit.h>
@class GWPhotoAlbum;
/**
 *  自定义单个相册Cell
 */
@interface GWPhotoAlbumViewCell : UICollectionViewCell
@property (nonatomic, copy) GWPhotoAlbum *photoAlbum;
@end
