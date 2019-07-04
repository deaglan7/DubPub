//
//  navigation.h
//  DubPub
//
//  Created by deag on 06/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <Mapkit/MKMapView.h>  //not going to bother with MapKit, try and implement our own mapping function


@interface navigation : UIViewController <CLLocationManagerDelegate, UIScrollViewDelegate> {
	CLLocationManager *locationManager;
	CLLocation *startpoint;
	CLLocationDegrees pubLat1;
	CLLocationDegrees pubLat2;
	CLLocationDegrees pubLat3;
	CLLocationDegrees pubLong1;
	CLLocationDegrees pubLong2;
	CLLocationDegrees pubLong3;
	

	UIScrollView *tempScrollView;
	CGPoint setOffset;
	CGPoint scrollOffset;
	UIImageView *annotate;
	UIImageView *map;
	UIImageView *locationMarker;
	UIView *myView;
	//MKMapView *navMap;
	BOOL outsideMap;
	float zoomPub;
	BOOL toggleImage;
	BOOL pubTarget;
//	UIImageView *bearingPointer;
//	UIView *bearingView;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *startpoint;
@property (nonatomic) CLLocationDegrees pubLat1;
@property (nonatomic) CLLocationDegrees pubLong1;
@property (nonatomic) CLLocationDegrees pubLat2;
@property (nonatomic) CLLocationDegrees pubLong2;
@property (nonatomic) CLLocationDegrees pubLat3;
@property (nonatomic) CLLocationDegrees pubLong3;


@property (nonatomic, retain) IBOutlet UIImageView *annotate;
@property (nonatomic, retain) IBOutlet UIView *myView;
@property (nonatomic, retain) IBOutlet UIImageView *map;

@property (nonatomic, retain) IBOutlet UIScrollView *tempScrollView;
@property (nonatomic) CGPoint setOffset;
@property (nonatomic) CGPoint scrollOffset;
@property (nonatomic) BOOL outsideMap;
@property (nonatomic) float zoomPub;
@property (nonatomic) BOOL toggleImage;
@property (nonatomic) BOOL pubTarget;
@property (nonatomic, retain) IBOutlet UIImageView *locationMarker;
//@property (nonatomic, retain) IBOutlet UIImageView *bearingPointer;
//@property (nonatomic, retain) UIView *bearingView;

-(id)initWithLatLong:(double)lat Longitude:(double)longit;
//-(void)toggleImage:(NSTimer*)timer;
//-(double)bearingInRadiansTowardsLocation:(CLLocation *)towardsLocation;
//-(void) applicationWillResign;
//-(void) myMethod;


@end
