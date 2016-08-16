//
//  ViewController.m
//  ZHWWaveView
//
//  Created by andson-zhw on 16/8/16.
//  Copyright © 2016年 andson. All rights reserved.
//

#import "ViewController.h"
#import "ZHWWaveView.h"
#import "WYWaveView.h"
@interface ViewController ()
{
    UIImageView *imageView;
}
@property(nonnull,strong)ZHWWaveView *waveView;
@property (nonatomic, strong)WYWaveView *wangYiWave;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    imageView =[[UIImageView alloc]init];
    UIImage *img = [UIImage imageNamed:@"ship64.png"];
    imageView.image = img;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.frame = CGRectMake((CGRectGetWidth(self.view.frame)), 50-img.size.height/2 + 5, img.size.width/2, img.size.height/2);
    [self.view addSubview:imageView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 50)];
    headerView.backgroundColor = [UIColor colorWithRed:164/255.f green:174/255.f blue:246/255.f alpha:1];
    [self.view addSubview:headerView];
    
    
    
    CGRect frame = CGRectMake(0, 45,CGRectGetWidth(headerView.frame) , 8);
    self.waveView = [[ZHWWaveView alloc]initSuperView:self.view withFrame:frame];
    self.waveView.waveTimeValue = 0.0f;
    self.waveView.waveColor = [UIColor colorWithRed:164/255.f green:174/255.f blue:246/255.f alpha:1];
    self.waveView.waveSpeed = 4.0f;
    self.waveView.waveAngularSpeed =  8.0f;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 330, 50, 50)];
    [button setTitle:@"go!" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(start ) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    [self.view addSubview:button];
    
   
    
    
//    self.wangYiWave = [[WYWaveView alloc]initWithFrame:frame];
//    [self.view addSubview:self.wangYiWave];
//    self.wangYiWave.speed = 2;
//    self.wangYiWave.waveHeight = 5;
//    self.wangYiWave.backgroundColor = [UIColor colorWithRed:200/255.0 green:30/255.0 blue:20/255.0 alpha:1];
    
}

-(void)start{
    UIImage *img = [UIImage imageNamed:@"ship64.png"];
    
    if ([self.waveView ifStartWaveAnimation]) {
        
        [UIView animateWithDuration:20.f animations:^{
           
            imageView.frame = CGRectMake(-img.size.width/2, 50-img.size.height/2 + 5, img.size.width/2, img.size.height/2);
        } completion:^(BOOL finished) {
            NSLog(@"小船靠岸");
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.waveView stopWaveAnimation];
            imageView.frame = CGRectMake((CGRectGetWidth(self.view.frame)), 50-img.size.height/2 + 5, img.size.width/2, img.size.height/2);
        });
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
