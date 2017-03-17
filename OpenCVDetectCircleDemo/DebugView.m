//
//  DebugView.m
//  OpenCVDetectCircleDemo
//
//  Created by Story5 on 3/9/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "DebugView.h"

@implementation DebugView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createOriginView];
    }
    return self;
}

- (void)createOriginView
{
    for (int i = 0; i < self.bounds.size.width; i += 10) {
        UIView *lineX = [[UIView alloc] initWithFrame:CGRectMake(i, 0, 1, self.bounds.size.height)];
        lineX.backgroundColor = [UIColor whiteColor];
        [self addSubview:lineX];
    }
    
    for (int i = 0; i < self.bounds.size.height; i += 10) {
        UIView *lineY = [[UIView alloc] initWithFrame:CGRectMake(0, i, self.bounds.size.width, 1)];
        lineY.backgroundColor = [UIColor blackColor];
        [self addSubview:lineY];
    }
}

@end
