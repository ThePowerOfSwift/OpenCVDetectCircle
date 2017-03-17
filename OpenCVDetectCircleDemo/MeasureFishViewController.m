//
//  SecondViewController.m
//  OpenCVDetectCircleDemo
//
//  Created by Story5 on 3/9/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "MeasureFishViewController.h"

#import "OpenCVDetectCircleDemo-Swift.h"

@interface MeasureFishViewController ()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) SXRulerView *rulerView;

@end

@implementation MeasureFishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.imageView];
    
    self.rulerView = [[SXRulerView alloc] init];
    [self.view addSubview:self.rulerView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.imageView.image = self.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
