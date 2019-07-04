//
//  CellsViewController.m
//  DubPub
//
//  Created by deag on 13/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

//#define kNantPub YES
#define kNantPub NO

#import "CellsViewController.h"
#import "CustomCell.h"
#import "PubDetailViewController.h"


@implementation CellsViewController
@synthesize cellContent, viewCategory, nearestPub, locationManager, startpoint, instLocation, nearestPubArray;
@synthesize dist1, dist2, dist3;
@synthesize statusAlert;
@synthesize nearestPubList;
//@synthesize searchBar;
//@synthesize greyWindow;
//@synthesize banner;
//@synthesize contentView;
/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
		
    }
    return self;
}
*/
- (id)initWithCategory:(NSString *)category {
	if (self == [super init]) {
		viewCategory = category;
		[category release];
//		viewCategory = @"tradmusic";//category;
	}
	return self;
}

-(id)initWithPiccard {
	if (self == [super init]) {
		nearestPub = YES;
	}
	return self;
}

-(id)initWithNearPub:(NSArray *)nearest distance:(CLLocationDistance )dist_1 distance:(CLLocationDistance)dist_2 distance:(CLLocationDistance)dist_3 viewCategory:(NSString *)category  {
	if (self == [super init]) {
//		NSLog(@"Hi. I'm in the initWithNearPub: method");
		nearestPubArray = nearest;
		viewCategory = category;
//		viewCategory = @"nantpub";
		dist1 = dist_1;
		dist2 = dist_2;
		dist3 = dist_3;
        nearestPubList = YES;
//		NSLog(@"the value of shortestDist is %g", dist);
	}
	return self;
}

- (void)viewDidLoad {

	self.title = viewCategory;

	if (viewCategory) {
//	if (viewCategory == @"tradmusic") {
		NSString *path = [[NSBundle mainBundle] pathForResource:viewCategory ofType:@"plist"];
//		NSString *path = [[NSBundle mainBundle] pathForResource:@"tradmusic" ofType:@"plist"];
	//	if (path) {
	//		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"tradmusic.plist" message:path delegate:nil cancelButtonTitle:@"Get on with it then..." otherButtonTitles:nil];
	//		[alertView show];
	//		[alertView release];
	//	}			
	NSArray *array3 = [[NSArray alloc] initWithContentsOfFile:path];
	//	[path release];
	//	if (array) {
	//	}			
		self.cellContent = array3;
		[array3 release];
		//path = nil;
		
	}
	if (viewCategory == nil) {
//	if (viewCategory != @"tradmusic") {
	//Nantpub option
		if (kNantPub == YES) {
			NSDictionary *row1 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Nantwich Pubs", @"Name", @"Pubs in your locale...........", @"Color", [UIImage imageNamed:@"blacklion.jpg"], @"pic", @"nantpub", @"category", nil];
			NSArray *array = [[NSArray alloc] initWithObjects:row1, nil];
			[row1 release];
	
			self.cellContent = array;
			[array release];
		} else {
	
	//set up the view for the first time
	NSDictionary *row1 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Late Bars", @"Name", @"Bars with extended hours", @"Color", [UIImage imageNamed:@"latebars_f.jpg"], @"pic", @"Late Bars", @"category", nil];
	NSDictionary *row2 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Quiet Pints", @"Name", @"Havens for chitting and chatting", @"Color", [UIImage imageNamed:@"quiet_f.jpg"], @"pic", @"Quiet Pints", @"category", nil];
	NSDictionary *row3 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Live Music", @"Name", @"...rockin all the way home", @"Color",[UIImage imageNamed:@"live_f.jpg"], @"pic", @"Live Music", @"category", nil];
	NSDictionary *row4 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Funky Pubs", @"Name", @"For hip young dubs", @"Color",[UIImage imageNamed:@"funky_f.jpg"], @"pic", @"Funky Pubs", @"category", nil];
	NSDictionary *row5 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Trad Music", @"Name", @"Authentic Irish music", @"Color",[UIImage imageNamed:@"trad_f.jpg"], @"pic", @"Trad Music", @"category", nil];
    NSDictionary *row6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Staff Picks", @"Name", @"Some of our favourite things...", @"Color", [UIImage imageNamed:@"staffpicks_f.jpg" ], @"pic", @"Staff Picks", @"category", nil];
    NSDictionary *row7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Dub Grub", @"Name", @"Local eateries", @"Color", [UIImage imageNamed:@"dubgrub_f.jpg" ], @"pic", @"Dub Grub", @"category", nil];

			
	NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:row1, row2, row3, row4, row5, row6, row7, nil];
	[row1 release];
	[row2 release];
	[row3 release];
	[row4 release];
	[row5 release];
    [row6 release];
    [row7 release];
            
    self.title = @"Pubs by category";
    
			if (nearestPub) {
				NSDictionary *row8 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Free WiFi Hotspots", @"Name", @"Establishments offering free wifi", @"Color", [UIImage imageNamed:@"wifilogo.png"], @"pic", @"wifi", @"category", nil];
				[array addObject:row8];
				[row8 release];
			}
				
	self.cellContent = array;
	[array release];
		}
	}

	if (nearestPub) {
		self.locationManager = [[CLLocationManager alloc] init];
		locationManager.delegate = self;
		locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [locationManager requestWhenInUseAuthorization];
		[locationManager startUpdatingLocation];
        if (instLocation==nil) {
         //   self.tableView.allowsSelection = NO;
         //   self.tableView.hidden = YES;
         //   self.title = @"locating...";
 
        /*
        //28/07/09 this code will place an activity indicator in the main view, but the view must be visible to be able to display
        
        CGRect frame = CGRectMake(150.0, 150.0, 40, 40);
        UIActivityIndicatorView *progressInd = [[UIActivityIndicatorView alloc] initWithFrame:frame];
        [progressInd startAnimating];
        progressInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [progressInd sizeToFit];
        progressInd.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                            UIViewAutoresizingFlexibleRightMargin |
                                            UIViewAutoresizingFlexibleTopMargin |
                                            UIViewAutoresizingFlexibleBottomMargin);
        
        [self.view.superview addSubview:progressInd];
        */    
        
        }
        /*greyWindow = [[UIWindow alloc] initWithFrame:[[self.tableView] bounds];
        greyWindow.windowLevel = UIWindowLevelStatusBar + 1.0f;
        greyWindow.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        greyWindow.hidden = NO;
*/        
    }
    
    
    
	[super viewDidLoad];
