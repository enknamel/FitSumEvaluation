//
//  FITXCircleView.m
//  FitSumEvaluation
//
//  Created by lifeng on 1/26/14.
//  Copyright (c) 2014 Daniel Williams. All rights reserved.
//

#import "FITXCircleView.h"

@implementation FITXCircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeDefaults];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self initializeDefaults];
    }
    return self;
}

- (void) initializeDefaults
{
    self.borderColor = [UIColor redColor];
    self.borderWidth = 3;
}

- (UIColor *)borderColor
{
    if (_borderColor)
        return _borderColor;
    
    return [UIColor redColor];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
}

- (void) drawInContext:(CGContextRef)context
{
    CGRect bounds = [self bounds];
    
    CGFloat lineWidth = self.borderWidth * 0.5;
    
    CGContextSetStrokeColorWithColor(context, [self borderColor].CGColor);
    CGContextSetLineWidth(context, lineWidth);
    CGContextStrokeEllipseInRect(context, CGRectInset(bounds, lineWidth, lineWidth));
}

@end
