//
//  FITXGradientView.h
//  FITXGradientView
//
//  Created by Faizan Q. on 26/01/14.
//  Copyright (c) 2014 Daniel Williams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FITXGradientView : UIView

@property (nonatomic, readonly) CAGradientLayer *gradientLayer;

// An Array of UIColors for the gradient
@property (nonatomic, readwrite) NSArray *colors;

@end
