//
//  FITXGradientView.m
//  FITXGradientView
//
//  Created by Faizan Q. on 26/01/14.
//  Copyright (c) 2014 Daniel Williams. All rights reserved.
//

#import "FITXGradientView.h"

#define VERTICAL_START_POINT    CGPointMake(0, 0)
#define VERTICAL_END_POINT      CGPointMake(0, 1.7)

@interface FITXGradientView ()

@end

@implementation FITXGradientView

#pragma mark - UIView

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

#pragma mark - Accessors

- (CAGradientLayer *)gradientLayer
{
    return (CAGradientLayer *)self.layer;
}

- (void)setColors:(NSArray *)colors
{
    NSMutableArray *cgColors = [NSMutableArray arrayWithCapacity:colors.count];
    for (UIColor *color in colors)
    {
        [cgColors addObject:(id)[color CGColor]];
    }
    
    self.gradientLayer.startPoint = VERTICAL_START_POINT;
    self.gradientLayer.endPoint   = VERTICAL_END_POINT;

    self.gradientLayer.colors = cgColors;
}

- (NSArray *)colors
{
    NSMutableArray *uiColors = [NSMutableArray arrayWithCapacity:self.gradientLayer.colors.count];
    for (id color in self.gradientLayer.colors)
    {
        [uiColors addObject:[UIColor colorWithCGColor:(CGColorRef)color]];
    }
    
    return uiColors;
}



@end
