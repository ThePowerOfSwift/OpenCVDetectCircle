//
//  SXDeviceHelper.m
//  OpenCVDetectCircleDemo
//
//  Created by Story5 on 3/16/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "SXDeviceHelper.h"

#import <UIKit/UIKit.h>

@implementation SXDeviceHelper

+ (NSString *)useGuideImageSuffix
{
    NSString *suffix = @"1242x2208";
    IPhoneScreenInch screenInch = [SXDeviceHelper getIPhoneScreenInch];
    switch (screenInch) {
    case iPhone4Inch:
        suffix = @"640x1136";
    case iPhone4_7Inch:
        suffix = @"750x1334";
    case iPhone5_5Inch:
        suffix = @"1242x2208";
    default:
        suffix = @"1242x2208";
    }
    return suffix;
}


+ (IPhoneScreenInch)getIPhoneScreenInch
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    IPhoneScreenInch screenInch = unknownInch;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        
        NSInteger compare = 0;
        if (screenSize.height > screenSize.width) {
            //竖屏情况
            compare = screenSize.height;
        } else if (screenSize.width > screenSize.height) {
            //横屏情况
            compare = screenSize.width;
        }
        
        switch (compare) {
            case 568:
                screenInch = iPhone4Inch;
                break;
            case 667:
                screenInch = iPhone4_7Inch;
                break;
            case 736:
                screenInch = iPhone5_5Inch;
                break;
            default:
                screenInch = unknownInch;
                break;
        }
    }
    return screenInch;
}




@end
