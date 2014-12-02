//
//  GWImageClipVIew.h
//  CameraDemo
//
//  Created by will on 14/11/30.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWImageClipView : UIView
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGRect clipRect;

/**
 *  按照裁剪框的范围裁剪图片
 */
- (UIImage *)clipImage;
@end