//    banner.delegate = self;
//    self.banner.requiredContentSizeIdentifiers = (&ADBannerContentSizeIdentifierPortrait != nil) ?
//    [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil] :
//    [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil];
	
//    [self layoutForCurrentOrientation:NO];

//	NSLog(@"the nearestPubArray has %i entries", [self.nearestPubArray count]);

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    if (nearestPub){
        instLocation = nil;
        [locationManager startUpdatingLocation];
        if (instLocation==nil) {
            self.tableView.allowsSelection = NO;
            self.tableView.hidden = YES;
            self.title = @"locating...";
            }
//        [self performSelector:@selector(stopUpdatingLocation1:) withObject:nil afterDelay:15];
        statusAlert = [[UIAlertView alloc] initWithTitle:@"Updating location...\n\n\n" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"cancel", nil];
        [statusAlert show];
        
        
        
//        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        // Adjust the indicator so it is up a few pixels from the bottom of the alert
        indicator.center = CGPointMake(statusAlert.bounds.size.width/2, statusAlert.bounds.size.height);
        [indicator startAnimating];
        [statusAlert addSubview:indicator];
        [indicator release];
        [self performSelector:@selector(stopUpdatingLocation1) withObject:nil afterDelay:45];
//        [self performSelector:@selector(restartUpdates) withObject:nil afterDelay:15];
        
        
        }
    [super viewWillAppear:animated];
//    [self layoutForCurrentOrientation:NO];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        [self stopUpdatingLocation1];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopUpdatingLocation1) object:nil];

    }
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

- (void)viewWillDisappear:(BOOL)animated {
    [locationManager stopUpdatingLocation];
    instLocation = nil;
    startpoint = nil;
    [instLocation release];
    [startpoint release];
	
    [super viewWillDisappear:animated];
}

/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[cellContent release];
	[viewCategory release];
	[nearestPubArray release];
	[locationManager release];
	[startpoint release];
	[instLocation release];
//    [greyWindow release];
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.cellContent = nil;
	self.viewCategory = nil;
//	NSLog(@"I'm in the viewDidUnload function, and I've released viewCategory");
//	NSLog(@"-----------------------------------------------------------------");
	[locationManager stopUpdatingLocation];
	self.locationManager.delegate = nil;
	self.locationManager = nil;
	self.startpoint = nil;
	self.instLocation = nil;
