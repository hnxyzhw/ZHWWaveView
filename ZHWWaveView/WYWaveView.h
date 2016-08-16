//
//  WYWaveView.h
//  ZHWWaveView
//
//  Created by andson-zhw on 16/8/16.
//  Copyright © 2016年 andson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYWaveView : UIView

@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) CGFloat waveHeight;

- (void)wave;
- (void)stop;
@end
