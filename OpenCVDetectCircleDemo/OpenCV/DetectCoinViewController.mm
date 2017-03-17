//
//  ViewController.m
//  OpenCVDetectCircleDemo
//
//  Created by Story5 on 3/8/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/imgproc/imgproc.hpp>

#import "VideoCamera.h"
#import "DetectCoinViewController.h"

#import "DebugView.h"

#import "SXImageSaveHelper.h"

#import "FlashLightHelper.h"
#import "UseGuideView.h"

#import "MeasureFishViewController.h"

@interface DetectCoinViewController ()<CvVideoCameraDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *TakePictureButton;
@property (nonatomic,strong) VideoCamera *videoCamera;

@end

//using namespace cv;
//using namespace std;


@implementation DetectCoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configVideoCamera];
    [self.videoCamera start];
 
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    switch ([UIDevice currentDevice].orientation) {
        case UIDeviceOrientationPortraitUpsideDown:
            self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        case UIDeviceOrientationLandscapeLeft:
            self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationLandscapeLeft;
            break;
        case UIDeviceOrientationLandscapeRight:
            self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationLandscapeRight;
            break;
        default:
            self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
            break;
    }
    
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"%s",__func__);
    
}

#pragma mark - CvVideoCameraDelegate
- (void)processImage:(cv::Mat&)image
{
    cv::Mat mat = [self detectCircle:image];
//    [self drawLineView:mat];
    
    UIImage *outimage = MatToUIImage(mat);
    if (outimage) {
        NSLog(@"image is full");
        self.imageView.image = outimage;
    } else {
        NSLog(@"image is nil");
    }
    
}

- (cv::Mat)detectCircle:(cv::Mat&)src
{
    cv::Mat src_gray;
    cv::cvtColor( src, src_gray, CV_BGR2GRAY );
    cv::GaussianBlur( src_gray, src_gray, cv::Size(9, 9), 2, 2 );
    std::vector<cv::Vec3f> circles;
    cv::HoughCircles( src_gray, circles, CV_HOUGH_GRADIENT, 1, src_gray.rows/8, 200, 100, 0, 0 );
    self.TakePictureButton.enabled = circles.size() > 0 ? YES : NO;
    for( size_t i = 0; i < circles.size(); i++ )
    {
        cv::Point center(cvRound(circles[i][0]), cvRound(circles[i][1]));
        int radius = cvRound(circles[i][2]);
        // circle center
        circle( src, center, 3, cv::Scalar(0,0,255), -1, 8, 0 );
        // circle outline
        circle( src, center, radius, cv::Scalar(0,255,0), 5, 8, 0 );
    }
    return src;
}

#pragma mark - private methods
- (void)drawLineView:(cv::Mat)src
{
    for (int i = 0; i < src.cols; i += 100) {
        cv::Point pt1(i,0);
        cv::Point pt2(i,src.rows);
        
        cv::line(src, pt1, pt2, cv::Scalar(255,255,255));
    }
    
    for (int i = 0; i < src.rows; i += 100) {
        cv::Point pt1(0,i);
        cv::Point pt2(src.cols,i);
        cv::line(src, pt1, pt2, cv::Scalar(255,255,255));
    }

}

- (IBAction)useGuide:(UIButton *)sender {
    
    UseGuideView *sc = [[UseGuideView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:sc];
    
}

- (IBAction)takePicture:(UIButton *)sender {

    [self.videoCamera stop];
    
    UIImage *image = self.imageView.image;
    
    MeasureFishViewController *vc = [[MeasureFishViewController alloc] init];
    [vc setImage:image];
    [self presentViewController:vc animated:YES completion:nil];
    [vc setImage:image];
    return;
    
    if (self.imageView.image) {
        NSLog(@"save image is full");
    } else {
        NSLog(@"save image is nill");
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保持图片" message:@"点击操作" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[SXImageSaveHelper shareInstance] saveImageToPhotoLibrary:self.imageView.image];
    }];
    
    [alert addAction:saveAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)flashLight:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [FlashLightHelper setFlashLightMode:sender.selected];
}

- (void)configVideoCamera {
    self.videoCamera = [[VideoCamera alloc] initWithParentView:self.imageView];
    self.videoCamera.delegate = self;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPresetHigh;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.letterboxPreview = YES;
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
}

- (void)refresh {
    // Start or restart the video.
    [self.videoCamera stop];
    [self.videoCamera start];
}

@end
