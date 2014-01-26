//
//  FITXCustomCell.m
//  FitSumEvaluation
//
//  Created by lifeng on 1/26/14.
//  Copyright (c) 2014 Daniel Williams. All rights reserved.
//

#import "FITXCustomCell.h"

static CGFloat const kMCStop1                       = 0.25; // Percentage limit to trigger the first action
static CGFloat const kMCStop2                       = 0.75; // Percentage limit to trigger the second action
static CGFloat const kMCBounceAmplitude             = 20.0; // Maximum bounce amplitude when using the MCSwipeTableViewCellModeSwitch mode
static CGFloat const kMCDamping                     = 0.6;  // Damping of the spring animation
static CGFloat const kMCVelocity                    = 0.9;  // Velocity of the spring animation
static CGFloat const kMCAnimationDuration           = 0.4;  // Duration of the animation
static NSTimeInterval const kMCBounceDuration1      = 0.2;  // Duration of the first part of the bounce animation
static NSTimeInterval const kMCBounceDuration2      = 0.1;  // Duration of the second part of the bounce animation
static NSTimeInterval const kMCDurationLowLimit     = 0.25; // Lowest duration when swiping the cell because we try to simulate velocity
static NSTimeInterval const kMCDurationHightLimit   = 0.1;  // Highest duration when swiping the cell because we try to simulate velocity

typedef NS_ENUM(NSUInteger, FITXCustomCellSwipeDirection) {
    FITXCustomCellSwipeDirectionLeft = 0,
    FITXCustomCellSwipeDirectionCenter,
    FITXCustomCellSwipeDirectionRight
};

@interface FITXCustomCell()

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UIView        *slidingView;
@property (nonatomic, strong) UIImageView   *contentScreenshotView;
@end

@implementation FITXCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self initialize];
    }
    
    return self;
}

- (id) init{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void) initialize {
    //
    
    _animationDuration = kMCAnimationDuration;
    
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)];
    _panGestureRecognizer.delegate = self;
    [self addGestureRecognizer:_panGestureRecognizer];
}

- (BOOL) isSideOpen
{
    return [self.slidingView superview] != nil;
}

- (void) closeSideViewAnimated:(BOOL)animated
{
    if ([self isSideOpen])
    {
        [self swipeToDirection:FITXCustomCellSwipeDirectionCenter animated:animated completion:^{
            [self uninstallSwipingView];
        }];
    }
}

#pragma mark - Prepare reuse
- (void) didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if ([self.rightView superview] != self.slidingView)
        [self.rightView removeFromSuperview];
    
    if ([self.leftView superview] != self.slidingView)
        [self.leftView removeFromSuperview];
    
}

- (void) prepareForReuse
{
    [super prepareForReuse];
    [self uninstallSwipingView];
    
    _animationDuration = kMCAnimationDuration;
}

#pragma mark - View Manipulation

- (void)setupSwipingView {
    
    if ([self.slidingView superview] != nil) //already setup
        return;
    
    
    // If the content view background is transparent we get the background color.
    BOOL highlighted = [self isHighlighted];
    BOOL isContentViewBackgroundClear = !self.contentView.backgroundColor;
    
    if (isContentViewBackgroundClear) {
        BOOL isBackgroundClear = [self.backgroundColor isEqual:[UIColor clearColor]];
        self.contentView.backgroundColor = isBackgroundClear ? [UIColor whiteColor] :self.backgroundColor;
    }
    
    [self setHighlighted:NO];
    
    UIImage *contentViewScreenshotImage = [self imageWithView:self];
    
    if (isContentViewBackgroundClear) {
        self.contentView.backgroundColor = nil;
    }
    
    [self setHighlighted:highlighted];
    
    self.contentView.hidden = YES; //when side open, we don't need the content view visible, we use the screenshot rather.
    
    CGRect bounds = self.bounds;
    
    if (!self.contentScreenshotView)
        self.contentScreenshotView = [[UIImageView alloc] init];
    
    self.contentScreenshotView.image = contentViewScreenshotImage;
    self.contentScreenshotView.frame = CGRectMake(bounds.size.width, 0, bounds.size.width, bounds.size.height);
    
    if (!self.slidingView)
    {
        //create the sliding view
        self.slidingView = [[UIView alloc] initWithFrame:CGRectMake(-bounds.size.width, 0, bounds.size.width * 3, bounds.size.height)];
        self.slidingView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.slidingView];
        
        [self.leftView setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.leftView setFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
        
        [self.rightView setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.rightView setFrame:CGRectMake(bounds.size.width * 2, 0, bounds.size.width, bounds.size.height)];
        
        [self.slidingView addSubview:self.rightView];
        [self.slidingView addSubview:self.leftView];
        [self.slidingView addSubview:self.contentScreenshotView];
    }
    
    else
    {
        self.contentScreenshotView.image = contentViewScreenshotImage;
        self.slidingView.frame = CGRectMake(-bounds.size.width, 0, bounds.size.width * 3, bounds.size.height);
        
        [self addSubview:self.slidingView];
    }
}

