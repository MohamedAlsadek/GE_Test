//
//  LocationService.m
//  GE_Test
//
//  Created by Mohamed Alsadek on 6/6/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "LocationService.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface LocationService ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *gps;

@end

@implementation LocationService


- (void)startUpdatingLocation   {
    
    if (!self.gps) {
        self.gps = [[CLLocationManager alloc] init];
        self.gps.delegate = self;
        [self.gps setDesiredAccuracy:kCLLocationAccuracyBest];
        
        if (![self isLocationServicesEnabled]) {
            if (self.updateLocationDelegate && [self.updateLocationDelegate respondsToSelector:@selector(didFailWithError:)]) {
                [self.updateLocationDelegate didFailWithError:@"Location Services is disabled!"];
            }
            return;
        }
        switch ([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusDenied:
            case kCLAuthorizationStatusRestricted:
            {
                // Error AuthorizationStatusRestricted
                if (self.updateLocationDelegate && [self.updateLocationDelegate respondsToSelector:@selector(didFailWithError:)]) {
                    [self.updateLocationDelegate didFailWithError:@"Fitness cannot use your location. Kindly authorize it from Location Services Settings."];
                }
                return;
            }
                break;
            case kCLAuthorizationStatusNotDetermined:
                if([self.gps respondsToSelector:@selector(requestWhenInUseAuthorization)])
                    [self.gps requestWhenInUseAuthorization];
                break;
            default:
                break;
        }
    }
    
    [self.gps startUpdatingLocation];
}


- (BOOL)isLocationServicesEnabled
{
    return [CLLocationManager locationServicesEnabled];
}
- (BOOL)hasLocationAccessPermission
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        return YES;
    }
    return NO;
}

- (void)stopUpdatingLocation    {
    [self.gps stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error  {
    // Error get location
    
    if (self.updateLocationDelegate && [self.updateLocationDelegate respondsToSelector:@selector(didFailWithError:)]) {
        [self.updateLocationDelegate didFailWithError:error.localizedDescription];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation   {
    
    [self stopUpdatingLocation];
    if (newLocation) {
        if (self.updateLocationDelegate && [self.updateLocationDelegate respondsToSelector:@selector(didFailWithError:)]) {
            
            NSLog(@"%f, %f" , newLocation.coordinate.latitude , newLocation.coordinate.longitude);
            [self.updateLocationDelegate didUpdateWithLocation:newLocation];
        }
    }
    self.updateLocationDelegate = nil; // after successfull returning remove the delegate pointer
}

@end