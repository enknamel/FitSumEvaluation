//
//  FITXView1Controller.h
//  FitSumEvaluation
//
//  Created by Daniel Williams on 1/25/14.
//  Copyright (c) 2014 Daniel Williams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FITXBaseViewController.h"
#import "FITXCustomCell.h"

@interface FITXView1Controller : FITXBaseViewController<UITableViewDelegate, UITableViewDataSource, FITXCustomCellDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@end
