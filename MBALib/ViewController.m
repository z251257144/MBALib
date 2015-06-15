//
//  ViewController.m
//  MBALib
//
//  Created by zhoumin on 15/6/15.
//  Copyright (c) 2015年 zhoumin. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+YYAdd.h"
#import "UIImage+YYAdd.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:IMAGE_LOAD(image)];
//    hud.customView = imageView;
    
    hud.labelText = @"dfasdfsd";
    hud.labelFont = [UIFont boldSystemFontOfSize:15.0f];
    
    hud.detailsLabelText = @"DSFASDF";
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:13.0f];
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.needHiddenWhenTaped = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:19999];
    
    [MBProgressHUD showPromptViewTappedHideInView:self.view image:IMAGE_LOAD(HUD_SUCCESS) title:@"OK" detail:@"detail" delay:5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
