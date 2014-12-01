//
//  GWImageClipRectView.h
//  CameraDemo
//
//  Created by will on 14/11/30.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kDefaultClipRect CGRectMake(50, 100, 100, 100)
/**
 *  图像裁剪框，用于显示裁剪图片范围
 */
@interface GWImageClipRectView : UIView
{
    CGRect _clipRect;  // 截取范围
}

/**
 *  可控手柄的颜色
 */
@property (nonatomic, strong) UIColor *cornerColor;

/**
 *  设置截取范围
 */
- (void)setClipRect:(CGRect)clipRect;

/**
 *  获取截取范围
 */
- (CGRect)clipRect;
@end
