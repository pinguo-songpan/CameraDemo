//
//  GWImageClipVIew.m
//  CameraDemo
//
//  Created by will on 14/11/30.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//
#define kCornerWidth 30
#define IMAGE_BOUNDRY_SPACE 0

#import "GWImageClipView.h"
#import "GWImageClipRectView.h"
#import "GWCornerView.h"
@interface GWImageClipView ()
@property (nonatomic, weak) UIImageView *mImageView;
@property (nonatomic, weak) GWImageClipRectView *mClipRectView;
@property (nonatomic, assign) CGPoint mBegainPoint;
@property (nonatomic, assign) CGPoint mClipRectViewCenterPoint; // 开始移动时clipRectView的center
@property (nonatomic, assign) CGFloat mScalingFactor; // 缩放比例
@property (nonatomic, assign) CGRect mBeginRect;
@property (nonatomic, assign) CGRect mMacRect;
@end

@implementation GWImageClipView
@synthesize clipRect = _clipRect;
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self buildUI:CGRectZero];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self buildUI:frame];
    }
    return self;
}

- (void)buildUI:(CGRect)rect
{
    self.backgroundColor = [UIColor darkGrayColor];
    
    // 1.添加需要被裁剪的图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    self.mImageView = imageView;
    
    // 2.添加裁剪框
    GWImageClipRectView *clipRectView = [[GWImageClipRectView alloc] init];
    [self.mImageView addSubview:clipRectView];
    self.mClipRectView = clipRectView;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    [self reLayoutView];
    _mImageView.image = image;
}
- (void) reLayoutView
{
    float imgWidth = _image.size.width;
    float imgHeight = _image.size.height;
    float viewWidth = self.bounds.size.width - 2 * IMAGE_BOUNDRY_SPACE;
    float viewHeight = self.bounds.size.height - 2 * IMAGE_BOUNDRY_SPACE;
    
    float widthRatio = imgWidth / viewWidth;
    float heightRatio = imgHeight / viewHeight;
    self.mScalingFactor = widthRatio > heightRatio ? widthRatio : heightRatio;
    
    self.mImageView.bounds = CGRectMake(0, 0, imgWidth / self.mScalingFactor, imgHeight/self.mScalingFactor);
    self.mImageView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    // 裁剪框默认截取范围
    self.mClipRectView.clipRect = self.mImageView.bounds;
    self.clipRect = self.mImageView.bounds;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint begainPoint = [touch locationInView:self.mImageView];
    
    self.mClipRectViewCenterPoint = self.mClipRectView.center;
    self.mBegainPoint = begainPoint;
    self.mBeginRect = self.mClipRectView.frame; // 记录下开始时clipRectView的位置
    
    id view = [self hitTest:begainPoint withEvent:event];
    NSLog(@"%@",[view class]);
    if ([view isKindOfClass:[GWImageClipRectView class]] || [view isKindOfClass:[GWCornerView class]])
    {
        self.mClipRectView.isMove = YES;
        NSLog(@"可以移动");
    }
    
    // 判断用户点击拖动裁剪框的哪个角落
    CGRect cornerLeftTopRect = CGRectMake(self.clipRect.origin.x - kCornerWidth / 2, self.clipRect.origin.y - kCornerWidth / 2, kCornerWidth, kCornerWidth);

    CGRect cornerRightTopRect = CGRectMake(CGRectGetMaxX(self.clipRect) - kCornerWidth / 2, self.clipRect.origin.y - kCornerWidth / 2, kCornerWidth, kCornerWidth);
    
    CGRect cornerLeftBottomRect = CGRectMake(self.clipRect.origin.x - kCornerWidth / 2, CGRectGetMaxY(self.clipRect) - kCornerWidth / 2, kCornerWidth, kCornerWidth);
    
    CGRect cornerRightBottomRect = CGRectMake(CGRectGetMaxX(self.clipRect) - kCornerWidth / 2, CGRectGetMaxY(self.clipRect) - kCornerWidth / 2, kCornerWidth, kCornerWidth);
    
    if (CGRectContainsPoint(cornerLeftTopRect, begainPoint))
    {
        self.mClipRectView.cornerType = CornerTypeLeftTop;
        NSLog(@"点击了左上角");
        self.mClipRectView.isMove = YES;
    }
    else if (CGRectContainsPoint(cornerRightTopRect, begainPoint))
    {
        self.mClipRectView.cornerType = CornerTypeRightTop;
        NSLog(@"点击了右上角");
        self.mClipRectView.isMove = YES;
    }
    else if (CGRectContainsPoint(cornerLeftBottomRect, begainPoint))
    {
        self.mClipRectView.cornerType = CornerTypeLeftBottom;
        NSLog(@"点击了左下角");
        self.mClipRectView.isMove = YES;
    }
    else if (CGRectContainsPoint(cornerRightBottomRect, begainPoint))
    {
        self.mClipRectView.cornerType = CornerTypeRightBottom;
        NSLog(@"点击了右下角");
        self.mClipRectView.isMove = YES;
    }
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (!self.mClipRectView.isMove)
    {
        return;
    }
    
    [super touchesMoved:touches withEvent:event];

    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.mImageView];
    // 计算位移 = 当前位置 - 起始位置
    CGPoint pointOffset = CGPointMake(currentPoint.x - self.mBegainPoint.x, currentPoint.y - self.mBegainPoint.y);
    
    // 计算移动后的中心点   原来视图的中心点 + 位移
    CGPoint newCenter = CGPointMake(self.mClipRectViewCenterPoint.x + pointOffset.x, self.mClipRectViewCenterPoint.y + pointOffset.y);
    
    /* 限制用户不可将视图托出屏幕 */
    
    float halfx = CGRectGetMidX(self.mClipRectView.bounds);
    //x坐标左边界
    newCenter.x = MAX(halfx, newCenter.x);
    //x坐标右边界
    newCenter.x = MIN(self.mImageView.frame.size.width - halfx, newCenter.x);
    
    //y坐标同理
    float halfy = CGRectGetMidY(self.mClipRectView.bounds);
    newCenter.y = MAX(halfy, newCenter.y);
    newCenter.y = MIN(self.mImageView.frame.size.height - halfy, newCenter.y);
    
    // 移动裁剪框
    self.mClipRectView.center = newCenter;
    
    self.clipRect = self.mClipRectView.frame;
    switch (self.mClipRectView.cornerType) {
        case CornerTypeLeftTop:
            self.mClipRectView.clipRect = CGRectMake(self.mBeginRect.origin.x + pointOffset.x, self.mBeginRect.origin.y + pointOffset.y, self.mBeginRect.size.width - pointOffset.x, self.mBeginRect.size.height - pointOffset.y);
            break;
        case CornerTypeRightTop:
            self.mClipRectView.clipRect = CGRectMake(self.mBeginRect.origin.x, self.mBeginRect.origin.y + pointOffset.y, self.mBeginRect.size.width + pointOffset.x, self.mBeginRect.size.height - pointOffset.y);
            break;
        case CornerTypeLeftBottom:
            self.mClipRectView.clipRect = CGRectMake(self.mBeginRect.origin.x + pointOffset.x, self.mBeginRect.origin.y, self.mBeginRect.size.width - pointOffset.x, self.mBeginRect.size.height + pointOffset.y);
            break;
        case CornerTypeRightBottom:
            self.mClipRectView.clipRect = CGRectMake(self.mBeginRect.origin.x, self.mBeginRect.origin.y, self.mBeginRect.size.width + pointOffset.x, self.mBeginRect.size.height + pointOffset.y);
            break;
        default:
            self.mClipRectView.center = newCenter;
            break;
    }
    [self.mClipRectView setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.mClipRectView.isMove = NO;
    self.mClipRectView.cornerType = CornerTypeMoveCenter;
}

- (void)setClipRect:(CGRect)clipRect
{
    _clipRect = clipRect;
    _mClipRectView.clipRect = clipRect;
}

- (UIImage *)clipImage
{
    CGRect imageRect = CGRectMake(_clipRect.origin.x * _image.scale * self.mScalingFactor,
                                  _clipRect.origin.y * _image.scale * self.mScalingFactor,
                                  _clipRect.size.width * _image.scale * self.mScalingFactor,
                                  _clipRect.size.height * _image.scale * self.mScalingFactor);

    
    CGImageRef imageRef = CGImageCreateWithImageInRect([_image CGImage], imageRect);
    UIImage *result = [UIImage imageWithCGImage:imageRef
                                          scale:_image.scale
                                    orientation:_image.imageOrientation];
    CGImageRelease(imageRef);
    
    return result;
}


#pragma mark - 懒加载设置默认值
- (CGRect)clipRect
{
    if (CGRectEqualToRect(_clipRect, CGRectZero)) {
        self.clipRect = kDefaultClipRect;
    }
    return _clipRect;
}

- (CGFloat)mScalingFactor
{
    if (_mScalingFactor == 0.0) {
        self.mScalingFactor = 1.0;
    }
    return _mScalingFactor;
}



@end
