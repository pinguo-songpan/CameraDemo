//
//  GWPhotoViewCell.m
//  CameraDemo
//
//  Created by will on 14/11/26.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import "GWPhotoViewCell.h"
#import "GWPhoto.h"

@implementation GWPhotoViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.photoImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.photoImageButton.frame = CGRectMake(0, 0, kPhotoW, kPhotoH);
        [self addSubview:self.photoImageButton];
        
        self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.selectButton.userInteractionEnabled = NO;
        self.selectButton.frame = CGRectMake(kPhotoW * 0.6, kPhotoH * 0.6, 22, 22);
        [self addSubview:self.selectButton];
    }
    return self;
}

- (void)setPhoto:(GWPhoto *)photo
{
    _photo = photo;
    [self.photoImageButton setImage:photo.imageSmail forState:UIControlStateNormal];
}
@end
