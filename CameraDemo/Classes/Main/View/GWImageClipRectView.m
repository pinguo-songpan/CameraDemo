//
//  GWImageClipRectView.m
//  CameraDemo
//
//  Created by will on 14/11/30.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//
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

#pragma mark 更新控制柄的Frame
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
    
    CGContextSetRGBFillColor(ctx,   0.0, 0.0, 0.0, 0.7);
//    CGContextSetRGBStrokeColor(ctx, 0.6, 0.6, 0.6, 1.0);
    [[UIColor whiteColor] setStroke];
    CGFloat lengths[2];
    lengths[0] = 0.0;
    lengths[1] = 10.0;
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, 3.0);
    CGContextSetLineDash(ctx, 0.0f, lengths, 2);
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
//    CGRect clipsRectS[] =
//    {
//        CGRectMake(0, 0, width, self.clipRect.origin.y),
//        CGRectMake(0, self.clipRect.origin.y, self.clipRect.origin.x, self.clipRect.size.height),
//        CGRectMake(0, self.clipRect.origin.y + self.clipRect.size.height, width, height - (self.clipRect.origin.y + self.clipRect.size.height)),
//        CGRectMake(self.clipRect.origin.x + self.clipRect.size.width, self.clipRect.origin.y, width -(self.clipRect.origin.x + self.clipRect.size.width), self.clipRect.size.height),
//    };

//    CGContextClipToRects(ctx, clipsRectS, sizeof(clipsRectS) / sizeof(clipsRectS[0]));
    
    CGRect strokeRect = CGRectMake(0, 0, self.clipRect.size.width, self.clipRect.size.height);
//    CGContextFillRect(ctx, rect);
    CGContextStrokeRect(ctx, strokeRect);
    UIGraphicsEndImageContext();
}
@end
