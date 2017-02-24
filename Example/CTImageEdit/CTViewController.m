//
//  CTViewController.m
//  CTImageEdit
//
//  Created by acct<blob>=<NULL> on 02/24/2017.
//  Copyright (c) 2017 acct<blob>=<NULL>. All rights reserved.
//

#import "CTViewController.h"
#import <CTImageEdit/CTImageSmearViewController.h>

@interface CTViewController () <CTImageSmearViewControllerDelegate>

@property (nonatomic,strong) UIImage *image;

@property (nonatomic,strong) UIImageView *imageview;

@end

@implementation CTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.image= [UIImage imageNamed:@"testimage"];
    NSLog(@"%f",self.image.size.width);
    self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.width*523/375)];
    self.imageview.image = self.image;
    [self.view addSubview:self.imageview];
}
- (void)click1:(id)sender{
    CTImageSmearViewController *ctr = [[CTImageSmearViewController alloc]init];
    ctr.delegate = self;
    [ctr packageWithImage:self.image];
    [self presentViewController:ctr animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)didSmearPhotoWithResultImage:(UIImage *)image{
    self.image = image;
    self.imageview.image = self.image;
}
@end
