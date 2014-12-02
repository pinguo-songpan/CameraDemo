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

@interface GWPhotoEditViewController ()
@property (nonatomic, weak) UIToolbar   *mToolBar;
@property (nonatomic, weak) UIImageView *mImageView;
@property (nonatomic, copy) UIImage *mOldImage;  // 裁剪前的图片
@property (nonatomic, weak) UIButton *mClipDoneBtn;
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
        // 1.工具栏
        [self buildUI];
        
        // 2.显示的图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 64+10, iPhoneW-20, iPhoneH-64-44-20)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor redColor];
        [self.view addSubview:imageView];
        self.mImageView = imageView;
        
        // 3.可被裁剪的图片
        GWImageClipView *imageClipView = [[GWImageClipView alloc] initWithFrame:imageView.frame];
        imageClipView.hidden = YES;
        [self.view addSubview:imageClipView];
        self.mImageClipView = imageClipView;
       
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)buildUI
{
    // 添加工具栏
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    toolBar.frame = CGRectMake(0, iPhoneH - 44, iPhoneW, 44);
    
    UIBarButtonItem *circleClip = [[UIBarButtonItem alloc] initWithTitle:@"圆形裁剪" style:UIBarButtonItemStylePlain target:self action:@selector(circleClipPressed:)];
    UIBarButtonItem *rectClip = [[UIBarButtonItem alloc] initWithTitle:@"矩形裁剪" style:UIBarButtonItemStylePlain target:self action:@selector(rectClipPressed:)];
    UIBarButtonItem *bighead = [[UIBarButtonItem alloc] initWithTitle:@"大头效果" style:UIBarButtonItemStylePlain target:self action:@selector(bigheadPressed:)];
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(savePressed:)];
    UIBarButtonItem *fix1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *fix2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.navigationItem.rightBarButtonItem = save;
    
    toolBar.items = @[circleClip,fix1,rectClip, fix2, bighead];
    [self.view addSubview:toolBar];
    self.mToolBar = toolBar;
    
    // 裁剪完成按钮
    UIButton *clipDoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clipDoneBtn.backgroundColor = [UIColor blueColor];
    clipDoneBtn.frame = CGRectMake(iPhoneW - 60, iPhoneH, 60, 40);
    [clipDoneBtn setTitle:@"Done" forState:UIControlStateNormal];
    [clipDoneBtn addTarget:self action:@selector(clipDonePressed:) forControlEvents:UIControlEventTouchUpInside];

    [self.view insertSubview:clipDoneBtn belowSubview:self.mToolBar];
    self.mClipDoneBtn = clipDoneBtn;
}

- (void)circleClipPressed:(UIBarButtonItem *)sender
{
    NSLog(@"circleClipPressed");
}

- (void)rectClipPressed:(UIBarButtonItem *)sender
{
    CGFloat navBarHeight = self.navigationController.navigationBar.bounds.size.height;
    CGFloat toolBarHeight = self.mToolBar.bounds.size.height;
    self.mImageClipView.image = self.mOldImage;
    [UIView animateWithDuration:.5f animations:^{
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, -navBarHeight - 20);
        self.mToolBar.transform = CGAffineTransformMakeTranslation(0, toolBarHeight);
        self.mClipDoneBtn.transform = CGAffineTransformMakeTranslation(0, -40);
        self.mImageView.hidden = YES;
        self.mImageClipView.hidden = NO;
        self.mImageClipView.transform = CGAffineTransformMakeTranslation(0, - 60);
        
    } completion:^(BOOL finished) {
       
    }];
}

- (void)bigheadPressed:(UIBarButtonItem *)sender
{
    NSLog(@"bigheadPressed");
}

- (void)savePressed:(UIBarButtonItem *)sender
{

}

- (void)clipDonePressed:(UIButton *)sender
{
    [UIView animateWithDuration:.5f animations:^{
        self.navigationController.navigationBar.transform = CGAffineTransformIdentity;
        self.mToolBar.transform = CGAffineTransformIdentity;
        self.mClipDoneBtn.transform = CGAffineTransformIdentity;
        self.mImageClipView.transform = CGAffineTransformIdentity;
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    } completion:^(BOOL finished) {
        self.mImageClipView.hidden = YES;
        self.mImageView.hidden = NO;
    }];
    
    UIImage *image = [self.mImageClipView clipImage];
    self.mImageView.image = image;
    self.mOldImage = image;
}

- (void)setPhoto:(GWPhoto *)photo
{
    _photo = photo;
    _mOldImage = photo.imageSource;
    _mImageView.image = photo.imageSource;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}


@end
