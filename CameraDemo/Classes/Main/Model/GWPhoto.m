//
//  GWPhoto.m
//  CameraDemo
//
//  Created by will on 14/11/25.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import "GWPhoto.h"

@interface GWPhoto ()
@property (nonatomic, strong) ALAsset *asset;

@end
@implementation GWPhoto

- (id)initWithAsset:(ALAsset *)asset
{
    self = [super init];
    if (self)
    {
        self.asset = asset;
        self.imageSmail = [[UIImage alloc] initWithCGImage:[asset thumbnail]];
        ALAssetRepresentation *assetRep = [asset defaultRepresentation];
        self.imageSource = [[UIImage alloc] initWithCGImage:[assetRep fullResolutionImage]];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"{isSelected = %d, \nasset = %@}", self.isSelected, self.asset];
}


@end
