//
//  LocationService.h
//  GE_Test
//
//  Created by Mohamed Alsadek on 6/6/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface LocationService : NSObject


- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

- (BOOL)isLocationServicesEnabled;
- (BOOL)hasLocationAccessPermission;

@property (copy, nonatomic) void (^updateLocation)(CLLocationCoordinate2D location, NSString *errorMSG);

@end
