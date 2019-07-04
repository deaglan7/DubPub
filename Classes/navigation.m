//
//  navigation.m
//  DubPub
//
//  Created by deag on 06/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "navigation.h"
#define ZOOM_VIEW_TAG 100
//#define kMap_North 53.07348// 53.07093		//Nantwich map
#define kMap_North 53.356                       //final dubpub map
//#define kMap_South 53.06005//53.06359		//Nantwich map
#define kMap_South 53.332
//#define kMap_East -2.50319//-2.51408		//Nantwich map
#define kMap_East -6.248
//#define kMap_West -2.53482//-2.52981		//Nantwich map
#define kMap_West -6.285
//#define kMap_Height 646//920			//Nantwich map
#define kMap_Height 1873
//#define kMap_Width 898//714			//Nantwich map
#define kMap_Width 1304
#define kMax_Map_Zoom 6
#define kDevMap NO

#define kViewWidth 318.0
#define kViewHeight 480.0
/*
#define kPi 3.141592653589793
#define DEG2RAD(degrees) (degrees * 0.01745327) // degrees * pi over 180
#define RAD2DEG(radians) (radians * 57.2957795) // radians * 180 over pi
*/
//#import "navigation.h"

/*
#define ZOOM_VIEW_TAG 100
#define ZOOM_STEP 1.5

@interface navigation (UtilityMethods)
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;
@end
*/

@implementation navigation
@synthesize locationManager, startpoint;
//@synthesize navMap;
@synthesize tempScrollView;
@synthesize setOffset;
@synthesize scrollOffset;
@synthesize annotate;
@synthesize myView;
@synthesize map;
@synthesize outsideMap;
@synthesize zoomPub;
@synthesize toggleImage;
@synthesize locationMarker;
@synthesize pubTarget;
@synthesize pubLat1, pubLat2, pubLat3, pubLong1, pubLong2, pubLong3;
//@synthesize bearingPointer;
//@synthesize bearingView;

