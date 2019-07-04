//
//  FrontPage.m
//  DubPub
//
//  Created by deag on 30/07/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FrontPage.h"
#import "DubPubAppDelegate.h"


@implementation FrontPage

@synthesize mapping;
@synthesize pubList;
@synthesize lucky;
@synthesize piccard;
//@synthesize banner;
@synthesize contentView;


- (IBAction) buttonPressed: (id)sender {
	if (sender == mapping){
		//warning message, for the time being
		//UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not quite yet" message:@"We are still working on this bit" delegate:nil cancelButtonTitle:@"Get on with it then..." otherButtonTitles:nil];
		//[alertView show];
		//[alertView release];
		navigation *navi = [[navigation alloc] init];
		[self.navigationController pushViewController:navi animated:YES];
		[navi release];
		
	}
	if (sender == pubList){
		//launch the category list controller
		CellsViewController *cellViewController = [[CellsViewController alloc] init];
		[self.navigationController pushViewController:cellViewController animated:YES];
		[cellViewController release];
		
	}
	if (sender == lucky){
		//get a random pub
		
		//step 1: load the plists into an array
		NSArray *pubpLists = [[NSArray alloc] initWithObjects:@"Funky Pubs", @"Late Bars", @"Quiet Pints", @"Live Music", @"Trad Music", nil];
		
		//step 2: choose one of the plists and assign it's contents to another array
		int chosenNumber = arc4random() % [pubpLists count];
		NSString *chosenCategory = [pubpLists objectAtIndex:chosenNumber];
		NSString *path = [[NSBundle mainBundle] pathForResource:chosenCategory ofType:@"plist"];
		NSArray *pubCats = [[NSArray alloc] initWithContentsOfFile:path];
		
		[pubpLists release];
//		[chosenCategory release];
		//[path release];
		
		//step 3: pick out a pub at random, and load the relevant PubDetailViewController
		int randPubIndex = arc4random() % [pubCats count];
		
		NSDictionary *pubDetails = [pubCats objectAtIndex:randPubIndex];
		PubDetailViewController *pubView = [[PubDetailViewController alloc] initWithNibName:@"PubDetailViewController" bundle:[NSBundle mainBundle]];
		[self.navigationController pushViewController:pubView animated:YES];
//		pubView.pubName.text = [pubDetails objectForKey:@"pubName"];
        NSString *anim = [pubDetails objectForKey:@"pubName"];
        pubView.pubNam = anim;
        NSString *griangraf = [pubDetails objectForKey:@"pubPhoto"];
        pubView.pubPic = griangraf;
        NSString *sheoladh = [pubDetails objectForKey:@"pubAddress"];
        pubView.pubAd = sheoladh;
        NSString *blah = [pubDetails objectForKey:@"pubBlurb"];
        pubView.blurb = blah;
//		pubView.pubPhoto.image = [UIImage imageNamed:[pubDetails objectForKey:@"pubPhoto"]];
//		pubView.pubAddress.text = [pubDetails objectForKey:@"pubAddress"];
//		pubView.statusLabel.text = [pubDetails objectForKey:@"pubBlurb"];
//		[self.navigationController pushViewController:pubView animated:YES];
		//pass navigation info to the pubDetailViewController
		pubView.pubLat = [pubDetails objectForKey:@"pubLat"];
		pubView.pubLong = [pubDetails objectForKey:@"pubLong"];
		//		[self.navigationController pushViewController:pubView animated:YES];
		//		[pubDetails release];
		[pubView release];
		[pubCats release];
	}
	if (sender == piccard){
		//goto the nearest pub
		//step 1: find out what type of pub they want
		CellsViewController *cellViewController = [[CellsViewController alloc] initWithPiccard];
		[self.navigationController pushViewController:cellViewController animated:YES];
		[cellViewController release];
		
		/*
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Mutiny, I say!" message:@"We canna' get moore power, c'ptain" delegate:nil cancelButtonTitle:@"Get on with it then..." otherButtonTitles:nil];
		[alertView show];
		[alertView release];*/
	}

}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
	self.title = @"Welcome to DubPub";
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;

    [super viewDidLoad];
    
#ifdef LITE_VERSION
    /*
    [self createADBannerView];
    [self layoutForCurrentOrientation:NO];

    
    // Create a view of the standard size at the top of the screen.
    // Available AdSize constants are explained in GADAdSize.h.
    adMob= [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];

//    bannerView_ = [[GADBannerView alloc] initWithFrame:CGRectMake(0.0,
//                    self.view.frame.size.height - GAD_SIZE_320x50.height, GAD_SIZE_320x50.width,
//                                            GAD_SIZE_320x50.height)];
    
    // Specify the ad's "unit identifier". This is your AdMob Publisher ID.
    adMob.adUnitID = @"ca-app-pub-5703865094785304/9826342473";
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    adMob.rootViewController = self;
    [self.view addSubview:adMob];
//    [self.view bringSubViewToFront:bannerView_];

    GADRequest *request =[GADRequest request];
    
//    request.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID, @"32e0c1083109399d20c3121c7016f56a", nil];
    request.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID, nil];

    // Initiate a generic request to load it with an ad.
    [adMob loadRequest:request];
*/
#endif
}

