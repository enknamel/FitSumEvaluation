//
//  FITXView3Controller.m
//  FitSumEvaluation
//
//  Created by Daniel Williams on 1/25/14.
//  Copyright (c) 2014 Daniel Williams. All rights reserved.
//

#import "FITXView3Controller.h"
#import "FITXGradientView.h"

@interface FITXView3Controller ()

- (IBAction)backToRoot:(id)sender;
@end

@implementation FITXView3Controller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    ((FITXGradientView*)self.view).colors = @[[UIColor greenColor], [UIColor blueColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Action

- (IBAction)backToRoot:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
