//
//  CTImageSmearTop.m
//  Pods
//
//  Created by huang cheng on 2017/2/24.
//
//

#import "CTImageSmearTop.h"
#import "UIImage+EditImageWithColor.h"

@interface CTImageSmearTop ()

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation CTImageSmearTop

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        self.titleLabel.text = @"涂抹中";
        self.backgroundColor = CTImageEditRGBColor(0x333333, 0.3);
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake((self.frame.size.width - 100 )/2, (self.frame.size.height - 30 )/2, 100, 30);
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