//    banner.delegate = nil;
//    self.banner = nil;
//    self.contentView = nil;
//	self.nearestPubArray = nil;
//    self.greyWindow = nil;
	
}


- (void)dealloc {
	[locationManager stopUpdatingLocation];
	[cellContent release];
	[viewCategory release];
//	NSLog(@"I'm in the dealloc function, and I've released viewCategory");
//	NSLog(@"-----------------------------------------------------------------");
	self.locationManager.delegate = nil;
	[locationManager release];
	[startpoint release];
	[instLocation release];
	if (nearestPub) [nearestPubArray release];
//    [banner release];
//    [contentView release];
    //	[pubDetails release];
    [super dealloc];
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (nearestPubList) {
		return [self.nearestPubArray count];
//		NSLog(@"the number of rows in section is %i", [self.nearestPubArray count]);
	} else {
		return [self.cellContent count];
	}
	
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
//    static NSString *CellTableIdentifier = @"CellIdentifier";
	
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier: CustomCellIdentifier];
    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
		for (id oneObject in nib)
			if ([oneObject isKindOfClass:[CustomCell class]])
				cell = (CustomCell *)oneObject;
    }
    
    // Set up the cell...
	NSUInteger row = [indexPath row];
	
	
	
		
	if (nearestPubList) {
        //something of a bug here, always throws a sigbrt error once user returns to pub categories screen from a list of nearby pubs
		NSDictionary *rowData = [self.nearestPubArray objectAtIndex:row];
//		NSLog(@"loading data for %@", [rowData objectForKey:@"pubName"]);
		
		if (viewCategory == @"wifi") {
			cell.nameLabel.text = [rowData objectForKey:@"WiFiName"];
			//		cell.detailLabel.text = [rowData objectForKey:@"pubAddress"];
			//		NSString *distLabel = [NSString stringWithFormat:@"%g m", dist1];
			//		cell.detailLabel.text = distLabel;
			
			cell.cellImage.image = [UIImage imageNamed:@"wifilogo.png"];
			cell.category = [rowData objectForKey:@"WiFiName"];
			
		} else {
			
		cell.nameLabel.text = [rowData objectForKey:@"pubName"];
//		cell.detailLabel.text = [rowData objectForKey:@"pubAddress"];
//		NSString *distLabel = [NSString stringWithFormat:@"%g m", dist1];
//		cell.detailLabel.text = distLabel;
		
		cell.cellImage.image = [UIImage imageNamed:[rowData objectForKey:@"pubPhoto"]];
		cell.category = [rowData objectForKey:@"pubName"];
		}
		if (row == 0) {
			NSString *distLabel = [NSString stringWithFormat:@"%g m", dist1];
			cell.detailLabel.text = distLabel;
		}
		if (row == 1) {
			NSString *distLabel = [NSString stringWithFormat:@"%g m", dist2];
			cell.detailLabel.text = distLabel;
		}
		if (row ==2) {
			NSString *distLabel = [NSString stringWithFormat:@"%g m", dist3];
			cell.detailLabel.text = distLabel;
		}
		return cell;
		
	}
	
	NSDictionary *rowData = [self.cellContent objectAtIndex:row];
	
	if (viewCategory) {
//	if (viewCategory == @"tradmusic") {
		cell.nameLabel.text = [rowData objectForKey:@"pubName"];
		cell.detailLabel.text = [rowData objectForKey:@"pubAddress"];
		cell.cellImage.image = [UIImage imageNamed:[rowData objectForKey:@"pubPhoto"]];
		cell.category = [rowData objectForKey:@"pubName"];
	}
	if (viewCategory == nil) {
//	if (viewCategory != @"tradmusic") {
	cell.nameLabel.text = [rowData objectForKey:@"Name"];
	cell.detailLabel.text = [rowData objectForKey:@"Color"];
	cell.cellImage.image = [rowData objectForKey:@"pic"];
	cell.category = [rowData objectForKey:@"category"];
//		NSLog(@"the pub is loaded, with the category %@", [rowData objectForKey:@"category"]);
	}
