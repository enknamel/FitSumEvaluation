//
//  FITXCustomCell.h
//  FitSumEvaluation
//
//  Created by lifeng on 1/26/14.
//  Copyright (c) 2014 Daniel Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FITXCustomCell;

@protocol FITXCustomCellDelegate

@required
- (BOOL) canSwipeTableViewCell:(FITXCustomCell *)cell;

@end

@interface FITXCustomCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIView *leftView;
@property (nonatomic, strong) IBOutlet UIView *rightView;

@property (nonatomic, assign) id<FITXCustomCellDelegate> delegate;

@property (nonatomic) CGFloat animationDuration;

- (BOOL) isSideOpen;
- (void) closeSideViewAnimated:(BOOL)animated;
@end
