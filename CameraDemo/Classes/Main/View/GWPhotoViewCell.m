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
        
        self.selectedView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kPhotoW, kPhotoH)];
        self.selectedView.image = [UIImage imageNamed:@"c360_cloud_small_image_selected"];
        [self.photoImageButton addSubview:self.selectedView];
    }
    return self;
}

- (void)setPhoto:(GWPhoto *)photo
{
    _photo = photo;
    [self.photoImageButton setImage:photo.imageSmail forState:UIControlStateNormal];
    if (photo.isSelected)
    {
        self.selectedView.hidden = NO;
    }
    else
    {
        self.selectedView.hidden = YES;
    }
    
}
@end
