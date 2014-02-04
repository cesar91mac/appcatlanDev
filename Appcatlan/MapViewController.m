//
//  MapViewController.m
//  Appcatlan
//
//  Created by César Flores on 2/3/14.
//  Copyright (c) 2014 LADEMO. All rights reserved.
//

#import "MapViewController.h"


@interface MapViewController ()

- (IBAction)currentLocationTapped:(id)sender;

- (IBAction)routeTapped:(id)sender;

- (IBAction)facilitiesTapped:(id)sender;


@property (strong, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation MapViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    
    self.mapView.showsUserLocation = YES;
    
    self.mapView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)currentLocationTapped:(id)sender {

    

}

- (IBAction)routeTapped:(id)sender {



    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    
    request.source = [MKMapItem mapItemForCurrentLocation];
    
    
    //19.482291,-99.245124
    
    CLLocationCoordinate2D fesAcatlanCoordinates = CLLocationCoordinate2DMake(19.482291, -99.245124);
    
    MKPlacemark *destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:fesAcatlanCoordinates addressDictionary:nil];
    
    MKMapItem *destinationMapItem = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
    
    request.destination = destinationMapItem;
    
    request.requestsAlternateRoutes = YES;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error){
        
        if (error) {
            //handle error
        }else{
            
            [self showRoute:response];
        }
    }];

}


-(void)showRoute:(MKDirectionsResponse *)response{

    
    for (MKRoute *route in response.routes){
        
        [self.mapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
    }
    
}


- (MKOverlayRenderer*)mapView:(MKMapView*)mapView rendererForOverlay:(id< MKOverlay>)overlay{
    
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    
    renderer.lineWidth = 5.0f;
    
    renderer.strokeColor = [UIColor orangeColor];
    
    return renderer;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    MKCoordinateRegion zoomRegion  =  MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1000, 1000);
    
    [self.mapView setRegion:zoomRegion animated:YES];
    
}


- (IBAction)facilitiesTapped:(id)sender {
}
@end
