//
//  GWPhotoAlbum.m
//  CameraDemo
//
//  Created by will on 14/11/25.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import "GWPhotoAlbum.h"

@implementation GWPhotoAlbum
- (instancetype)initWithGroup:(ALAssetsGroup *)group
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\n photos:%@\n name:%@\n posterImage:%@\n type:%@\n persistentID:%@\n URL:%@\n",self.photos,self.name,self.posterImage,self.type,self.persistentID,self.URL];
}
@end