#pragma mark -
- (void) viewDidLoad {
	self.locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [locationManager requestWhenInUseAuthorization];
	[locationManager startUpdatingLocation];
	outsideMap = NO;
	/*
	//Mapkit centering
	// Create a location for the centre of the map, in this case longitude and latitude for Nantwich, UK
	CLLocationCoordinate2D location;
	location.latitude = 53.058584;
	location.longitude = -2.517226;
	
	 
	//Create a map span
	//MKCoordinateSpan span;
	//span.latitudeDelta = 1.04*(126.766667 - 66.95);  // not sure about why these numbers
	//span.longitudeDelta = 1.04*(49.384472 - 24.520833); //I think these values mean 4% of a certain span, somewhere in the states
	//span.latitudeDelta = .001;
	//span.longitudeDelta = .001;
	
	//Now create a region, based on the location and span
	//MKCoordinateRegion region;
	//region.span = span;
	//region.center = location;
	
	//Wire up the map
//	[navMap setRegion:region animated:YES];
//	[navMap regionThatFits:region];
//		This is going to be implemented manually, so we don't need to refer to the mapkit
*/
	/*
//	This is a necessary statement to set the size of the scorll area, and depends on the size of the map image
//	tempScrollView.contentSize=CGSizeMake(915, 707);
//	if (kDevMap) map.image = [UIImage imageNamed:@"nantmap.png"];*/
	if (kDevMap) map.image = [UIImage imageNamed:@"bigmap.png"];
	tempScrollView.contentSize = map.frame.size;
	
	
	//This is a method to use for moving about within the scroll view
	//CGPoint setOneOff = CGPointMake(700.0, 3);
//	[tempScrollView setContentOffset:setOffset animated:YES];
	[tempScrollView setDelegate:self];
//	[myView sizeToFit];
//	[tempScrollView addSubview:myView];
//	[tempScrollView setBouncesZoom:YES];
	
//	[myView setUserInteractionEnabled:YES];
	
	[tempScrollView setMinimumZoomScale:1];
	[tempScrollView setMaximumZoomScale:kMax_Map_Zoom];
	[map setTag:ZOOM_VIEW_TAG];
//    NSLog(@"the device is %@ ", [UIDevice currentDevice] platformString);
    
//    [tempScrollView setZoomScale:zoomPub];
    [tempScrollView setZoomScale:1.1];
	if (zoomPub)  {
        [tempScrollView setZoomScale:zoomPub];
        [tempScrollView setContentOffset:scrollOffset];
    }
/*
	[tempScrollView setZoomScale:4];
	[tempScrollView setContentOffset:CGPointZero];
	
	CGPoint contentOffset = [tempScrollView contentOffset];
    contentOffset.x += 898;
	contentOffset.y += 0;
    [tempScrollView setContentOffset:contentOffset];
*/
//	NSLog(@"the width of tempScrollView is %f", tempScrollView.contentSize.width);
//	NSLog(@"the height of tempScrollView is %f", tempScrollView.contentSize.height);
 
	/*	NSLog(@"************-------------***************");
	NSLog(@"Hi!");
	NSLog(@"Welcome to the viewDidLoad method");
	//NSLog(@"the current value of tempScrollView.contentOffset.x is %g", tempScrollView.contentOffset.x);
	//NSLog(@"the current value of tempScrollView.bounds.size.width/2+setOffset.x is %g", (setOffset.x+tempScrollView.bounds.size.width/2) );
	//NSLog(@"the current value of tempScrollView.contentOffset.y is %g", tempScrollView.contentOffset.y);
	//NSLog(@"the current value of tempScrollView.bounds.size.height/2+setOffset.y is %g", (setOffset.y + tempScrollView.bounds.size.height/2));
	NSLog(@"the value of kMap_Width is %d", kMap_Width);
	NSLog(@"the value of kViewWidth is %f", kViewWidth);*/
	/*
	// add gesture recognizers to the image view
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    
    [doubleTap setNumberOfTapsRequired:2];
    [twoFingerTap setNumberOfTouchesRequired:2];
    
    [myView addGestureRecognizer:singleTap];
    [myView addGestureRecognizer:doubleTap];
    [myView addGestureRecognizer:twoFingerTap];
    
    [singleTap release];
    [doubleTap release];
    [twoFingerTap release];
	
	*/
	if (setOffset.y != 0) {
	//Add a new Image View to the containerview
		annotate.image = [UIImage imageNamed:@"pub_on_map_f.gif"];
		//annotate.bounds = CGRectMake(0, 0, annotate.image.size.width, annotate.image.size.height);
		[map addSubview:annotate];
		//I need to convert the size of setOffset to an offset based on the image
		float annoX = ((setOffset.x)*(kViewWidth/kMap_Width));
		float annoY = (setOffset.y)*(kViewHeight/kMap_Height);
//        NSLog(@"the value of annoX is %f", annoX);
//        NSLog(@"the value of setOffset.x is %f", setOffset.x);
		CGPoint annoC = CGPointMake(annoX, annoY);
		annotate.center = annoC;
        annotate.contentScaleFactor = zoomPub;
        locationMarker.contentScaleFactor = zoomPub;
		if (self.startpoint != nil) {
//			NSLog(@"I know where I am");
			}
		
	
//	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(toggleImage:) userInfo:nil repeats:YES];
	}
//	self.navigationController.navigationBar.translucent = YES;	
/*	bearingPointer.image = [UIImage imageNamed:@"nextbtn.png"];
	[bearingView addSubview:bearingPointer];
	NSLog(@"the description of bearinView is %@", bearingView.description);
	self.navigationController.navigationBar.alpha = 0.75;
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
				initWithCustomView:bearingView] autorelease];*/
	self.navigationController.navigationBar.alpha = 0.75;
	[super viewDidLoad];
}

