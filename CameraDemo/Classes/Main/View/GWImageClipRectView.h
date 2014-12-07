//
//  GWImageClipRectView.h
//  CameraDemo
//
//  Created by will on 14/11/30.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kDefaultClipRect CGRectMake(0, 0, 100, 100)

typedef enum : NSUInteger {
    CornerTypeMoveCenter  = 0,
    CornerTypeLeftTop     = 1,
    CornerTypeRightTop    = 2,
    CornerTypeLeftBottom  = 3,
    CornerTypeRightBottom = 4,
    CornerTypeNoPoint     = 5
} CornerType;

/**
 *  图像裁剪框，用于显示裁剪图片范围
 */
@interface GWImageClipRectView : UIView
{
    CGRect _clipRect;  // 截取范围
}

/**
 *  控制柄类型
 */
@property (nonatomic, assign) CornerType cornerType;

/**
 *  可控手柄的颜色
 */
@property (nonatomic, strong) UIColor *cornerColor;

/**
 *  裁剪框是否可以移动
 */
@property (nonatomic, assign) BOOL isMove;

/**
 *  截取范围
 */
@property (nonatomic, assign) CGRect clipRect;

/**
 *  左上角控制柄范围
 */
@property (nonatomic, assign) CGRect cornerLeftTopRect;

/**
 *  右上角控制柄范围
 */
@property (nonatomic, assign) CGRect cornerRightTopRect;

/**
 *  左下角控制柄范围
 */
@property (nonatomic, assign) CGRect cornerLeftBottomRect;

/**
 *  右上角控制柄范围
 */
@property (nonatomic, assign) CGRect cornerRightBottomRect;

@end
