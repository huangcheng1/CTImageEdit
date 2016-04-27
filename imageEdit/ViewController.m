//
//  ViewController.m
//  imageEdit
//
//  Created by 黄成 on 16/4/27.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "ViewController.h"
#import "EditView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    EditView * VIEW = [[EditView alloc]initWithFrame:CGRectMake(50, 10, 300, 533)];
    //    UIImage *image1 = [UIImage imageWithCGImage:[UIImage imageNamed:@"huangshan"].CGImage scale:[UIScreen mainScreen].scale orientation:[UIImage imageNamed:@"huangshan"].imageOrientation];
    //    [VIEW packageWithImage:image1];
        [VIEW packageWithImage:[UIImage imageNamed:@"A0F684E71353A32FF8FFD5A938D32207"]];
    [self.view addSubview:VIEW];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
