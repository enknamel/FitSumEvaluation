//
//  FITXBaseViewController.m
//  FitSumEvaluation
//
//  Created by lifeng on 1/26/14.
//  Copyright (c) 2014 Daniel Williams. All rights reserved.
//

#import "FITXBaseViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface FITXBaseViewController ()

@property (nonatomic, weak) CAGradientLayer *gradientLayer;
@end

@implementation FITXBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor greenColor] CGColor],
                             (id)[[UIColor greenColor] CGColor],
                             (id)[[UIColor blueColor] CGColor],
                             (id)[[UIColor blueColor] CGColor], nil];
    gradientLayer.locations = @[@0, @0.8, @0.8, @1];
    
    
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.gradientLayer setFrame:[self.view bounds]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
