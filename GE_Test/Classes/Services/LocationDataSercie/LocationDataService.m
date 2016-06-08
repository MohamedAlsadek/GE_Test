//
//  LocationDataService.m
//  GE_Test
//
//  Created by Mohamed Alsadek on 6/6/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "LocationDataService.h"


@implementation LocationDataService {
    APISuccessBlock successBlock;
    APIFailureBlockWithErrorMessage failureBlock;
    NSString *searchKeyword;
}


- (void)getSuggestLocationsForKeyword:(NSString *)keyword :(APISuccessBlock)success failure:(APIFailureBlockWithErrorMessage)failure {
    
    successBlock = success;
    failureBlock = failure;
    searchKeyword = keyword;
    
    self.locationService = [LocationService new];
    self.locationService.updateLocationDelegate = self;
    [self.locationService startUpdatingLocation];
    
}


- (void)didUpdateWithLocation:(CLLocation *)newLocation {
    [self getSuggestLocationsForKeyword:searchKeyword location:newLocation :successBlock failure:failureBlock];
}
- (void)didFailWithError:(NSString *)errorMessage {
    [self getSuggestLocationsForKeyword:searchKeyword location:nil :successBlock failure:failureBlock];
}

- (void)getSuggestLocationsForKeyword:(NSString *)keyword location:(CLLocation *)location :(APISuccessBlock)success failure:(APIFailureBlockWithErrorMessage)failure {
    
    APIService *apiService = [[APIService alloc] init];
    
    [apiService getSuggestLocationsForKeyword:keyword :^(id result) {
        
        if (result && ![result isEqual:[NSNull null]] && [result isKindOfClass:[NSArray class]]) {
            if (success) {
                NSArray *locations = [Location parseLocationObjectsFromJson:result];
                
                if (location) {
                    NSArray *sortedLocations;
                    sortedLocations = [locations sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                        
                        Location *locationA = (Location *)a;
                        Location *locationB = (Location *)b;
                        
                        CLLocation *locA = [[CLLocation alloc] initWithLatitude:[locationA.locationGeoPosition.latitude floatValue] longitude:[locationA.locationGeoPosition.longitude floatValue]];
                        
                        CLLocation *locB = [[CLLocation alloc] initWithLatitude:[locationB.locationGeoPosition.latitude floatValue] longitude:[locationA.locationGeoPosition.longitude floatValue]];
                        
                        CLLocationDistance distance1 = [locA distanceFromLocation:location];
                        CLLocationDistance distance2 = [locB distanceFromLocation:location];

                        return distance1 < distance2;
                    }];
                }
                
                success(locations);
            }
        }
    } failure:^(NSString *errorMsg) {
        if (failure) {
            failure (errorMsg);
        }
    }];
}

@end
