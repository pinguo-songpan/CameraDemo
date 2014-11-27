//
//  GWPhotoEditViewController.m
//  CameraDemo
//
//  Created by will on 14/11/27.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import "GWPhotoEditViewController.h"
#import "GWPhoto.h"

@interface GWPhotoEditViewController ()
@property (nonatomic, weak) UIToolbar *mToolBar;
@property (nonatomic, weak) UIImageView *mImageView;
@end

@implementation GWPhotoEditViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // 1.工具栏
        [self buildUI];
        
        // 2.图片编辑
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, iPhoneW, iPhoneH-64-44)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:imageView];
        self.mImageView = imageView;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

}

- (void)buildUI
{
    self.title = @"图片编辑";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加工具栏
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    toolBar.frame = CGRectMake(0, iPhoneH - 44, iPhoneW, 44);
    NSArray *items = [NSArray array];
    UIBarButtonItem *circleClip = [[UIBarButtonItem alloc] initWithTitle:@"圆形裁剪" style:UIBarButtonItemStylePlain target:self action:@selector(circleClipPressed:)];
    UIBarButtonItem *rectClip = [[UIBarButtonItem alloc] initWithTitle:@"矩形裁剪" style:UIBarButtonItemStylePlain target:self action:@selector(rectClipPressed:)];
    UIBarButtonItem *bighead = [[UIBarButtonItem alloc] initWithTitle:@"大头效果" style:UIBarButtonItemStylePlain target:self action:@selector(bigheadPressed:)];
    UIBarButtonItem *fix1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *fix2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    items = @[circleClip,fix1,rectClip, fix2, bighead];
    toolBar.items = items;
    [self.view addSubview:toolBar];
    self.mToolBar = toolBar;
}

- (void)circleClipPressed:(UIBarButtonItem *)sender
{
    NSLog(@"circleClipPressed");
}

- (void)rectClipPressed:(UIBarButtonItem *)sender
{
    NSLog(@"rectClipPressed");
}

- (void)bigheadPressed:(UIBarButtonItem *)sender
{
    NSLog(@"bigheadPressed");
}

- (void)setPhoto:(GWPhoto *)photo
{
    _photo = photo;
    
    NSLog(@"%@",photo);
    self.mImageView.image = photo.imageSource;
}


@end