- (id) initWithLatLong:(double)lat Longitude:(double)longit {
//-(id) initWithLatLong: (NSString *)lat Longitude:(NSString *)longit {
	if (self == [super init]) {
		//Take in the Lat and Long, and convert them to points on the drawing scale
//		double latDouble = CFStringGetDoubleValue(lat);
		
//		double longDouble = CFStringGetDoubleValue(longit);
		CGFloat mapWidth = kMap_East - kMap_West;
		CGFloat mapHeight = kMap_North - kMap_South;
		/*NSString *mapW = [[NSString alloc] initWithFormat:@"%g", mapWidth];
		NSString *longD = [[NSString alloc] initWithFormat:@"%g", kMap_East];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:lat message:mapW delegate:nil cancelButtonTitle:longD otherButtonTitles:nil];
		//[alert show];*/
		CGFloat annotationX = ((longit - kMap_West)/mapWidth)*kMap_Width;
		CGFloat annotationY = ((kMap_North - lat)/mapHeight)*kMap_Height;
		setOffset.x = annotationX;
		setOffset.y = annotationY;
		zoomPub = 6;

        //deal with the size of tempScrollView
	//	NSLog(@"the value of map.frame.width is %f", kViewWidth);
	//	NSLog(@"the value of map.height is %f", kViewHeight);
		CGFloat scrollOffX = ((longit - kMap_West)/mapWidth)*(kViewWidth*kMax_Map_Zoom);
		CGFloat scrollOffY = ((kMap_North - lat)/mapHeight)*(kViewHeight*kMax_Map_Zoom);
		scrollOffX -= kViewWidth/2;
		scrollOffY -= kViewHeight/2;
		scrollOffset.x = scrollOffX;
		scrollOffset.y = scrollOffY;

/*		NSLog(@"I'm in the initWithLatLong: func");
		NSLog(@"the latitude for this pub should be %g", lat);
		NSLog(@"the mapHeight is %g", mapHeight);
		NSLog(@"the annotationX value is %g", annotationX);
		NSLog(@"this all seems good, leaving the initWithLatLong function. Fare Ye Well");*/
		/*NSString *annoX = [[NSString alloc] initWithFormat:@"%g", annotationX];
		NSString *annoY = [[NSString alloc] initWithFormat:@"%g", annotationY];
		UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:annoX message:annoY delegate:nil cancelButtonTitle:longD otherButtonTitles:nil];
		[alert1 show];
		[alert1 release];*/
		
		/*
		//Convert the strings to a CGPoint, and store as setOffset
		NSString *latLong = @"{";
		latLong = [latLong stringByAppendingString:lat];
		latLong = [latLong stringByAppendingString:@", "];
		latLong = [latLong stringByAppendingString:longit];
		latLong = [latLong stringByAppendingString:@"}"];
		setOffset = CGPointFromString(latLong);
		//[latLong release];
		*/
		/*
		CLLocationDegrees latD = lat;
		CLLocationDegrees longD = longit;
		CLLocation *pubA =[[CLLocation alloc] initWithLatitude:latD longitude:longD];

		NSLog(@"the value of latD is %g", latD);
		NSLog(@"the value of pubA.coordinate.latitude is %g", pubA.coordinate.latitude);
		
		//self.pub1.coordinate = pubA.coordinate;
		*/
		CLLocationDegrees latD = lat;
		CLLocationDegrees longD = longit;
		pubLat1 = latD;
		pubLong1 = longD;
		pubTarget = YES;
	}
	return self;
}

//NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(toggleImage:) userInfo:nil repeats:YES];
/*
-(void)toggleImage:(NSTimer*)timer
{
	if(toggleImage)
	{
		annotate.hidden = YES;
		locationMarker.hidden = YES;
	}
	else 
	{
		annotate.hidden = NO;
		locationMarker.hidden = NO;
	}
	toggleImage = !toggleImage;
}
*/
/*- (void)drawRect:(CGRect)rect {
//	CGContextRef context = UIGraphicsGetCurrentContext();
	[annotate.image drawAtPoint:setOffset];
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
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	[locationManager stopUpdatingLocation];
	self.locationManager.delegate = nil;
	self.locationManager = nil;
	self.startpoint = nil;
	self.tempScrollView = nil;
	self.annotate = nil;
	self.myView = nil;
	self.map = nil;
	self.locationMarker = nil;
//    NSLog(@"I'm in the viewDidUnload function, and I've set the locationManager to nil");
//    NSLog(@"-------         ----------        -----------");
//	self.pubTarget = nil;
	//[super viewDidUnload];
	self.navigationController.navigationBar.alpha = 1;
//	self.navigationController.navigationBar.translucent = NO;

}


- (void)dealloc {
	[locationManager stopUpdatingLocation];
	self.locationManager.delegate = nil;
	[locationManager release];
//    NSLog(@"the locationManager has been deallocated!");
	[startpoint release];
	[tempScrollView release];
	[annotate release];
	[myView release];
	[map release];
//	[pubTarget release];
	[locationMarker release];
    [super dealloc];
}
/*

- (void) applicationWillResign {
	//Try and respond to multitasking events
	NSLog(@"I'm about to loose focus");
	[locationManager stopUpdatingLocation];
}

-(void) myMethod{
	[[NSNotificationCenter defaultCenter]
		addObserver:self
	 selector:@selector(applicationWillResign)
	 name:UIApplicationWillResignActiveNotification
	 object:NULL];
}*/
#pragma mark -
#pragma mark CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	
//    NSLog(@"location recieved with horizontal accuracy of %fm", newLocation.horizontalAccuracy);

    
    if (startpoint == nil)
		self.startpoint = newLocation;
	/*
	NSString *latitudeString = [[NSString alloc] initWithFormat:@"%g˚", newLocation.coordinate.latitude];
	latitudeLabel.text = latitudeString;
	[latitudeString release];
	
	NSString *longitudeString = [[NSString alloc] initWithFormat:@"%g˚", newLocation.coordinate.longitude];
	longitudeLabel.text = longitudeString;
	[longitudeString release];
	*/
