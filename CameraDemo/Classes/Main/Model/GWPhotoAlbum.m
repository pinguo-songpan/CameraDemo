//
//  GWPhotoAlbum.m
//  CameraDemo
//
//  Created by will on 14/11/25.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import "GWPhotoAlbum.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "GWPhoto.h"

@implementation GWPhotoAlbum

- (instancetype)initWithAssetsGruop:(ALAssetsGroup *)assetsGruop
{
    self = [super init];
    if (self)
    {
        self.name = [assetsGruop valueForProperty:ALAssetsGroupPropertyName];
        self.type = [assetsGruop valueForProperty:ALAssetsGroupPropertyType];
        self.persistentID = [assetsGruop valueForProperty:ALAssetsGroupPropertyPersistentID];
        self.url = [assetsGruop valueForProperty:ALAssetsGroupPropertyURL];
        self.assetsGruop = assetsGruop;
        self.count = [assetsGruop numberOfAssets];
        
        __block NSMutableArray *photos = [NSMutableArray array];
        ALAssetsFilter *filter = [ALAssetsFilter allPhotos];
        [assetsGruop setAssetsFilter:filter];
        [assetsGruop enumerateAssetsUsingBlock:^(ALAsset *resultAlAsset, NSUInteger index, BOOL *stop) {
            GWPhoto *photo = [[GWPhoto alloc] initWithAsset:resultAlAsset];
            if (photo.asset != nil) {
                [photos addObject:photo];
            }
        }];
        self.photos = photos;
        
        // 取出最后一个照片对象
        GWPhoto *p = [photos lastObject];
        self.foreImage = p.imageSmail;
        
        if (_photos.count > 1) {
            p = photos[photos.count - 2];
            self.backImage = p.imageSmail;
        }
        else
        {
            self.backImage = p.imageSmail;
        }
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\n photos:%@\n name:%@\n foreImage:%@\n backImage:%@\n type:%@\n persistentID:%@\n URL:%@\n assetsGruop%@",self.photos,self.name,self.foreImage, self.backImage,self.type,self.persistentID,self.url,self.assetsGruop];
}
@end


