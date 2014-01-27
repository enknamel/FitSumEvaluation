//
//  FITXView1Controller.m
//  FitSumEvaluation
//
//  Created by Daniel Williams on 1/25/14.
//  Copyright (c) 2014 Daniel Williams. All rights reserved.
//

#import "FITXView1Controller.h"

@interface FITXView1Controller ()

@end

@implementation FITXView1Controller

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FITXCustomCell";
    
    FITXCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[FITXCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        // iOS 7 separator
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(FITXCustomCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.delegate = self;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    FITXCustomCell *cell = (FITXCustomCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    return ![cell isSideOpen];
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    for (FITXCustomCell *visibleCell in [self.tableView visibleCells])
    {
        if ([visibleCell isSideOpen])
            [visibleCell closeSideViewAnimated:YES];
    }
}

#pragma mark Cell Delegate
- (BOOL) canSwipeTableViewCell:(FITXCustomCell *)cell
{
    for (FITXCustomCell *visibleCell in [self.tableView visibleCells])
    {
        if (visibleCell != cell && [visibleCell isSideOpen])
            [visibleCell closeSideViewAnimated:YES];
    }
    
    return YES;
}

@end