/*	
	NSString *horizontalAccuracyString = [[NSString alloc] initWithFormat:@"%gm", newLocation.horizontalAccuracy];
	horizontalAccuracyLabel.text = horizontalAccuracyString;
	[horizontalAccuracyString release];
	
	NSString *altitudeString = [[NSString alloc] initWithFormat:@"%gm", newLocation.altitude];
	altitudeLabel.text = altitudeString;
	[altitudeString release];
	
	NSString *verticalAccuracyString = [[NSString alloc] initWithFormat:@"%gm", newLocation.verticalAccuracy];
	verticalAccuracyLabel.text = verticalAccuracyString;
	[verticalAccuracyString release];
	
	CLLocationDistance distance = [newLocation getDistanceFrom:startpoint];
	NSString *distanceString = [[NSString alloc] initWithFormat:@"%gm", distance];
	distanceTraveledLabel.text = distanceString;
	[distanceString release];
*/
	
	//this is to try and get the map to move as the location updates
	if(startpoint) {
		//check if the location is inside the bounds of the map, if not, send an error message
		if (newLocation.coordinate.longitude > kMap_West && newLocation.coordinate.longitude < kMap_East
		&& newLocation.coordinate.latitude > kMap_South && newLocation.coordinate.latitude < kMap_North) {
			CGFloat mapWidth = kMap_East - kMap_West;
			CGFloat mapHeight = kMap_North - kMap_South;
			CGFloat annotationX = ((newLocation.coordinate.longitude - kMap_West)/mapWidth)*kMap_Width;
			CGFloat annotationY = ((kMap_North - newLocation.coordinate.latitude)/mapHeight)*kMap_Height;
			setOffset.x = annotationX;
			setOffset.y = annotationY;
			outsideMap = NO;

			//figure out if there is a pub selected on the map
			if (pubTarget) {
		//		NSLog(@"the value of startpoint.coordinate.longitude is %g", startpoint.coordinate.longitude);
		//		NSLog(@"the value of startpoint.coordinate.latitude is %g", startpoint.coordinate.latitude);
				//	NSLog(@"the altitude of pub1 is %f", pub1.altitude);
				
				self.title = nil;
				
				CLLocation *tempLoc = [[CLLocation alloc] initWithLatitude:pubLat1 longitude:pubLong1];
                
                //02/05/11 - The dist display doesn't update, this maybe due to a ref to startpoint
                CLLocationDistance dist = [newLocation distanceFromLocation:tempLoc];
//				CLLocationDistance dist = [startpoint distanceFromLocation:tempLoc];
                self.title = [NSString stringWithFormat:@"Distance: %g m", dist];
				
/*
//				double theBearing = [newLocation bearingInRadiansTowardsLocation:tempLoc];
									//bearingInRadiansTowardsLocation:
				double lat1 = DEG2RAD(newLocation.coordinate.latitude);
				double lon1 = DEG2RAD(newLocation.coordinate.longitude);
				double lat2 = DEG2RAD(tempLoc.coordinate.latitude);
				double lon2 = DEG2RAD(tempLoc.coordinate.longitude);
				double dLon = lon2 - lon1;
				double y = sin(dLon) * cos(lat2);
				double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
				double theBearing = atan2(y, x) + (2 * kPi);
				// atan2 works on a range of -π to 0 to π, so add on 2π and perform a modulo check
				if (theBearing > (2 * kPi)) {
					theBearing = theBearing - (2 * kPi);
				}
//				double bearing = RAD2DEG(theBearing);
				
//				NSLog(@"the bearing is %g", bearing);
				if (dist<20) zoomPub = 4;
				if (dist>20 && dist<40) zoomPub = 3;
				if (dist>40 && dist<60) zoomPub = 2;
				if (dist>60) zoomPub = 1;
 
                annotate.transform = CGAffineTransformIdentity;
				annotate.transform = CGAffineTransformRotate(annotate.transform, theBearing);
*/				//annotate.transform = CGAffineTransformRotate(annotate.IdentityTransform, theBearing);							
				[tempLoc release];
			}
//			zoomPub = 4;
//			[tempScrollView setZoomScale:zoomPub];
//			[tempScrollView setContentOffset:setOffset animated:YES];
//			NSLog(@"I'm in the newLocation startpoint moving the location");
//			NSLog(@"the value of setOffset.x is %g", setOffset.x);

			//Add a new Image View to the containerview
			locationMarker.image = [UIImage imageNamed:@"my_location_f.gif"];
			[map addSubview:locationMarker];
			//		NSLog(@"the myView description is %@", [myView description]);
			//		NSLog(@"the map description is %@", [map description]);
			//I need to convert the size of setOffset to an offset based on the image
			float annoX = (setOffset.x*(kViewWidth/kMap_Width));
			float annoY = (setOffset.y*(kViewHeight/kMap_Height));
			CGPoint annoC = CGPointMake(annoX, annoY);
			locationMarker.center = annoC;
//            locationMarker.contentScaleFactor = zoomPub;
//			NSLog(@"the value of locationMarker.scale is %f", locationMarker.contentScaleFactor);
			//locationMarker.center = tempScrollView.center;
//			NSLog(@"the width of tempScrollView is %f", tempScrollView.contentSize.width);
//			NSLog(@"the height of tempScrollView is %f", tempScrollView.contentSize.height);
//			NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(toggleImage:) userInfo:nil repeats:YES];

		} else {
			if (outsideMap == NO) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You're not in Dublin!" message:@"You appear to be outside the map" delegate:nil cancelButtonTitle:@"fair 'nuf" otherButtonTitles:nil];
//				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You're not in Nantwich!" message:@"You appear to be outside the map" delegate:nil cancelButtonTitle:@"fair 'nuf" otherButtonTitles:nil];
				[alert show];
				[alert release];
				outsideMap = YES;
								}
		}
		
		//setOffset = ([CGPointFromString(tempLat)], [CGPointFromString(tempLong)]);
		//[tempScrollView setContentOffset:setOffset animated:YES];
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSString *errorType = (error.code == kCLErrorDenied) ? @"Access Denied" : @"Unknown Error";
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error getting location" message:errorType delegate:nil cancelButtonTitle:@"m'kay" otherButtonTitles:nil];
	[alert show];
	[alert release];
}
/*
-(double)bearingInRadiansTowardsLocation:(CLLocation *)towardsLocation {

		
		double lat1 = DEG2RAD(startpoint.coordinate.latitude);
		double lon1 = DEG2RAD(startpoint.coordinate.longitude);
		double lat2 = DEG2RAD(towardsLocation.coordinate.latitude);
		double lon2 = DEG2RAD(towardsLocation.coordinate.longitude);
		double dLon = lon2 - lon1;
		double y = sin(dLon) * cos(lat2);
		double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
		double bearing = atan2(y, x) + (2 * kPi);
		// atan2 works on a range of -π to 0 to π, so add on 2π and perform a modulo check
		if (bearing > (2 * kPi)) {
			bearing = bearing - (2 * kPi);
		}
		
		return bearing;
		
}
*/

