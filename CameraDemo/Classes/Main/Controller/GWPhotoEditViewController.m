//
//  GWPhotoEditViewController.m
//  CameraDemo
//
//  Created by will on 14/11/27.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import "GWPhotoEditViewController.h"
#import "GWImageClipView.h"
#import "GWPhoto.h"
#import "GWPhotoAlbumTool.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import "GWPhotoAlbumTool.h"

@interface GWPhotoEditViewController ()
@property (nonatomic, weak) UIToolbar   *mToolBar;
@property (nonatomic, weak) UIImageView *mImageView;
@property (nonatomic, copy) UIImage *mOldImage;  // 裁剪前的图片
@property (nonatomic, weak) UIButton *mClipDoneBtn;
@property (nonatomic, weak) UIButton *mRectEffectBtn; // 矩形滤镜按钮
@property (nonatomic, weak) GWImageClipView *mImageClipView;

@end

@implementation GWPhotoEditViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.title = @"图片编辑";
        self.view.backgroundColor = [UIColor whiteColor];
        
        [self buildUI];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)buildUI
{
    // 显示的图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 64+10, iPhoneW-20, iPhoneH-64-44-20)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    self.mImageView = imageView;
    
    // 可被裁剪的图片
    GWImageClipView *imageClipView = [[GWImageClipView alloc] initWithFrame:imageView.frame];
    imageClipView.hidden = YES;
    [self.view addSubview:imageClipView];
    self.mImageClipView = imageClipView;
    
    // 添加工具栏
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    toolBar.frame = CGRectMake(0, iPhoneH-44, iPhoneW, 44);
    
    UIBarButtonItem *rectClip = [[UIBarButtonItem alloc] initWithTitle:@"矩形裁剪" style:UIBarButtonItemStylePlain target:self action:@selector(rectClipPressed:)];
    UIBarButtonItem *rectEffect = [[UIBarButtonItem alloc] initWithTitle:@"矩形滤镜" style:UIBarButtonItemStylePlain target:self action:@selector(rectEffectPressed:)];
    UIBarButtonItem *circleEffect = [[UIBarButtonItem alloc] initWithTitle:@"圆形滤镜" style:UIBarButtonItemStylePlain target:self action:@selector(circleEffectPressed:)];
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(savePressed:)];
    UIBarButtonItem *fix1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *fix2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.navigationItem.rightBarButtonItem = save;
    
    toolBar.items = @[rectClip,fix1,rectEffect, fix2, circleEffect];
    [self.view addSubview:toolBar];
    self.mToolBar = toolBar;
    
    // 裁剪完成按钮
    UIButton *clipDoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clipDoneBtn.backgroundColor = [UIColor blueColor];
    clipDoneBtn.frame = CGRectMake(iPhoneW - 80, iPhoneH, 80, 40);
    [clipDoneBtn setTitle:@"保存裁减" forState:UIControlStateNormal];
    [clipDoneBtn addTarget:self action:@selector(clipDonePressed:) forControlEvents:UIControlEventTouchUpInside];

    [self.view insertSubview:clipDoneBtn belowSubview:self.mToolBar];
    self.mClipDoneBtn = clipDoneBtn;
    
    // 保存效果按钮
    UIButton *rectEffectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rectEffectBtn addTarget:self action:@selector(rectEffectBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [rectEffectBtn setTitle:@"保存效果" forState:UIControlStateNormal];
    [rectEffectBtn setBackgroundColor:[UIColor redColor]];
    rectEffectBtn.frame = CGRectMake(0, iPhoneH, 80, 40);
    [self.view insertSubview:rectEffectBtn aboveSubview:self.mToolBar];
    self.mRectEffectBtn = rectEffectBtn;
}

#pragma mark 矩形裁剪
- (void)rectClipPressed:(UIBarButtonItem *)sender
{
    self.mImageClipView.image = self.mOldImage;
    
    [self hiddenToolbarNav];
}

#pragma mark 矩形滤镜
- (void)rectEffectPressed:(UIBarButtonItem *)sender
{
//    NSLog(@"矩形滤镜Pressed");
    
    // 滤镜结果图
    
    self.mImageClipView.image = self.mOldImage;
    [self hiddenToolbarNav];
    

}

#pragma mark 圆形滤镜
- (void)circleEffectPressed:(UIBarButtonItem *)sender
{
    NSLog(@"circleEffectPressed");
}


