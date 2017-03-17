//
//  SXDeviceHelper.h
//  OpenCVDetectCircleDemo
//
//  Created by Story5 on 3/16/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    unknownInch,
    iPhone4Inch,
    iPhone4_7Inch,
    iPhone5_5Inch,
} IPhoneScreenInch;

@interface SXDeviceHelper : NSObject

+ (NSString *)useGuideImageSuffix;


@end
