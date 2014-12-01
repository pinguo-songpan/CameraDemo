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
typedef enum : NSUInteger {
    CornerTypeLeftTop     = 0,
    CornerTypeRightTop    = 1,
    CornerTypeLeftBottom  = 2,
    CornerTypeRightBottom = 3,
    CornerTypeMoveCenter  = 4,
    CornerTypeNoPoint     = 1
} CornerType;

@interface GWImageClipView : UIView
{
    CGRect _translatedClipRect;
    CGPoint _lastMovePoint;

    
}
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGRect clipRect;
@end