#pragma mark 保存按钮
- (void)savePressed:(UIBarButtonItem *)sender
{
    
    [GWPhotoAlbumTool saveImage:self.mImageView.image toAlbum:@"Camera360" failure:^(NSError *error) {
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存失败"
                                                            message:nil delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil
                                  ];
            [alert show];
        }
    }];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存成功" message:nil
                                                   delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil
                          ];
    [alert show];
    
    
    
}

- (void)clipDonePressed:(UIButton *)sender
{
    CGRect clipRect = self.mImageClipView.trueClipRect;
    NSLog(@"截取的范围是：%@", NSStringFromCGRect(clipRect));
    
    UIImage *image = [self.mImageClipView clipImage];
    self.mImageView.image = image;
    self.mOldImage = image;
    
    [self displayToolbarNav];
}

/**
 *  滤镜效果保存
 */
- (void)rectEffectBtnPressed:(UIButton *)sender
{
    CGRect clipRect = self.mImageClipView.trueClipRect;
    NSLog(@"截取的范围是：%@", NSStringFromCGRect(clipRect));
    
    UIImage *image = [self hebingImage];
    self.mImageView.image = image;
    self.mOldImage = image;
    [self displayToolbarNav];
}

- (UIImage *)hebingImage
{
    CGSize backgroundSize = self.mOldImage.size;
    CGRect preImageRect = self.mImageClipView.trueClipRect;
    UIGraphicsBeginImageContextWithOptions(backgroundSize, NO, 0);
    [self.mOldImage drawInRect:CGRectMake(0, 0, backgroundSize.width, backgroundSize.height)];
    UIImage *preImage =  [self.mImageClipView clipImage];
    UIImage *filterImage = [self filerImage:preImage];
    [filterImage drawInRect:preImageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    NSLog(@"------size%@------scale:%f",NSStringFromCGSize(newImage.size),newImage.scale);
    return newImage;
}

- (UIImage *)filerImage:(UIImage *)image
{
    // 1、创建CoreImage的上下文
    CIContext *ctx = [CIContext contextWithOptions:nil];
    
    // 2、添加CIImage图像内容
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    
    // 3、实例化滤镜需要制制定滤镜名称（系统内置的滤镜名），确定使用哪一种滤镜对图像处理
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    
    [filter setValue:ciImage forKey:@"inputImage"];
    
    CGImageRef cgImage = [ctx createCGImage:filter.outputImage fromRect:ciImage.extent];
    UIImage *filterImage = [UIImage imageWithCGImage:cgImage];
    
    //    self.mFilterImageView.image = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    return filterImage;
}

#pragma mark - 隐藏toolbar和导航栏
- (void)hiddenToolbarNav
{
    CGFloat navBarHeight = self.navigationController.navigationBar.bounds.size.height;
    CGFloat toolBarHeight = self.mToolBar.bounds.size.height;
    [UIView animateWithDuration:.5f animations:^{
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, -navBarHeight - 20);
        self.mToolBar.transform = CGAffineTransformMakeTranslation(0, toolBarHeight);
        self.mClipDoneBtn.transform = CGAffineTransformMakeTranslation(0, -40);
        self.mRectEffectBtn.transform = CGAffineTransformMakeTranslation(0, -40);
        self.mImageView.hidden = YES;
        self.mImageClipView.hidden = NO;
        self.mImageClipView.transform = CGAffineTransformMakeTranslation(0, - 64);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 显示toolbar和导航栏
- (void)displayToolbarNav
{
    [UIView animateWithDuration:.5f animations:^{
        self.navigationController.navigationBar.transform = CGAffineTransformIdentity;
        self.mToolBar.transform = CGAffineTransformIdentity;
        self.mClipDoneBtn.transform = CGAffineTransformIdentity;
        self.mRectEffectBtn.transform = CGAffineTransformIdentity;
        self.mImageClipView.transform = CGAffineTransformIdentity;
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    } completion:^(BOOL finished) {
        self.mImageClipView.hidden = YES;
        self.mImageView.hidden = NO;
    }];
}

#pragma mark - 禁用iOS7返回手势
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)setPhoto:(GWPhoto *)photo
{
    _photo = photo;
    _mOldImage = photo.imageSource;
    _mImageView.image = photo.imageSource;
}

- (void)setMOldImage:(UIImage *)mOldImage
{
    _mOldImage = mOldImage;
    
    NSLog(@"setMOldImage-----%d",(int)mOldImage.imageOrientation);
}

@end