//	[rowData release];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return kTableViewRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	NSInteger row = [indexPath row];
/*	if (row == 4) {
		CellsViewController *cellViewController = [[CellsViewController alloc] initWithCategory:(@"tradmusic")];
		[self.navigationController pushViewController:cellViewController animated:YES];
		[cellViewController release];
		
	}*/
	if (nearestPub) {
		//do some location-based stuff
		NSDictionary *shortestDict = nil;
		NSDictionary *secondShortestDict = nil;
		NSDictionary *thirdShortestDict = nil;
		
		CLLocationDistance shortestDist = 100000000;
		CLLocationDistance secondShortestDist = 100000000;
		CLLocationDistance thirdShortestDist = 100000000;
/*		
		NSLog(@"****************------------********************");
		NSLog(@"the value is shortestDist is %f", shortestDist);
		NSLog(@"the value of secondShortestDist is %g", secondShortestDist);
		NSLog(@"the value of thirdShortestDist is %g", thirdShortestDist);
		NSLog(@"****************------------********************");
*/	
		NSDictionary *eyeDict = [self.cellContent objectAtIndex:row];
		NSString *eyeCat = [eyeDict objectForKey:@"category"];
		NSString *eyePath = [[NSBundle mainBundle] pathForResource:eyeCat ofType:@"plist"];
		NSArray *eyeArray = [NSArray arrayWithContentsOfFile:eyePath];
		NSInteger eye = [eyeArray count];
//		NSLog(@"the value of eye is %i", eye);
		for (NSInteger i=0; i<eye; i++) {
			//go get the an array of pubs
			NSDictionary *rowData = [self.cellContent objectAtIndex:row];
			NSString *category = [rowData objectForKey:@"category"];
			NSString *path = [[NSBundle mainBundle] pathForResource:category ofType:@"plist"];
//			NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
			NSArray *array = [NSArray arrayWithContentsOfFile:path];
			NSDictionary *rowData2 = [array objectAtIndex:i];
			
			
			
		//	NSString *latString = [rowData2 objectForKey:@"pubLat"];
			double latDouble = [[rowData2 objectForKey:@"pubLat"] doubleValue];
		//	NSString *longString = [rowData2 objectForKey:@"pubLong"];
			double longDouble = [[rowData2 objectForKey:@"pubLong"] doubleValue];
		//	NSLog(@"the view Category is %@", category);
			if (category == @"wifi") {
				latDouble = [[rowData2 objectForKey:@"WiFiLat"] doubleValue];
				longDouble = [[rowData2 objectForKey:@"WiFiLong"] doubleValue];
//				NSLog(@"I've recognised the WiFi category");
			}

			CLLocation *tempPubLocation = [[CLLocation alloc] initWithLatitude:latDouble longitude:longDouble];
			CLLocationDistance dist = [instLocation distanceFromLocation:tempPubLocation];
			[tempPubLocation release];

			
			if (dist<shortestDist) {
			//	NSLog(@"dist < shortestDist");
				thirdShortestDist = secondShortestDist;
				thirdShortestDict = secondShortestDict;
				secondShortestDist = shortestDist;
				secondShortestDict = shortestDict;
				shortestDist = dist;
				shortestDict = [array objectAtIndex:i];
			//	NSLog(@"the shortestDist is %f", shortestDist);
			//	NSLog(@"the pub in question is %@", [shortestDict objectForKey:@"pubName"]);
				
			} else if (dist<secondShortestDist) {
			//	NSLog(@"dist<secondShortestDist");
				thirdShortestDist = secondShortestDist;
				thirdShortestDict = secondShortestDict;
				secondShortestDist = dist;
				secondShortestDict = [array objectAtIndex:i];
			//	NSLog(@"the secondShortestDist is %f", secondShortestDist);
			} else if (dist<thirdShortestDist) {
				thirdShortestDist = dist;
				thirdShortestDict = [array objectAtIndex:i];
			}
			
		}
		NSArray *array1 = [[NSArray alloc] initWithObjects:shortestDict, secondShortestDict, thirdShortestDict, nil];
		self.nearestPubArray = array1;
		[array1 release];
//		[shortestDict release];
//		[secondShortestDict release];
//		[thirdShortestDict release];
		
/*		
		NSLog(@"the nearest pub is %@", [shortestDict objectForKey:@"pubName"]);
		NSLog(@"the second nearest pub is %@", [secondShortestDict objectForKey:@"pubName"]);
		NSLog(@"the third nearest pub is %@", [thirdShortestDict objectForKey:@"pubName"]);
		NSLog(@"*******---------===========----------");
		NSLog(@"the nearestPubArray has %i entries", [nearestPubArray count]);
*/		
 NSDictionary *rowData = [self.cellContent objectAtIndex:row];
 NSString *category = [rowData objectForKey:@"category"];
 
 		CellsViewController *cellViewController = [[CellsViewController alloc] initWithNearPub:nearestPubArray distance:shortestDist distance:secondShortestDist distance:thirdShortestDist viewCategory:category];
		[self.navigationController pushViewController:cellViewController animated:YES];
		[cellViewController release];
		return;
	}

	//Attempt to switch based on the category of the selected cell
	if (viewCategory == nil) {
	NSDictionary *rowData = [self.cellContent objectAtIndex:row];
	NSString *category = [rowData objectForKey:@"category"];
	CellsViewController *cellViewController = [[CellsViewController alloc] initWithCategory:category];
	[self.navigationController pushViewController:cellViewController animated:YES];
	[cellViewController release];
//		[category release];
//		[rowData release];
	}
	
	if (dist1) {
		
		if (viewCategory == @"wifi") {
			NSDictionary *wifiDetails = [self.nearestPubArray objectAtIndex:row];
            double wifiLatD = [[wifiDetails objectForKey:@"WiFiLat"]doubleValue];
            double wifiLongD = [[wifiDetails objectForKey:@"WiFiLong"]doubleValue];
            navigation *navi = [[navigation alloc] initWithLatLong:wifiLatD Longitude:wifiLongD];
//			navigation *navi = [[navigation alloc] initWithLatLong:[[wifiDetails objectForKey:@"WiFiLat"]doubleValue] Longitude:[[wifiDetails objectForKey:@"WiFiLong"]doubleValue]];
			[self.navigationController pushViewController:navi animated:YES];
			[navi release];
			return;
		/*
			NSLog(@"++++++++++++++++++++++++++++++++++++++");
			NSLog(@"--------------------------------------");
			NSLog(@"++++++++++++++++++++++++++++++++++++++");
			NSLog(@"--------------------------------------");
		*/

		}
	//	NSLog(@"I'm in the did select row with viewCategory method");
		NSDictionary *pubDetails = [self.nearestPubArray objectAtIndex:row];
//		NSLog(@"the name of your pub is %@", [pubDetails objectForKey:@"pubName"]);		
		//		[pubName  = objectAtIndex:row];
		// I need to sort out how to access the attributes of the individual cell here, and then pass that to the detailController
		PubDetailViewController *pubView = [[PubDetailViewController alloc] initWithNibName:@"PubDetailViewController" bundle:[NSBundle mainBundle]];
		[self.navigationController pushViewController:pubView animated:YES];
        NSString *anim = [pubDetails objectForKey:@"pubName"];
        NSString *sheoladh = [pubDetails objectForKey:@"pubAddress"];
        NSString *griangarf = [pubDetails objectForKey:@"pubPhoto"];
        NSString *blah = [pubDetails objectForKey:@"pubBlurb"];
        pubView.pubNam = anim;
        pubView.pubAd = sheoladh;
        pubView.pubPic = griangarf;
        pubView.blurb = blah;
        
//		pubView.pubName.text = [pubDetails objectForKey:@"pubName"];
//		pubView.pubPhoto.image = [UIImage imageNamed:[pubDetails objectForKey:@"pubPhoto"]];
//		pubView.pubAddress.text = [pubDetails objectForKey:@"pubAddress"];
//		pubView.statusLabel.text = [pubDetails objectForKey:@"pubBlurb"];
		
		//pass navigation info to the pubDetailViewController
		pubView.pubLat = [pubDetails objectForKey:@"pubLat"];
		pubView.pubLong = [pubDetails objectForKey:@"pubLong"];
		//		[self.navigationController pushViewController:pubView animated:YES];
		//		[pubDetails release];
		[pubView release];
		//	[pubDetails release];
		return;
	}
