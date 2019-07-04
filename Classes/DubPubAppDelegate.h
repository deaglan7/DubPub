//
//  DubPubAppDelegate.h
//  DubPub
//
//  Created by deag on 09/01/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
//#import "PersonListViewController.h"
#import "PubDetailViewController.h"
//#import "PubCategoryViewController.h"
#import "SecondLevelViewController.h"
#import "FrontPage.h"
#import "navigation.h"
#import <iAd/iAd.h>

#define SharedAdBannerView ((DubPubAppDelegate *)[[UIApplication sharedApplication] delegate]).adBanner


@interface DubPubAppDelegate : NSObject <UIApplicationDelegate> {

    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	UINavigationController *firstController;
//	PersonListViewController *personListViewController;
	PubDetailViewController *pubDetailViewController;
//	PubCategoryViewController *pubCategoryViewController;
	FrontPage *frontPage;
	navigation *navigation;
    UIWindow *window;
    
    //iAd adaptation
    ADBannerView *adBanner;
    
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//@property (nonatomic, retain) PersonListViewController *personListViewController;
@property (nonatomic, retain) PubDetailViewController *pubDetailViewController;
//@property (nonatomic, retain) PubCategoryViewController *pubCategoryViewController;
@property (nonatomic, retain) FrontPage *frontPage;
@property (nonatomic, retain) navigation *navigation;
@property (nonatomic, retain)  IBOutlet UINavigationController *firstController;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) ADBannerView *adBanner;

- (NSString *)applicationDocumentsDirectory;

@end

