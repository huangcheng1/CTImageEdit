//
//  EditImageManager.m
//  imageEdit
//
//  Created by 黄成 on 16/4/27.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "EditImageManager.h"
#import <GPUImage/GPUImage.h>

@implementation EditImageManager

/*
 全图模糊  高斯模糊
 */
+ (UIImage*)filterForGaussianBlur:(UIImage*)image{
    GPUImageGaussianBlurFilter *filter = [[GPUImageGaussianBlurFilter alloc]init];
    [filter forceProcessingAtSize:image.size];
    filter.blurRadiusInPixels = 10.0;
    
    GPUImagePicture *pic = [[GPUImagePicture alloc]initWithImage:image];
    [pic addTarget:filter];
    [pic processImage];
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}

@end
