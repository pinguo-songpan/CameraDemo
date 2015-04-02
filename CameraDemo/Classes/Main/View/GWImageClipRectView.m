//
//  GWImageClipRectView.m
//  CameraDemo
//
//  Created by will on 14/11/30.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//
#define kCornerWidth 30  // 可触控的边界点范围

#import "GWImageClipRectView.h"
#import "GWCornerView.h"

@interface GWImageClipRectView ()
@property (nonatomic, weak) GWCornerView *mLeftTopCorner;
@property (nonatomic, weak) GWCornerView *mRightTopCorner;
@property (nonatomic, weak) GWCornerView *mLeftBottomCorner;
@property (nonatomic, weak) GWCornerView *mRightBottomCorner;
@property (nonatomic, strong) NSMutableArray *mCorners;
@end

@implementation GWImageClipRectView
@synthesize clipRect = _clipRect;
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self buildUI];
        
    }
    return self;
}

- (void)setClipRect:(CGRect)clipRect
{
    _clipRect = clipRect;
    self.frame = clipRect;
    [self updateCornersFrame];
    [self updateCornerRect];
    [self setNeedsDisplay];
}

// 懒加载clipRect 如果Size为（0,0）会设置一个初始值
- (CGRect)clipRect
{
    if (CGRectEqualToRect(_clipRect, CGRectZero)) {
        self.clipRect  = kDefaultClipRect;
    }
    return _clipRect;
}

- (void)setCornerColor:(UIColor *)cornerColor
{
    _cornerColor = cornerColor;
    for (UIView *corner in self.mCorners) {
        corner.backgroundColor = cornerColor;
    }
}

- (NSMutableArray *)mCorners
{
    if (_mCorners == nil) {
        _mCorners = [NSMutableArray array];
    }
    
    return _mCorners;
}

- (void)buildUI
{
    // 初始化控制柄
    GWCornerView *leftTopCorner = [[GWCornerView alloc] init];
    self.mLeftTopCorner = leftTopCorner;
    
    GWCornerView *rightTopCorner = [[GWCornerView alloc] init];
    self.mRightTopCorner = rightTopCorner;
    
    GWCornerView *leftBottomCorner = [[GWCornerView alloc] init];
    self.mLeftBottomCorner = leftBottomCorner;
    
    GWCornerView *rightBottomCorner = [[GWCornerView alloc] init];
    self.mRightBottomCorner = rightBottomCorner;
    
    [self.mCorners addObject:leftTopCorner];
    [self.mCorners addObject:rightTopCorner];
    [self.mCorners addObject:leftBottomCorner];
    [self.mCorners addObject:rightBottomCorner];
    
    for (UIView *corner in self.mCorners) {
        [self addSubview:corner];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateCornersFrame];
}

#pragma mark 更新可触控手柄范围
/**
 *  更新可触控手柄范围
 */
- (void)updateCornerRect
{
    _cornerLeftTopRect = CGRectMake(_clipRect.origin.x - kCornerWidth / 2, _clipRect.origin.y - kCornerWidth / 2, kCornerWidth, kCornerWidth);
    
    _cornerRightTopRect = CGRectMake(CGRectGetMaxX(_clipRect) - kCornerWidth / 2, _clipRect.origin.y - kCornerWidth / 2, kCornerWidth, kCornerWidth);
    
    _cornerLeftBottomRect = CGRectMake(_clipRect.origin.x - kCornerWidth / 2, CGRectGetMaxY(_clipRect) - kCornerWidth / 2, kCornerWidth, kCornerWidth);
    
    _cornerRightBottomRect = CGRectMake(CGRectGetMaxX(_clipRect) - kCornerWidth / 2, CGRectGetMaxY(_clipRect) - kCornerWidth / 2, kCornerWidth, kCornerWidth);
}

/**
 *  更新控制柄的显示范围
 */
- (void)updateCornersFrame
{
    CGFloat width = CGRectGetWidth(self.clipRect);
    CGFloat height = CGRectGetHeight(self.clipRect);
    
    self.mLeftTopCorner.center = CGPointZero;
    self.mLeftBottomCorner.center = CGPointMake(0, height);
    self.mRightTopCorner.center = CGPointMake(width, 0);
    self.mRightBottomCorner.center = CGPointMake(width, height);
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    [[UIColor whiteColor] setStroke];
    CGFloat lengths[2];
    lengths[0] = 0.0;
    lengths[1] = 4.0;
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, 4.0);
    
    CGRect strokeRect = CGRectMake(0, 0, self.clipRect.size.width, self.clipRect.size.height);
    CGRect strokeRect2 = CGRectMake(self.clipRect.size.width / 4, 0, self.clipRect.size.width / 2, self.clipRect.size.height);
    CGRect strokeRect3  = CGRectMake(0, self.clipRect.size.height / 4, self.clipRect.size.width, self.clipRect.size.height / 2);

    CGContextStrokeRect(ctx, strokeRect);
    CGContextSetLineDash(ctx, 0.0f, lengths, 2);
    CGContextStrokeRectWithWidth(ctx, strokeRect2, 1);
    CGContextStrokeRectWithWidth(ctx, strokeRect3, 1);
    
    UIGraphicsEndImageContext();
}
@end
