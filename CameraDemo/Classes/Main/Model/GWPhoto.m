//
//  GWPhoto.m
//  CameraDemo
//
//  Created by will on 14/11/25.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import "GWPhoto.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImage+FixOrientation.h"
@interface GWPhoto ()

@end

@implementation GWPhoto

- (id)initWithAsset:(ALAsset *)asset
{
    self = [super init];
    if (self)
    {
        self.asset = asset;
        self.imageSmail = [[UIImage alloc] initWithCGImage:[asset thumbnail]];
    }
    return self;
}

//- (NSString *)description
//{
//    return [NSString stringWithFormat:@"{isSelected = %d, \nasset = %@}", self.isSelected, self.asset];
//}

- (UIImage *)imageSource
{
    // 用到时才加载原图
    ALAssetRepresentation *assetRep = [_asset defaultRepresentation];
    UIImage  *imageSource = [[UIImage alloc] initWithCGImage:[assetRep fullResolutionImage] scale:1 orientation:(UIImageOrientation)assetRep.orientation];
    // 固定image的方向
    imageSource = [UIImage fixOrientation:imageSource];
  
    return imageSource;
}
@end