#pragma mark UIScrollViewDelegate methods
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
//	return map.superview;
//	[map setContentMode:UIViewContentModeRedraw];
//	[map setContentScaleFactor:500];
//	[tempScrollView setContentSize:CGSizeMake(kMap_Width*tempScrollView.zoomScale, kMap_Height*tempScrollView.zoomScale)];
//	return [tempScrollView viewWithTag:ZOOM_VIEW_TAG];
//	return myView;
	return map;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
//	[tempScrollView setContentSize:CGSizeMake(kMap_Width*tempScrollView.zoomScale, kMap_Height*tempScrollView.zoomScale)];
	[scrollView setZoomScale:scale+0.01 animated:NO];
	[scrollView setZoomScale:scale animated:NO];
    annotate.contentScaleFactor = scale;
    locationMarker.contentScaleFactor = scale;
}




#pragma mark TapDetectingImageViewDelegate methods
/*
- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    // single tap does nothing for now
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    // double tap zooms in
    float newScale = [tempScrollView zoomScale] * ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [tempScrollView zoomToRect:zoomRect animated:YES];
}

- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {
    // two-finger tap zooms out
    float newScale = [tempScrollView zoomScale] / ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [tempScrollView zoomToRect:zoomRect animated:YES];
}

*/
#pragma mark Utility methods
/*
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates. 
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [tempScrollView frame].size.height / scale;
    zoomRect.size.width  = [tempScrollView frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}
*/

@end
