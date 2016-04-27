//
//  EditView.m
//  imageEdit
//
//  Created by 黄成 on 16/4/27.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "EditView.h"
#import "EditImageManager.h"

@interface EditView ()

@property (nonatomic,strong) NSMutableArray *lineArray;

@property (nonatomic,strong) NSMutableArray *nowPointArray;

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIImage *filterGaussan;

@end

@implementation EditView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)packageWithImage:(UIImage*)image{
    self.image = image;
    self.filterGaussan = [EditImageManager filterForGaussianBlur:self.image];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    CGPoint p = [[touches anyObject] locationInView:self];
    
    self.nowPointArray = [[NSMutableArray alloc]init];
    [self.lineArray addObject:self.nowPointArray];
    [self addPoint:p];
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesCancelled:touches withEvent:event];
    CGPoint p = [[touches anyObject] locationInView:self];
    [self addPoint:p];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesEnded:touches withEvent:event];
    CGPoint p = [[touches anyObject] locationInView:self];
    [self addPoint:p];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesMoved:touches withEvent:event];
    CGPoint p = [[touches anyObject] locationInView:self];
    [self addPoint:p];
    
}

- (void)addPoint:(CGPoint)p{
    
    NSValue *point = [NSValue valueWithCGPoint:p];
    [self.nowPointArray addObject:point];
    
    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 200);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor colorWithPatternImage:self.image].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithPatternImage:self.filterGaussan].CGColor);
    
    CGContextSetLineWidth(context, 20);
    for (int i = 0 ; i < self.lineArray.count ; i ++ ) {
        NSMutableArray *array = [self.lineArray objectAtIndex:i];
        
        for (int i = 0 ; i < array.count ; i ++ ) {
            NSValue *value = [array objectAtIndex:i];
            CGPoint p = [value CGPointValue];
            if (i == 0) {
                CGContextMoveToPoint(context, p.x, p.y);
                CGContextAddLineToPoint(context, p.x, p.y);
            }else{
                CGContextAddLineToPoint(context, p.x, p.y);
            }
        }
    }
    CGContextDrawPath(context, kCGPathStroke);
    
}

- (NSMutableArray *)nowPointArray{
    if (!_nowPointArray) {
        _nowPointArray = [[NSMutableArray alloc]init];
    }
    return _nowPointArray;
}

- (NSMutableArray *)lineArray{
    if (!_lineArray) {
        _lineArray = [[NSMutableArray alloc]init];
    }
    return _lineArray;
}

@end