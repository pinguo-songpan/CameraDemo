//
//  GWImageClipVIew.h
//  CameraDemo
//
//  Created by will on 14/11/30.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  图像裁剪视图，用于显示要被裁剪的图片
 */
@interface GWImageClipView : UIView

/** 被裁减和显示出来的的UIImage */
@property (nonatomic, strong) UIImage *image;
/** 显示出来的裁剪框的范围 */
@property (nonatomic, assign) CGRect clipRect;
/** 真实的图片裁减范围 */
@property (nonatomic, assign) CGRect trueClipRect;

/**
 *  按照裁剪框的范围裁剪源图片
 */
- (UIImage *)clipImage;
@end
