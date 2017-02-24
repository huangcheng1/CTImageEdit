//
//  CTImageSmearViewController.m
//  Pods
//
//  Created by huang cheng on 2017/2/24.
//
//

#import "CTImageSmearViewController.h"
#import "CTImageSmearView.h"
#import "CTImageEditUtil.h"
#import "UIImage+EditImageWithColor.h"
#import "CTImageSmearTop.h"
#import "CTImageSmearBottom.h"

@interface CTImageSmearViewController () <CTImageSmearBottomDelegate,CTImageSmearViewDelegate>

@property (nonatomic,strong) CTImageSmearView *smearView;

@property (nonatomic,strong) CTImageSmearTop *smearTop;

@property (nonatomic,strong) CTImageSmearBottom *smearBottom;

@end

@implementation CTImageSmearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.smearView.center = CGPointMake(CGRectGetMidX(CTImageEditPreviewFrame), CGRectGetMidY(CTImageEditPreviewFrame));
    [self.view addSubview:self.smearView];
    [self.view addSubview:self.smearTop];
    [self.view addSubview:self.smearBottom];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        self.smearTop.frame = CGRectMake(0, 0, CTImageEditPreviewFrame.size.width, CTImageEditPreviewFrame.origin.y);
        self.smearBottom.frame = CGRectMake(0, CGRectGetMaxY(CTImageEditPreviewFrame), CTImageEditPreviewFrame.size.width, CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(CTImageEditPreviewFrame));
    }completion:^(BOOL finished) {
        self.smearTop.frame = CGRectMake(0, 0, CTImageEditPreviewFrame.size.width, CTImageEditPreviewFrame.origin.y);
        self.smearBottom.frame = CGRectMake(0, CGRectGetMaxY(CTImageEditPreviewFrame), CTImageEditPreviewFrame.size.width, CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(CTImageEditPreviewFrame));
    }];
}

- (void)packageWithImage:(UIImage *)image{
    //根据image设置smearview的frame，以及改变image的大小
    
    //    UIImage *realImage = [SCCPhotoSmearUtil getScaleImageWith:[UIImage imageWithCGImage:image.CGImage scale:[UIScreen mainScreen].scale orientation:image.imageOrientation]];
    
    image = [CTImageEditUtil getScaleImageWith:image];
    CGRect bounds = [CTImageEditUtil getViewBoundWith:image];
    self.smearView.bounds = bounds;
    [self.smearView packageWithImage:image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CTImageSmearView *)smearView{
    if (!_smearView) {
        _smearView = [[CTImageSmearView alloc]init];
        _smearView.delegate = self;
    }
    return _smearView;
}

- (CTImageSmearTop *)smearTop{
    if (!_smearTop) {
        _smearTop = [[CTImageSmearTop alloc]initWithFrame:CGRectMake(0, -CTImageEditPreviewFrame.origin.y, CTImageEditPreviewFrame.size.width, CTImageEditPreviewFrame.origin.y)];
    }
    return _smearTop;
}

- (CTImageSmearBottom *)smearBottom{
    if (!_smearBottom) {
        _smearBottom = [[CTImageSmearBottom alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.bounds), CTImageEditPreviewFrame.size.width, CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(CTImageEditPreviewFrame))];
        _smearBottom.delegate = self;
    }
    return _smearBottom;
}

#pragma mark - SCCPhotoSmearBottom delegate

- (void)closeMosaic{
    //关闭viewcontroller
    [UIView animateWithDuration:0.2 animations:^{
        self.smearTop.frame = CGRectMake(0,  -CTImageEditPreviewFrame.origin.y, CTImageEditPreviewFrame.size.width, CTImageEditPreviewFrame.origin.y);
        self.smearBottom.frame = CGRectMake(0, CGRectGetMaxY(self.view.bounds), CTImageEditPreviewFrame.size.width, CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(CTImageEditPreviewFrame));
    } completion:^(BOOL finished) {
        self.smearTop.frame = CGRectMake(0,  -CTImageEditPreviewFrame.origin.y, CTImageEditPreviewFrame.size.width, CTImageEditPreviewFrame.origin.y);
        self.smearBottom.frame = CGRectMake(0, CGRectGetMaxY(self.view.bounds), CTImageEditPreviewFrame.size.width, CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(CTImageEditPreviewFrame));
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)commitMosaic{
    UIImage *image = [self.smearView finishSmear];
    if ([self.delegate respondsToSelector:@selector(didSmearPhotoWithResultImage:)]) {
        [self.delegate didSmearPhotoWithResultImage:image];
    }
    [self closeMosaic];
}

- (void)nextMosaicOperation{
    [self.smearView nexStep];
}

- (void)lastMosaicOperation{
    [self.smearView lastStep];
}

- (BOOL)hasNextMosaicOperation{
    return [self.smearView hasNextStep];
}

- (BOOL)hasLastMosaicOperation{
    return [self.smearView hasLastStep];
}

- (BOOL) prefersStatusBarHidden
{
    return YES;
}
#pragma mark - SCCPhotoSmearView Delegate

- (void)hasUpdateSmear{
    [self.smearBottom changeState];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}
@end
