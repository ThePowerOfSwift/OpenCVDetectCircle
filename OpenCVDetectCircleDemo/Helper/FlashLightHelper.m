//
//  FlashLightHelper.m
//  OpenCVDetectCircleDemo
//
//  Created by Story5 on 3/17/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "FlashLightHelper.h"
#import <AVFoundation/AVFoundation.h>

@implementation FlashLightHelper

+ (void)setFlashLightMode:(BOOL)mode
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        
        [device lockForConfiguration:nil];
        if (mode) {
            // 打开闪光灯
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            // 关闭闪光灯
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        
        [device unlockForConfiguration];
    }
}

@end