//	if (viewCategory == @"tradmusic") {
	if (viewCategory) {
//	NSUInteger row = [indexPath row];
		//NSLog(@"I'm in the did select row with viewCategory method");
		NSDictionary *pubDetails = [self.cellContent objectAtIndex:row];
		//NSLog(@"the name of your pub is %@", [pubDetails objectForKey:@"pubName"]);		
//		[pubName  = objectAtIndex:row];
		// I need to sort out how to access the attributes of the individual cell here, and then pass that to the detailController
		PubDetailViewController *pubView = [[PubDetailViewController alloc] initWithNibName:@"PubDetailViewController" bundle:[NSBundle mainBundle]];
		[self.navigationController pushViewController:pubView animated:YES];
        NSString *anim = [pubDetails objectForKey:@"pubName"];
        NSString *sheoladh = [pubDetails objectForKey:@"pubAddress"];
        NSString *griangarf = [pubDetails objectForKey:@"pubPhoto"];
        NSString *blah = [pubDetails objectForKey:@"pubBlurb"];
        pubView.pubNam = anim;
        pubView.pubAd = sheoladh;
        pubView.pubPic = griangarf;
        pubView.blurb = blah;

//		pubView.pubName.text = [pubDetails objectForKey:@"pubName"];
//		pubView.pubPhoto.image = [UIImage imageNamed:[pubDetails objectForKey:@"pubPhoto"]];
//		pubView.pubAddress.text = [pubDetails objectForKey:@"pubAddress"];
//		pubView.statusLabel.text = [pubDetails objectForKey:@"pubBlurb"];
		
		//pass navigation info to the pubDetailViewController
		pubView.pubLat = [pubDetails objectForKey:@"pubLat"];
		pubView.pubLong = [pubDetails objectForKey:@"pubLong"];
//		[self.navigationController pushViewController:pubView animated:YES];
//		[pubDetails release];
		[pubView release];
	//	[pubDetails release];
		
	}

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//	NSLog(@"location recieved with horizontal accuracy of %fm", newLocation.horizontalAccuracy);
    if (newLocation.horizontalAccuracy > self.locationManager.desiredAccuracy) return;
    if (startpoint == nil) self.startpoint = newLocation;
    