- (void)uninstallSwipingView {
    
    self.contentView.hidden = NO;
    
    if ([self.slidingView superview] != nil)
    {
        [self.slidingView removeFromSuperview];
        self.contentScreenshotView.image = nil;
    }
}

#pragma mark - Handle Gestures

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)gesture {
    
    
    UIGestureRecognizerState state      = [gesture state];
    CGPoint translation                 = [gesture translationInView:self];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged) {
        
        [self setupSwipingView];
        
        CGPoint center = {self.slidingView.center.x + translation.x, self.slidingView.center.y};
        CGFloat w = self.bounds.size.width;
        
        center.x = center.x > w * 1.5 ? w * 1.5 : center.x;
        center.x = center.x < - w * 0.5 ? - w * 0.5 : center.x;
        
        self.slidingView.center = center;
        
        
        [gesture setTranslation:CGPointZero inView:self];
        
    }
    
    else if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled) {
        
        CGPoint center = [self.slidingView center];
        CGRect bounds = [self bounds];
        
        if (center.x > bounds.size.width)
        {
            //show left side
            [self swipeToDirection:FITXCustomCellSwipeDirectionLeft animated:YES completion:^{
                
            }];
        }
        else if (center.x < 0)
        {
            //show right side
            [self swipeToDirection:FITXCustomCellSwipeDirectionRight animated:YES completion:^{
                
            }];
        }
        else
        {
            //show center
            [self swipeToDirection:FITXCustomCellSwipeDirectionCenter animated:YES completion:^{
                [self uninstallSwipingView];
            }];
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if ([gestureRecognizer class] == [UIPanGestureRecognizer class]) {
        
        UIPanGestureRecognizer *g = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [g velocityInView:self];
        
        if (fabsf(point.x) > fabsf(point.y) ) {
            return [self.delegate canSwipeTableViewCell:self];
        }
    }
    
    return NO;
}

#pragma mark - Movement
- (void)swipeToDirection:(FITXCustomCellSwipeDirection)direction animated:(BOOL)animated completion:(void(^)(void))completion
{
    
    CGRect frameToSwipe = [self.slidingView frame];
    
    switch (direction) {
        case FITXCustomCellSwipeDirectionLeft:
            frameToSwipe.origin.x = 0;
            break;
        case FITXCustomCellSwipeDirectionCenter:
            frameToSwipe.origin.x = - self.bounds.size.width;
            break;
        default:
            frameToSwipe.origin.x = - self.bounds.size.width * 2;
            break;
    }
    
    if (animated)
    {
        [UIView animateWithDuration:self.animationDuration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.slidingView.frame = frameToSwipe;
                         }
                         completion:^(BOOL finished) {
                             completion();
                         }];
    }
    else
    {
        self.slidingView.frame = frameToSwipe;
        completion();
    }
    
}


#pragma mark - Utilities

- (UIImage *)imageWithView:(UIView *)view {
    short scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
