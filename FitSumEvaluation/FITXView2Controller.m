//
//  FITXView2Controller.m
//  FitSumEvaluation
//
//  Created by Daniel Williams on 1/25/14.
//  Copyright (c) 2014 Daniel Williams. All rights reserved.
//

#import "FITXView2Controller.h"
#import "FITXGradientView.h"

#define BORDER_WIDTH 20

@interface FITXView2Controller ()
{
    CGRect initialFrame;
}

@property (strong, nonatomic) IBOutlet UIView *viewInnerCircle;
@property (strong, nonatomic) IBOutlet UIView *viewOuterCircle;

- (IBAction)fillColorInCircle:(id)sender;

@end

@implementation FITXView2Controller

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
    ((FITXGradientView*)self.view).colors = @[[UIColor greenColor], [UIColor blueColor]];

	// Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Store the initial frame of the circles.......
    initialFrame = _viewInnerCircle.frame;
    
    [_viewInnerCircle.layer setCornerRadius:initialFrame.size.width/2];
    [_viewOuterCircle.layer setCornerRadius:initialFrame.size.width/2];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action 

- (IBAction)fillColorInCircle:(UIButton*)circleButton
{
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anim1.duration = 0.3;
    [self.viewInnerCircle.layer addAnimation:anim1 forKey:@"cornerRadius"];
    
    if ([circleButton.currentTitle isEqualToString:@"+"])
    {
        [circleButton setTitle:@"-" forState:UIControlStateNormal];
        CGRect newFrame = initialFrame;
        newFrame.origin.x += BORDER_WIDTH/2;
        newFrame.origin.y += BORDER_WIDTH/2;
        newFrame.size.width -= BORDER_WIDTH;
        newFrame.size.height -= BORDER_WIDTH;
        
        [UIView animateWithDuration:0.3 animations:^{
            _viewInnerCircle.frame = newFrame;
            [_viewInnerCircle.layer setCornerRadius:newFrame.size.width/2];
        }];
    }
    else
    {
        [circleButton setTitle:@"+" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            _viewInnerCircle.frame = initialFrame;
            [_viewInnerCircle.layer setCornerRadius:initialFrame.size.width/2];
        }];
    }
}

@end
