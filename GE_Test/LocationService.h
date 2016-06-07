//
//  LocationService.h
//  GE_Test
//
//  Created by Mohamed Alsadek on 6/6/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "UpdateCurrentUserAddressesDelegate.h"

@interface LocationService : NSObject

@property (nonatomic, strong) id <UpdateCurrentUserLocationDelegate> updateLocationDelegate;

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

- (BOOL)isLocationServicesEnabled;
- (BOOL)hasLocationAccessPermission;

@end
