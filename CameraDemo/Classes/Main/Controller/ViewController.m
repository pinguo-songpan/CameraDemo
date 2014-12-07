//
//  ViewController.m
//  CameraDemo
//
//  Created by will on 14/11/25.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import "ViewController.h"
#import "GWPhotoAlbumController.h"
#import "GWPhotoViewController.h"
#import "GWPhotoAlbumTool.h"
#import "GWPhoto.h"
#import "GWPhotoEditViewController.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"相薄";
}

/**
 *  打开相机
 */
- (IBAction)openCamera:(UIButton *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

/**
 *  打开相册
 */
- (IBAction)openAlbum:(UIButton *)sender
{
    GWPhotoAlbumController *photoAlbumController = [[GWPhotoAlbumController alloc] init];
    [self.navigationController pushViewController:photoAlbumController animated:YES];
}

#pragma mark - UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
    GWPhotoEditViewController *photoEdit = [[GWPhotoEditViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:photoEdit];

    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    [photoEdit.navigationItem setLeftBarButtonItem:leftItem];
    
    ALAssetsLibrary *assetsLib = [GWPhotoAlbumTool sharePhotoAlbumTool].assetsLibrary;
    [self dismissViewControllerAnimated:YES completion:^{
        [assetsLib writeImageToSavedPhotosAlbum:image.CGImage orientation:(ALAssetOrientation)image.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error) {
           [assetsLib assetForURL:assetURL resultBlock:^(ALAsset *asset) {
              
               GWPhoto *p = [[GWPhoto alloc] initWithAsset:asset];
               photoEdit.photo = p;
               [self presentViewController:nav animated:YES completion:^{
                   
               }];
               
           } failureBlock:^(NSError *error) {
               
           }];
            
            
        }];
    }];
}

- (void)leftItemClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
