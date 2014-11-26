//
//  GWPhotoViewController.h
//  CameraDemo
//
//  Created by will on 14/11/26.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  图片控制器
 */
@interface GWPhotoViewController : UIViewController
/** 照片模型数组，装的GWPhoto对象 */
@property (nonatomic, strong) NSArray *photos;
/** 存储选中的图片 */
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@end
