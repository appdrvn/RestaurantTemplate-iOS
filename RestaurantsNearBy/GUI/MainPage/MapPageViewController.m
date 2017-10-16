//
//  MapPageViewController.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "MapPageViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface MapPageViewController ()<CLLocationManagerDelegate, GMSMapViewDelegate>

@property (nonatomic, strong) GMSMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *markers;
@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;

@end

@implementation MapPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Register the Location Manager and get the Current Location
    [self registerLocationManager];
}

- (void) registerLocationManager
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    
    [self performSelector:@selector(startUpdateLocation) withObject:nil afterDelay:0.5];
}

- (void) startUpdateLocation
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil)
    {
        [self showCurrentLocationWithLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude];
        [self.locationManager stopUpdatingLocation];
        self.locationManager.delegate = nil;
    }
}

- (void) showCurrentLocationWithLatitude:(double)latitude longitude:(double)longitude
{
    [self registerLocationManager];
    [self.locationManager startUpdatingLocation];
    
    // Create a GMSCameraPosition that tells the map to display the
    // current coordinate at zoom level 16.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:self.locationManager.location.coordinate zoom:16];
    self.mapView.camera = camera;
    
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.mapView.delegate = self;
    self.view = self.mapView;
    
    UIButton *currentLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    currentLocationButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 15 - 40, 40, 40, 40);
    [currentLocationButton setImage:[UIImage imageNamed:@"ic_my_location.png"] forState:UIControlStateNormal];
    [currentLocationButton setBackgroundColor:[UIColor colorWithRed:85.0f/255.0f green:85.0f/255.0f blue:85.0f/255.0f alpha:0.5]];
    currentLocationButton.layer.cornerRadius = currentLocationButton.frame.size.width/2;
    currentLocationButton.layer.masksToBounds = YES;
    [currentLocationButton addTarget:self action:@selector(gotoCurrentLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:currentLocationButton];
}

#pragma mark - UIButtons Actions
- (void) gotoCurrentLocation
{
    // Goto Current Location
    [self.locationManager startUpdatingLocation];
    [self.mapView animateToZoom:16];
    [self.mapView animateToLocation:self.locationManager.location.coordinate];
}

#pragma mark - Google Map Delegate
// Called when the map becomes idle, after any outstanding gestures or animations have completed (or after the camera has been explicitly set).
- (void) mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position
{
    [self loadDataWithLatitude:position.target.latitude longitude:position.target.longitude];
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    for (int i=0; i<[self.markers count]; i++)
    {
        GMSMarker *unselectedMarker = self.markers[i];
        unselectedMarker.icon = [UIImage imageNamed:@"mappin.png"];
    }
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    [self popupDetailByIndex:marker.zIndex];
    
    // The Tap has been handled so return YES
    return YES;
}

#pragma mark - Private
- (void) popupDetailByIndex:(NSInteger)index
{
    // Showing the Detail Card
    RestaurantModel *SelectedModel = (RestaurantModel *)self.dataArray[index];
    
    if ([self.delegate respondsToSelector:@selector(MapPageViewControllerDelegateDidSelectedRestaurantModel:)])
    {
        [self.delegate MapPageViewControllerDelegateDidSelectedRestaurantModel:SelectedModel];
    }
}

- (void) loadDataWithLatitude:(double)latitude longitude:(double)longitude
{
    // Remove the dummy data before putting the API method
    // You must put the API calling method at here
    // Load API to get data by the Coordinate
    // Currently the Latitude and Longitude are the center point of the GoogleMap
    
    [self createDummyData];
    
    // After pulling data from API, you should run for this [self generateMapPin:(NSArray)] method to generate the Map Pin and showing in GoogleMap
}

