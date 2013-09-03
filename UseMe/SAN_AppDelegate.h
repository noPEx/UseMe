//
//  SAN_AppDelegate.h
//  UseMe
//
//  Created by Santhosh Kumar on 8/27/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface SAN_AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) FBSession *session;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