//    [self.locationManager stopUpdatingLocation];
    [self stopUpdatingLocation1];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopUpdatingLocation1) object:nil];
    
    self.instLocation = newLocation;
    self.tableView.allowsSelection = YES;
    self.tableView.hidden = NO;
    self.title = @"located";
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSString *errorType = (error.code == kCLErrorDenied) ? @"Access Denied" : @"Unknown Error";
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error getting location" message:errorType delegate:nil cancelButtonTitle:@"m'kay" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(void)stopUpdatingLocation1 {
    [self.locationManager stopUpdatingLocation];
//    locationManager.delegate = nil;
    
    
    [statusAlert dismissWithClickedButtonIndex:0 animated:YES];
    if (startpoint.horizontalAccuracy > self.locationManager.desiredAccuracy)
    {
    UIAlertView *alertL = [[UIAlertView alloc] initWithTitle:@"Can't find a location" message:@"If you're indoors, try step outside" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alertL show];
    [alertL release];
//        self.title = @"failed to locate";
    }
    
}

-(void)restartUpdates {
 //   NSLog(@"in the restartUpdates method");
    if (locationManager) {
        [self.locationManager stopUpdatingLocation];
        if (self.startpoint == nil) {
        [self.locationManager startUpdatingLocation];
//            NSLog(@"restarting locationmanager updates...");
        }
    }
}

#pragma mark
#pragma mark ADBannerView delegate methods
/*
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

-(void)layoutForCurrentOrientation:(BOOL)animated
{
    CGFloat animationDuration = animated ? 0.2f : 0.0f;
    // by default content consumes the entire view area
    CGRect contentFrame = self.view.bounds;
    // the banner still needs to be adjusted further, but this is a reasonable starting point
    // the y value will need to be adjusted by the banner height to get the final position
	CGPoint bannerOrigin = CGPointMake(CGRectGetMinX(contentFrame), CGRectGetMaxY(contentFrame));
    CGFloat bannerHeight = 0.0f;
    
    // First, setup the banner's content size and adjustment based on the current orientation
    if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
		banner.currentContentSizeIdentifier = (&ADBannerContentSizeIdentifierLandscape != nil) ? ADBannerContentSizeIdentifierLandscape : ADBannerContentSizeIdentifierLandscape;
    else
        banner.currentContentSizeIdentifier = (&ADBannerContentSizeIdentifierPortrait != nil) ? ADBannerContentSizeIdentifierPortrait : ADBannerContentSizeIdentifierPortrait;
    bannerHeight = banner.bounds.size.height;
	
    // Depending on if the banner has been loaded, we adjust the content frame and banner location
    // to accomodate the ad being on or off screen.
    // This layout is for an ad at the bottom of the view.
    if(banner.bannerLoaded)
    {
        NSLog(@"the banner loaded");
        contentFrame.size.height -= bannerHeight;
		bannerOrigin.y -= bannerHeight;
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
                         banner.frame = CGRectMake(bannerOrigin.x, bannerOrigin.y, banner.frame.size.width, banner.frame.size.height);
                     }];
}
*/
/*
#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}
*/


@end

