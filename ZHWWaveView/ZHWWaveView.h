//
//  ZHWWaveView.h
//  ZHWWaveView
//
//  Created by andson-zhw on 16/8/16.
//  Copyright © 2016年 andson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHWWaveView : UIView
@property(nonatomic,assign) CGFloat waveAngularSpeed; //波动的角度
@property(nonatomic,assign) CGFloat waveSpeed; //波动的速度
@property(nonatomic,assign) NSTimeInterval waveTimeValue; //波动时间
@property(nonatomic,strong) UIColor *waveColor; //波浪的颜色

///初始化方法
-(instancetype)initSuperView:(UIView *)view withFrame:(CGRect)frame;

///是否开启波浪动画
-(BOOL)ifStartWaveAnimation;

///停止波浪动画
-(void)stopWaveAnimation;
@end
