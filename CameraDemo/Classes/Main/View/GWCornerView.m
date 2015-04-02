//
//  GWCornerView.m
//  CameraDemo
//
//  Created by will on 14/12/1.
//  Copyright (c) 2014年 Camera360. All rights reserved.
//

#import "GWCornerView.h"

@implementation GWCornerView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, 20, 20);
        self.layer.cornerRadius = 10.0f;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 5;
    }
    return self;
}

@end