- (void) createDummyData
{
    // Create Dummy Data
    RestaurantModel *restaurant1 = [RestaurantModel new];
    restaurant1.name = @"Restaurant 1";
    restaurant1.distance = @"150m";
    restaurant1.detailsHtml = @"";
    restaurant1.rating = 5;
    restaurant1.reviewsCount = 1500;
    restaurant1.coordinate = [CoordinateModel new];
    restaurant1.coordinate.latitude = 3.073237;
    restaurant1.coordinate.longitude = 101.606500;
    restaurant1.imagesUrl = [NSArray arrayWithObjects:@"https://images.unsplash.com/photo-1467739792465-ac5d3aca7614?dpr=1&auto=compress,format&fit=crop&w=1050&h=&q=80&cs=tinysrgb&crop=", @"https://images.unsplash.com/photo-1414235077428-338989a2e8c0?dpr=1&auto=compress,format&fit=crop&w=1050&h=&q=80&cs=tinysrgb&crop=", nil];
    restaurant1.menus = [NSArray new];
    restaurant1.detailsHtml = @"<p>This is a Heading. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the releas</p>";
    restaurant1.address = [AddressModel new];
    restaurant1.address.lineOne = @"Sunway Pyramid Shopping Mall";
    restaurant1.address.lineTwo = @"Jalan PJS 11/15 ";
    restaurant1.address.city = @"Bandar Sunway, Petaling Jaya ";
    restaurant1.address.state = @"Selangor";
    restaurant1.address.country = @"Malaysia";
    restaurant1.address.postCode = @"47500";
    
    RestaurantModel *restaurant2 = [RestaurantModel new];
    restaurant2.name = @"Restaurant 2";
    restaurant2.distance = @"250m";
    restaurant2.detailsHtml = @"";
    restaurant2.menus = [NSArray new];
    restaurant2.rating = 5;
    restaurant2.reviewsCount = 878;
    restaurant2.coordinate = [CoordinateModel new];
    restaurant2.coordinate.latitude = 3.077961;
    restaurant2.coordinate.longitude = 101.611028;
    restaurant2.imagesUrl = [NSArray arrayWithObjects:@"https://images.unsplash.com/photo-1484659619207-9165d119dafe?dpr=1&auto=compress,format&fit=crop&w=1050&h=&q=80&cs=tinysrgb&crop=", @"https://images.unsplash.com/photo-1421622548261-c45bfe178854?dpr=1&auto=compress,format&fit=crop&w=1049&h=&q=80&cs=tinysrgb&crop=", nil];
    restaurant2.address = [AddressModel new];
    restaurant2.address.lineOne = @"6, Jalan PJS 8/13, Bandar Sunway";
    restaurant2.address.lineTwo = @"";
    restaurant2.address.city = @"Bandar Sunway, Petaling Jaya ";
    restaurant2.address.state = @"Selangor";
    restaurant2.address.country = @"Malaysia";
    restaurant2.address.postCode = @"46150";
    
    RestaurantModel *restaurant3 = [RestaurantModel new];
    restaurant3.name = @"Restaurant 3";
    restaurant3.distance = @"750m";
    restaurant3.detailsHtml = @"";
    restaurant3.menus = [NSArray new];
    restaurant3.rating = 4;
    restaurant3.reviewsCount = 200;
    restaurant3.coordinate = [CoordinateModel new];
    restaurant3.coordinate.latitude = 3.075859;
    restaurant3.coordinate.longitude = 101.588532;
    restaurant3.imagesUrl = [NSArray arrayWithObjects:@"https://images.unsplash.com/photo-1504416285472-eccf03dd31eb?dpr=1&auto=compress,format&fit=crop&w=1052&h=&q=80&cs=tinysrgb&crop=", nil];
    restaurant3.address = [AddressModel new];
    restaurant3.address.lineOne = @"61, Jalan SS 15/4b, Ss 15";
    restaurant3.address.lineTwo = @"";
    restaurant3.address.city = @"Subang Jaya ";
    restaurant3.address.state = @"Selangor";
    restaurant3.address.country = @"Malaysia";
    restaurant3.address.postCode = @"46300";
    
    RestaurantModel *restaurant4 = [RestaurantModel new];
    restaurant4.name = @"Restaurant 4";
    restaurant4.distance = @"750m";
    restaurant4.detailsHtml = @"";
    restaurant4.menus = [NSArray new];
    restaurant4.rating = 5;
    restaurant4.reviewsCount = 198;
    restaurant4.coordinate = [CoordinateModel new];
    restaurant4.coordinate.latitude = 3.076163;
    restaurant4.coordinate.longitude = 101.589704;
    restaurant4.imagesUrl = [NSArray arrayWithObjects:@"https://images.unsplash.com/photo-1482068417235-8f51fac7fc30?dpr=1&auto=compress,format&fit=crop&w=1960&h=&q=80&cs=tinysrgb&crop=", nil];
    restaurant4.address = [AddressModel new];
    restaurant4.address.lineOne = @"49, Jalan SS 15/4, Ss 15";
    restaurant4.address.lineTwo = @"";
    restaurant4.address.city = @"Subang Jaya ";
    restaurant4.address.state = @"Selangor";
    restaurant4.address.country = @"Malaysia";
    restaurant4.address.postCode = @"47500";
    
    RestaurantModel *restaurant5 = [RestaurantModel new];
    restaurant5.name = @"Restaurant 5";
    restaurant5.distance = @"2km";
    restaurant5.detailsHtml = @"";
    restaurant5.menus = [NSArray new];
    restaurant5.rating = 3;
    restaurant5.reviewsCount = 500;
    restaurant5.coordinate = [CoordinateModel new];
    restaurant5.coordinate.latitude = 3.045417;
    restaurant5.coordinate.longitude = 101.618450;
    restaurant5.imagesUrl = [NSArray arrayWithObjects:@"https://images.unsplash.com/photo-1480455454781-1af590be2a58?dpr=1&auto=compress,format&fit=crop&w=1050&h=&q=80&cs=tinysrgb&crop=", nil];
    restaurant5.address = [AddressModel new];
    restaurant5.address.lineOne = @"Ioi Mall, 23, Lebuhraya Damansara - Puchong";
    restaurant5.address.lineTwo = @"Jalan PJS 11/15 ";
    restaurant5.address.city = @"Bandar Puchong Jaya";
    restaurant5.address.state = @"Puchong, Selangor";
    restaurant5.address.country = @"Malaysia";
    restaurant5.address.postCode = @"47100";
    
    RestaurantModel *restaurant6 = [RestaurantModel new];
    restaurant6.name = @"Restaurant 6";
    restaurant6.distance = @"2.1km";
    restaurant6.detailsHtml = @"";
    restaurant6.menus = [NSArray new];
    restaurant6.rating = 3;
    restaurant6.reviewsCount = 260;
    restaurant6.coordinate = [CoordinateModel new];
    restaurant6.coordinate.latitude = 3.031626;
    restaurant6.coordinate.longitude = 101.616174;
    restaurant6.imagesUrl = [NSArray arrayWithObjects:@"https://images.unsplash.com/photo-1503365268595-ee3947b49b1b?dpr=1&auto=compress,format&fit=crop&w=1050&h=&q=80&cs=tinysrgb&crop=", nil];
    restaurant6.address = [AddressModel new];
    restaurant6.address.lineOne = @"Level G, Block H, Setia Walk";
    restaurant6.address.lineTwo = @"Persiaran Wawasan";
    restaurant6.address.city = @"Bandar Puchong Jaya";
    restaurant6.address.state = @"Puchong, Selangor";
    restaurant6.address.country = @"Malaysia";
    restaurant6.address.postCode = @"47160";
    
    RestaurantModel *restaurant7 = [RestaurantModel new];
    restaurant7.name = @"Restaurant 7";
    restaurant7.distance = @"5.4km";
    restaurant7.detailsHtml = @"";
    restaurant7.menus = [NSArray new];
    restaurant7.rating = 3;
    restaurant7.reviewsCount = 160;
    restaurant7.coordinate = [CoordinateModel new];
    restaurant7.coordinate.latitude = 3.106745;
    restaurant7.coordinate.longitude = 101.595327;
    restaurant7.imagesUrl = [NSArray arrayWithObjects:@"https://images.unsplash.com/photo-1505250785451-1c2f86d0ed70?dpr=1&auto=compress,format&fit=crop&w=634&h=&q=80&cs=tinysrgb&crop=", nil];
    restaurant7.address = [AddressModel new];
    restaurant7.address.lineOne = @"SS7";
    restaurant7.address.lineTwo = @"";
    restaurant7.address.city = @"Petaling Jaya";
    restaurant7.address.state = @"Selangor";
    restaurant7.address.country = @"Malaysia";
    restaurant7.address.postCode = @"47301";
    
    RestaurantModel *restaurant8 = [RestaurantModel new];
    restaurant8.name = @"Restaurant 8";
    restaurant8.distance = @"6km";
    restaurant8.detailsHtml = @"";
    restaurant8.menus = [NSArray new];
    restaurant8.rating = 0;
    restaurant8.reviewsCount = 0;
    restaurant8.coordinate = [CoordinateModel new];
    restaurant8.coordinate.latitude = 3.113703;
    restaurant8.coordinate.longitude = 101.593233;
    restaurant8.imagesUrl = [NSArray arrayWithObjects:@"https://images.unsplash.com/photo-1491616599759-2f0134c97da8?dpr=1&auto=compress,format&fit=crop&w=1050&h=&q=80&cs=tinysrgb&crop=", nil];
    restaurant8.address = [AddressModel new];
    restaurant8.address.lineOne = @"Jalan Emas 2";
    restaurant8.address.lineTwo = @"Taman Megah Emas";
    restaurant8.address.city = @"Petaling Jaya ";
    restaurant8.address.state = @"Selangor";
    restaurant8.address.country = @"Malaysia";
    restaurant8.address.postCode = @"47301";
    
    NSMutableArray *temp = [NSMutableArray new];
    [temp addObjectsFromArray:@[restaurant1, restaurant2, restaurant3, restaurant4, restaurant5, restaurant6, restaurant7, restaurant8]];
    
    self.dataArray = [NSArray new];
    self.dataArray = [temp copy];
    
    [self generateMapPin:[temp copy]];
}

// This method is used to create GMSMarker to display in GoogleMap
- (void) generateMapPin:(NSArray *)list
{
    self.markers = [NSMutableArray new];
    int i = 0;
    for (RestaurantModel *model in list)
    {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(model.coordinate.latitude, model.coordinate.longitude);
        marker.icon = [UIImage imageNamed:@"mappin.png"];
        marker.zIndex = i;
        marker.map = self.mapView;
        [self.markers addObject:marker];
        i++;
    }
}

@end
