//
//  GWPhoto.m
//  CameraDemo
//
//  Created by will on 14/11/25.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import "GWPhoto.h"

@implementation GWPhoto

- (id)initWithAsset:(ALAsset *)asset
{
    self = [super init];
    if (self) {
        self.asset = asset;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"{isSelected = %d, \nasset = %@}", self.isSelected, self.asset];
}
@end
