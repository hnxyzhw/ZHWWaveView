//
//  ZHWWaveView.m
//  ZHWWaveView
//
//  Created by andson-zhw on 16/8/16.
//  Copyright © 2016年 andson. All rights reserved.
//

#import "ZHWWaveView.h"


@interface ZHWWaveView ()
@property (nonatomic, assign) CGFloat offsetX;
@property (nonatomic, strong) CADisplayLink *waveDisplayLink;
@property (nonatomic, strong) CAShapeLayer *waveShapeLayer;
@property (nonatomic, strong) CAShapeLayer *waveShapeLayer2;
@end


@implementation ZHWWaveView

-(instancetype)initSuperView:(UIView *)view withFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [view addSubview:self];
    if (self) {
        [self setDefaultParameter];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ([super initWithCoder:aDecoder]) {
        [self setDefaultParameter];
    }
    return self;
}

#pragma mark - 设置默认参数配置
-(void)setDefaultParameter{
    _waveAngularSpeed = 2.0f;
    _waveSpeed = 2.0f;
    _waveTimeValue = 1.f;
    _waveColor = [UIColor colorWithRed:164/255.f green:174/255.f blue:246/255.f alpha:1];
    
    self.waveShapeLayer = [CAShapeLayer layer];
//    self.waveShapeLayer.opacity = 0.5;
    self.waveShapeLayer.frame = self.bounds;
    self.waveShapeLayer.fillColor = [UIColor colorWithRed:187/255.f green:194/255.f blue:247/255.f alpha:1].CGColor;
    [self.layer addSublayer:self.waveShapeLayer];
    
    self.waveShapeLayer2 = [CAShapeLayer layer];
//    self.waveShapeLayer2.opacity = 0.5;
    self.waveShapeLayer2.frame = self.bounds;
    self.waveShapeLayer2.fillColor = self.waveColor.CGColor;
    [self.layer addSublayer:self.waveShapeLayer2];
}

-(BOOL)ifStartWaveAnimation{
    
    if (self.waveShapeLayer.path) {
        return NO;
    }
    
   
    
    self.waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(waveHandle)];
    [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    if (self.waveTimeValue > 0.f) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.waveTimeValue * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self stopWaveAnimation];
        });
    }
    return YES;
}

-(void)waveHandle{
    self.offsetX -= self.waveSpeed;
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, height*sinf(self.offsetX*M_PI/width));
    
//    CGFloat y = 0.f;
    for (CGFloat x = 0.f; x <= width ; x++) {
//        y = height * sin(0.01 * self.waveAngularSpeed * x + self.offsetX * 0.045);
//        y = height * sinf((360/self.frame.size.width) *(x * M_PI / 180) -  _offsetX * M_PI / 180);
        CGFloat y = 1.5 * height * sinf(2.5* M_PI * x/width + self.offsetX * M_PI/width) + 5;
        CGPathAddLineToPoint(path, NULL, x, y);
    }
    CGPathAddLineToPoint(path, NULL, width, height);
    CGPathAddLineToPoint(path, NULL, 0, height);
    CGPathCloseSubpath(path);
    
    self.waveShapeLayer.path = path;
    CGPathRelease(path);
    
    CGMutablePathRef path2 = CGPathCreateMutable();
    CGFloat startY2 = height*sinf(self.offsetX*M_PI/width + M_PI/4);
    CGPathMoveToPoint(path2, NULL, 0, startY2);
    for (CGFloat i = 0.0; i <= width; i ++) {
        CGFloat y = height*sinf(2.5*M_PI*i/width + 3*self.offsetX*M_PI/width + M_PI/4) + 5;
        CGPathAddLineToPoint(path2, NULL, i, y);
    }
    CGPathAddLineToPoint(path2, NULL, width, height);
    CGPathAddLineToPoint(path2, NULL, 0, height);
    CGPathCloseSubpath(path2);
    
    self.waveShapeLayer2.path = path2;
    CGPathRelease(path2);
    
}

-(void)stopWaveAnimation{
    [UIView animateWithDuration:2.f animations:^{
        self.alpha = 0.f;

    } completion:^(BOOL finished) {
        [self.waveDisplayLink invalidate];
        self.waveDisplayLink = nil;
        
        self.waveShapeLayer.path = nil;
        self.waveShapeLayer2.path = nil;
        self.alpha = 1.f;
    }];
}


@end
