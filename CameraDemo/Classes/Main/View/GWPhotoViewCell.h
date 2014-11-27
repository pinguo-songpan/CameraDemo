//
//  GWPhotoViewCell.h
//  CameraDemo
//
//  Created by will on 14/11/26.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//
#define kPhotoW 90
#define kPhotoH 90

#import <UIKit/UIKit.h>
@class GWPhoto;
/**
 *  单张照片的cell
 */
@interface GWPhotoViewCell : UICollectionViewCell
@property (nonatomic, strong) UIButton *photoImageButton;
@property (nonatomic, strong) UIImageView *selectedView;
@property (nonatomic, strong) GWPhoto *photo;
@end
