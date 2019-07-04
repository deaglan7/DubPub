//
//  PubDetailViewController.h
//  DubPub
//
//  Created by deag on 09/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondLevelViewController.h"
#import "navigation.h"
#import <iAd/iAd.h>


@interface PubDetailViewController : UIViewController <ADBannerViewDelegate> {
	UILabel *pubAddress;
	UILabel *pubName;
	UIImageView *pubPhoto;
	UITextView *statusLabel;
    NSString *pubNam;
    NSString *pubAd;
    NSString *pubPic;
    NSString *blurb;

	//These two attributes are to allow navigation
	//UIButton *mapItButton;
	//NSString *pubLat;
	NSNumber *pubLat;	//Nantwich Pubs
	//NSString *pubLong;
	NSNumber *pubLong;	//Nantwich Pubs
    
    UIView *contentView;
}
@property (nonatomic, retain) IBOutlet UILabel *pubAddress;
@property (nonatomic, retain) IBOutlet UILabel *pubName;
@property (nonatomic, retain) IBOutlet UIImageView *pubPhoto;
@property (nonatomic, retain) IBOutlet UITextView *statusLabel;
@property (nonatomic, retain) NSString *pubNam;
@property (nonatomic, retain) NSString *pubAd;
@property (nonatomic, retain) NSString *pubPic;
@property (nonatomic, retain) NSString *blurb;

//@property (nonatomic, retain) IBOutlet UIButton *mapItButton;
@property (nonatomic, retain) NSNumber *pubLat;	//Nantwich Pubs
@property (nonatomic, retain) NSNumber *pubLong;	//Nantwich Pubs
//@property (nonatomic, retain) NSString *pubLat;
//@property (nonatomic, retain) NSString *pubLong;
@property (nonatomic, retain) IBOutlet UIView *contentView;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil button:(id)button;
- (IBAction) mapIt;
-(void)layoutForCurrentOrientation:(BOOL)animated;

@end
