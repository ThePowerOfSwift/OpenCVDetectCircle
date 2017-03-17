//
//  SXImageSaveHelper.h
//  LightWork
//
//  Created by Story5 on 2/6/17.
//  Copyright © 2017 Nummist Media Corporation Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@protocol SXImageSaveHelperDelegate <NSObject>

- (void)saveImageSuccessWithImage:(UIImage *)image;
- (void)saveImageFailedWithMessage:(NSString *)message;

@end

@interface SXImageSaveHelper : NSObject

@property (nonatomic,weak) id<SXImageSaveHelperDelegate>delegate;

+ (instancetype)shareInstance;
- (void)saveImageToPhotoLibrary:(UIImage *)image;

@end
