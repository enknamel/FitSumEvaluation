//
//  FITXAppDelegate.h
//  FitSumEvaluation
//
//  Created by Daniel Williams on 1/25/14.
//  Copyright (c) 2014 Daniel Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FITXAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
