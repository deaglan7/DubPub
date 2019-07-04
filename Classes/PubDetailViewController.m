//
//  PubDetailViewController.m
//  DubPub
//
//  Created by deag on 09/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PubDetailViewController.h"
#import "DubPubAppDelegate.h"


@implementation PubDetailViewController
@synthesize pubAddress;
@synthesize pubName;
@synthesize statusLabel;
@synthesize pubPhoto;
@synthesize pubNam, pubAd, pubPic, blurb;
@synthesize pubLat, pubLong;
@synthesize contentView;
//@synthesize mapItButton;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil button:(id)button {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		if (button == button1) self.pubName.text = @"Rí Rá";
			
	}
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
//	UIScrollView *tempScrollView = (UIScrollView *)self.view;
//	tempScrollView.contentSize=CGSizeMake(320, 416);
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithTitle:(@"Map") style:UIBarButtonSystemItemAction target:self action:@selector(mapIt)] autorelease];
			//initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(mapIt)] autorelease];
//            initWithImage:[UIImage imageNamed:@"compass_f.gif"] style:UIBarButtonItemStyleBordered target:self action:@selector(mapIt)] autorelease];
/*	//test for existance of pubLat and pubLong
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The pub locations" message:pubLat delegate:self cancelButtonTitle:@"There it is" otherButtonTitles:nil];
	[alert show];
	[alert release];
 */

//04/10/14 update for iOS8
    self.pubName.text = pubNam;
    self.pubAddress.text = pubAd;
    self.pubPhoto.image = [UIImage imageNamed:pubPic];
    self.statusLabel.text = blurb;
    
#ifdef LITE_VERSION
    
    ADBannerView *adBanner = SharedAdBannerView;
    
	// set the required content sizes for this ad banner (necessary for nib-based AdBannerViews) in order to be
	// compatible for iOS 4.2 and previous versions
	adBanner.requiredContentSizeIdentifiers = (&ADBannerContentSizeIdentifierPortrait != nil) ?
    [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil] :
    [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil];
	
	// set the delegate to self, so that we are notified of ad responses
	adBanner.delegate = self;
	
    [self.view addSubview:adBanner];
	
    [self layoutForCurrentOrientation:NO];
#endif
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
#ifdef LITE_VERSION
    [self layoutForCurrentOrientation:NO];
#endif
}
- (IBAction) mapIt {
/*
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The pub locations" message:pubLat delegate:nil cancelButtonTitle:@"There it is" otherButtonTitles:nil];
	[alert show];
	[alert release];
*/
#ifdef LITE_VERSION 
    UIAlertView *paid = [[UIAlertView alloc] initWithTitle:@"Not Available" message:@"This feature is only available on the full version of DubPub" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Purchase", nil];
    [paid show];
    [paid release];
    
    return;
#endif
	double pubLatD = [pubLat doubleValue];
	double pubLongD = [pubLong doubleValue];
	navigation *navi = [[navigation alloc] initWithLatLong:pubLatD Longitude:pubLongD];
	[self.navigationController pushViewController:navi animated:YES];
	[navi release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==1) {
        NSLog(@"the purchase button was clicked");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/app/dubpub/id441607787?mt=8&uo=4"]];
    }
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	//[self.tempScrollView release];
#ifdef LITE_VERSION
    self.contentView = nil;
    
    ADBannerView *adBanner = SharedAdBannerView;
    adBanner.delegate = nil;
    [adBanner removeFromSuperview];
#endif
}


- (void)dealloc {
    
#ifdef LITE_VERSION
    [contentView release];
    contentView = nil;
    
    ADBannerView *adBanner = SharedAdBannerView;
    adBanner.delegate = nil;
    [adBanner removeFromSuperview];
    
#endif
    [super dealloc];
}

#pragma mark -
#pragma mark ADBannerViewDelegate methods

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [self layoutForCurrentOrientation:YES];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [self layoutForCurrentOrientation:YES];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
}



- (void)layoutForCurrentOrientation:(BOOL)animated
{
    CGFloat animationDuration = animated ? 0.2f : 0.0f;
    // by default content consumes the entire view area
    CGRect contentFrame = self.view.bounds;
    // the banner still needs to be adjusted further, but this is a reasonable starting point
    // the y value will need to be adjusted by the banner height to get the final position
	CGPoint bannerOrigin = CGPointMake(CGRectGetMinX(contentFrame), CGRectGetMaxY(contentFrame));
    CGFloat bannerHeight = 0.0f;
    
	ADBannerView *adBanner = SharedAdBannerView;
	
	// First, setup the banner's content size and adjustment based on the current orientation
    if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
		adBanner.currentContentSizeIdentifier = (&ADBannerContentSizeIdentifierLandscape != nil) ? ADBannerContentSizeIdentifierLandscape : ADBannerContentSizeIdentifierLandscape;
    else
        adBanner.currentContentSizeIdentifier = (&ADBannerContentSizeIdentifierPortrait != nil) ? ADBannerContentSizeIdentifierPortrait : ADBannerContentSizeIdentifierPortrait;
    bannerHeight = adBanner.bounds.size.height;
	
    // Depending on if the banner has been loaded, we adjust the content frame and banner location
    // to accomodate the ad being on or off screen.
    // This layout is for an ad at the bottom of the view.
    if (adBanner.bannerLoaded)
    {
        contentFrame.size.height -= bannerHeight;
		bannerOrigin.y = 0.0;
    }
    else
    {
		bannerOrigin.y += bannerHeight;
    }
    
    // And finally animate the changes, running layout for the content view if required.
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         contentView.frame = contentFrame;
                         [contentView layoutIfNeeded];
                         adBanner.frame = CGRectMake(bannerOrigin.x, bannerOrigin.y, adBanner.frame.size.width, adBanner.frame.size.height);
                     }];
}


@end