-(void)viewDidAppear:(BOOL)animated
    {
        self.navigationController.navigationBar.alpha = 1;
        self.navigationItem.hidesBackButton = YES;
        [super viewDidAppear:animated];
        
#ifdef LITE_VERSION
//        [self layoutForCurrentOrientation:NO];
#endif
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
    [super viewDidUnload];
    // e.g. self.myOutlet = nil;
	self.mapping = nil;
	self.pubList = nil;
	self.lucky = nil;
	self.piccard = nil;
//    banner.delegate = nil;
//    self.banner = nil;
    
#ifdef LITE_VERSION
//    ADBannerView *adBanner = SharedAdBannerView;
//    adBanner.delegate = nil;
//    [adBanner removeFromSuperview];
//    self.contentView=nil;
//    [adMob removeFromSuperview];
#endif
}


- (void)dealloc {
	[mapping release];
	[pubList release];
	[lucky release];
	[piccard release];
//    [banner release];
#ifdef LITE_VERSION
    /*
    ADBannerView *adBanner = SharedAdBannerView;
    adBanner.delegate = nil;
    [adBanner removeFromSuperview];
    
    [contentView release];
    contentView = nil;
    
    [adMob release];
     */
#endif
    
    [super dealloc];
    
}

#pragma mark
#pragma mark ADBannerView delegate methods

 -(void)bannerViewDidLoadAd:(ADBannerView *)banner
 {
 [self layoutForCurrentOrientation:YES];
 NSLog(@"here we are");
 
 }
 
 -(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
 {
 [self layoutForCurrentOrientation:YES];
 NSLog(@"failed to recieve an Ad");
 NSLog(@"the error code is %@", [error localizedDescription]);
 }
 
 -(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
 {
 return YES;
 }
 
 -(void)bannerViewActionDidFinish:(ADBannerView *)banner
 {
 }

- (void)createADBannerView
{
    // --- WARNING ---
    // If you are planning on creating banner views at runtime in order to support iOS targets that don't support the iAd framework
    // then you will need to modify this method to do runtime checks for the symbols provided by the iAd framework
    // and you will need to weaklink iAd.framework in your project's target settings.
    // See the iPad Programming Guide, Creating a Universal Application for more information.
    // http://developer.apple.com/iphone/library/documentation/general/conceptual/iPadProgrammingGuide/Introduction/Introduction.html
    // --- WARNING ---
    
    ADBannerView *adBanner = SharedAdBannerView;
	
	// Depending on our orientation when this method is called, we set our initial content size.
    // If you only support portrait or landscape orientations, then you can remove this check and
    // select either ADBannerContentSizeIdentifierPortrait (if portrait only) or ADBannerContentSizeIdentifierLandscape (if landscape only).
	NSString *contentSize;
	if (&ADBannerContentSizeIdentifierPortrait != nil)
	{
		contentSize = UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ? ADBannerContentSizeIdentifierPortrait : ADBannerContentSizeIdentifierLandscape;
	}
	else
	{
		// user the older sizes
		contentSize = UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ? ADBannerContentSizeIdentifierPortrait : ADBannerContentSizeIdentifierLandscape;
    }
	
	// Calculate the intial location for the banner.
    // We want this banner to be at the bottom of the view controller, but placed
    // offscreen to ensure that the user won't see the banner until its ready.
    // We'll be informed when we have an ad to show because -bannerViewDidLoadAd: will be called.
    CGRect frame;
    frame.size = [ADBannerView sizeFromBannerContentSizeIdentifier:contentSize];
    frame.origin = CGPointMake(0.0f, CGRectGetMaxY(self.view.bounds));
    
    // Now set the banner view's frame
	adBanner.frame = frame;
	
    // Set the delegate to self, so that we are notified of ad responses.
	adBanner.delegate = self;
	
    // Set the autoresizing mask so that the banner is pinned to the top
    adBanner.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
	
	// Since we support all orientations in this view controller, support portrait and landscape content sizes.
    // If you only supported landscape or portrait, you could remove the other from this set
	adBanner.requiredContentSizeIdentifiers =
    (&ADBannerContentSizeIdentifierPortrait != nil) ?
    [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, nil] :
    [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, nil];
    
    // At this point the ad banner is now be visible and looking for an ad.
    [self.view addSubview:adBanner];
}

 -(void)layoutForCurrentOrientation:(BOOL)animated
 {
     ADBannerView *adBanner = SharedAdBannerView;
     
 CGFloat animationDuration = animated ? 0.2f : 0.0f;
 // by default content consumes the entire view area
 CGRect contentFrame = self.view.bounds;
 // the banner still needs to be adjusted further, but this is a reasonable starting point
 // the y value will need to be adjusted by the banner height to get the final position
 CGPoint bannerOrigin = CGPointMake(CGRectGetMinX(contentFrame), CGRectGetMaxY(contentFrame));
 CGFloat bannerHeight = 0.0f;
 
 // First, setup the banner's content size and adjustment based on the current orientation
 if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
     adBanner.currentContentSizeIdentifier = (&ADBannerContentSizeIdentifierLandscape != nil) ? ADBannerContentSizeIdentifierLandscape : ADBannerContentSizeIdentifierLandscape;
 else
     adBanner.currentContentSizeIdentifier = (&ADBannerContentSizeIdentifierPortrait != nil) ? ADBannerContentSizeIdentifierPortrait : ADBannerContentSizeIdentifierPortrait;
 
     bannerHeight = adBanner.bounds.size.height;
 
 // Depending on if the banner has been loaded, we adjust the content frame and banner location
 // to accomodate the ad being on or off screen.
 // This layout is for an ad at the bottom of the view.
 if(adBanner.bannerLoaded)
    {
        NSLog(@"the banner loaded");
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
