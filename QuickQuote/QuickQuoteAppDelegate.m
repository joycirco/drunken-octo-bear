//
//  QuickQuoteAppDelegate.m
//  QuickQuote
//
//  Created by Steven Tuckness on 1/24/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "QuickQuoteAppDelegate.h"
#import "QuickQuoteMasterViewController.h"
#import "QuickQuoteDetailViewController.h"
#import "QuoteRequest.h"
#import "FreightItem.h"
#import "Credentials.h"
#import "AccessorialType.h"
#import "HandlingUnitType.h"
#import "ContextUtilities.h"
#import "DataModel.h"
#import "PersistedContext.h"

@implementation QuickQuoteAppDelegate

@synthesize window = _window;

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize persistedContext = _persistedContext;
//@synthesize

UISplitViewController * splitViewController;
UINavigationController * masterNavigationController;
QuickQuoteMasterViewController * controller;

UISplitViewController * splitViewController;
UINavigationController * masterNavigationController;
QuickQuoteMasterViewController * controller;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Uncomment this if the data store gets all FUBAR
    //[self deleteExistingPersistentStore];

    // test create & save?
    NSManagedObjectContext *context = [self managedObjectContext];
 
    // create and init any necessary data store objects
    ContextUtilities* cu = [[ContextUtilities alloc] init];
    
    [cu generateApplicationData:context : self.persistedContext];
    
    NSError *error;
    if (![context save:&error])
    {
        //NSLog(@"Could not save: %@", [error localizedDescription]);
        {
            NSLog(@"Failed to save to data store: %@", [error localizedDescription]);
            NSArray* detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
            if(detailedErrors != nil && [detailedErrors count] > 0)
            {
                for(NSError* detailedError in detailedErrors)
                {
                    NSLog(@"  DetailedError: %@", [detailedError userInfo]);
                }
            }
            else
            {
                NSLog(@"  %@", [error userInfo]);
            }
        }
    }
    
    // Test listing all QuoteRequests from the store
    /*NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"QuoteRequest"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (QuoteRequest *qr in fetchedObjects)
    {
        NSLog(@"OriginZip: %@", qr.originPostalCode);
        for (FreightItem* f in qr.freightItems)
        {
            NSLog(@"%.2g", [f.weight doubleValue]);
        }
    }*/
    
    /******  Swapable Detail View Code ******/
    // Override point for customization after application launch.
    splitViewController = (UISplitViewController *)self.window.rootViewController;
    masterNavigationController = [splitViewController.viewControllers objectAtIndex:0];
    //UINavigationController *masterNavigationController = [splitViewController.viewControllers lastObject];
    controller = (QuickQuoteMasterViewController *)masterNavigationController.topViewController;
    controller.splitViewController = splitViewController;
    controller.managedObjectContext = self.managedObjectContext;
    controller.persistedContext = self.persistedContext;
    splitViewController.delegate = (id)controller;
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


- (PersistedContext *)persistedContext
{
    if (_persistedContext != nil)
    {
        return _persistedContext;
    }
    
    _persistedContext = [[PersistedContext alloc] init];
    
    return _persistedContext;
}


#pragma mark - Core Data stack
//
/**
// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
// */
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

///**
// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
// */
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"QuoteRequestModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"QuickQuote.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (bool) deleteExistingPersistentStore
{
    bool bRet = true;
    
    NSPersistentStoreCoordinator *storeCoordinator;
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"QuickQuote.sqlite"];
    
    if (storeURL != nil)
    {
        
        NSError *error = nil;
        storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        
        // * Simply deleting the existing store:
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];

        if (error != nil)
        {
            bRet = false;
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    return bRet;
}


#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void)logout
{
    [controller performSegueWithIdentifier:@"homeViewSegue" sender:nil];
    [controller resetAction:nil];
    [controller.quickQuoteDetailViewController showLoginScreen];
    [DataModel reset];
    // show login screen
    //[detailviewcontroller showLoginScreen];
}


@end
