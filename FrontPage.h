//
//  FrontPage.h
//  DubPub
//
//  Created by deag on 30/07/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PubCategoryViewController.h"
#import "PubDetailViewController.h"
//#import "PubCategoryViewController.h"
#import "navigation.h"
#import "CellsViewController.h"
#import <iAd/iAd.h>
#import "GADBannerView.h"

@interface FrontPage : UIViewController <ADBannerViewDelegate> {
	UIButton *mapping;
	UIButton *pubList;
	UIButton *lucky;
	UIButton *piccard;
//    ADBannerView *banner;
    UIView *contentView;
    GADBannerView *adMob;
}

@property (nonatomic, retain) IBOutlet UIButton *mapping;
@property (nonatomic, retain) IBOutlet UIButton *pubList;
@property (nonatomic, retain) IBOutlet UIButton *lucky;
@property (nonatomic, retain) IBOutlet UIButton *piccard;
//@property (nonatomic, retain) IBOutlet ADBannerView *banner;
@property (nonatomic, retain) IBOutlet UIView *contentView;


- (IBAction) buttonPressed: (id)sender;
-(void)layoutForCurrentOrientation:(BOOL)animated;
-(void)createADBannerView;

@end
