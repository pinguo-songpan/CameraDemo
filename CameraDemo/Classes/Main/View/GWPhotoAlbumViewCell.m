//
//  GWPhotoAlbumViewCell.m
//  CameraDemo
//
//  Created by will on 14/11/27.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import "GWPhotoAlbumViewCell.h"
#import "GWPhotoAlbum.h"
#import "GWPhoto.h"

@interface GWPhotoAlbumViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *mImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mBackgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *mCount;
@property (weak, nonatomic) IBOutlet UILabel *mName;

@end

@implementation GWPhotoAlbumViewCell

- (instancetype)init
{
    self = [super init];
    if (self)
    {

    }
    return self;
}

- (void)awakeFromNib
{
    // 把底部的图片向右旋转一定角度
    self.mBackgroundImageView.transform = CGAffineTransformMakeRotation(M_PI_2 * 0.1);
    // 栅格化图层，防止旋转后有锯齿
    self.mBackgroundImageView.layer.shouldRasterize = YES;
    self.mBackgroundImageView.layer.rasterizationScale = 1;
    
    // 图片添加半透明遮盖
    UIView *cover = [[UIView alloc] initWithFrame:self.mImageView.bounds];
    cover.backgroundColor = [[UIColor darkTextColor] colorWithAlphaComponent:0.3];
    [self.mImageView addSubview:cover];
   
    UIView *cover2 = [[UIView alloc] initWithFrame:self.mImageView.bounds];
    cover2.backgroundColor = [[UIColor darkTextColor] colorWithAlphaComponent:0.3];
    [self.mBackgroundImageView addSubview:cover2];
}

- (void)setPhotoAlbum:(GWPhotoAlbum *)photoAlbum
{
    _photoAlbum = photoAlbum;
    
    self.mBackgroundImageView.image = photoAlbum.backImage;
    self.mImageView.image = photoAlbum.foreImage;
    self.mCount.text = [NSString stringWithFormat:@"%ld",photoAlbum.count];
    self.mName.text = photoAlbum.name;
}
@end
