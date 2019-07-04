//
//  CellsViewController.h
//  DubPub
//
//  Created by deag on 13/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <iAd/iAd.h>
#define kTableViewRowHeight 66


@interface CellsViewController : UITableViewController <CLLocationManagerDelegate, UIAlertViewDelegate, ADBannerViewDelegate> {
	NSArray	*cellContent;
	NSArray *nearestPubArray;
	NSString *viewCategory;
	BOOL nearestPub;
    BOOL nearestPubList;
	CLLocationManager *locationManager;
	CLLocation *startpoint;
	CLLocation *instLocation;
	CLLocationDistance dist1;
	CLLocationDistance dist2;
	CLLocationDistance dist3;
    UIAlertView *statusAlert;
//    ADBannerView *banner;
//    UIView *contentView;
//    UISearchBar *searchBar;
//    UIWindow *greyWindow;
}

@property (nonatomic, retain) NSArray *cellContent;
@property (nonatomic, retain) NSString *viewCategory;
@property (nonatomic) BOOL nearestPub;
@property (nonatomic) BOOL nearestPubList;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *startpoint;
@property (nonatomic, retain) CLLocation *instLocation;
@property (nonatomic, retain) NSArray *nearestPubArray;
@property (nonatomic) CLLocationDistance dist1;
@property (nonatomic) CLLocationDistance dist2;
@property (nonatomic) CLLocationDistance dist3;

@property (nonatomic, retain) UIAlertView *statusAlert;
//@property (nonatomic, retain) UISearchBar *searchBar;
//@property (nonatomic, retain) UIWindow *greyWindow;
//@property (nonatomic, retain) IBOutlet ADBannerView *banner;
//@property (nonatomic, retain) IBOutlet UIView *contentView;


-(id)initWithCategory: (NSString *)category;
-(id)initWithPiccard;
-(id)initWithNearPub:(NSArray *)nearest distance:(CLLocationDistance)dist_1 distance:(CLLocationDistance)dist_2 distance:(CLLocationDistance)dist_3 viewCategory:(NSString *)category;

-(void)stopUpdatingLocation1;
-(void)restartUpdates;

//-(void)layoutForCurrentOrientation:(BOOL)animated;
//-(void)createADBannerView;


@end
