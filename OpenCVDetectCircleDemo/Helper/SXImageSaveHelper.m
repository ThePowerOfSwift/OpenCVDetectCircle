//
//  SXImageSaveHelper.m
//  LightWork
//
//  Created by Story5 on 2/6/17.
//  Copyright © 2017 Nummist Media Corporation Limited. All rights reserved.
//

#import "SXImageSaveHelper.h"


@implementation SXImageSaveHelper

static SXImageSaveHelper *instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)saveImageToPhotoLibrary:(UIImage *)image {
    
    // Try to save the image to a temporary file.
    NSString *outputPath = [NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), @"output.png"];
    if (![UIImagePNGRepresentation(image) writeToFile:outputPath atomically:YES]) {
        
        // Show an alert describing the failure.
        [self saveImageFailureWithMessage:@"The image could not be saved to the temporary directory."];
        
        return;
    }
    
    // Try to add the image to the Photos library.
    NSURL *outputURL = [NSURL URLWithString:outputPath];
    PHPhotoLibrary *photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
    [photoLibrary performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:outputURL];
    } completionHandler:^(BOOL success, NSError *error) {
        if (success) {
            // Show an alert describing the success, with sharing options.
            [self saveImageSucceedWithImage:image];
        } else {
            // Show an alert describing the failure.
            [self saveImageFailureWithMessage:error.localizedDescription];
        }
    }];
}

- (void)saveImageFailureWithMessage:(NSString *)message {
    if (self.delegate && [self.delegate respondsToSelector:@selector(saveImageFailedWithMessage:)]) {
        [self.delegate performSelector:@selector(saveImageFailedWithMessage:) withObject:message];
    }
}

- (void)saveImageSucceedWithImage:(UIImage *)image {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(saveImageSuccessWithImage:)]) {
        [self.delegate performSelector:@selector(saveImageSuccessWithImage:) withObject:image];
    }
}

@end
