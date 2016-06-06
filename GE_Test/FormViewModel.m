//
//  FormViewModel.m
//  GE_Test
//
//  Created by Mohamed Alsadek on 6/6/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "FormViewModel.h"
#import "LocationService.h"
#import "ViewModelUpdateUIDelegate.h"
#import "LocationDataService.h"
#import "Location.h"

@interface FormViewModel ()

@property (nonatomic, strong) NSArray *locationList;
@property (nonatomic, strong) id <ViewModelUpdateUIDelegate>updateUiDelegate;
@property (strong, nonatomic) LocationDataService *locationDataService;

// Location Params
@property (nonatomic, strong) LocationService *locationService;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *latitude;


@end

@implementation FormViewModel

- (instancetype)initWithDelegate:(id)delegate {
    self = [super init];
    if (self) {
        _updateUiDelegate = delegate;
        _locationDataService = [[LocationDataService alloc] init];
        _locationService = [[LocationService alloc] init];
    }
    return self;
}


#pragma mark - fetching data
- (void)getLocationsForKeyword:(NSString *)keyword {
    __weak __typeof(self)weakSelf = self;
    [_locationService startUpdatingLocation];
    _locationService.updateLocation = ^(CLLocationCoordinate2D location, NSString *errorMSG) {
        if (!errorMSG) {
            // If there is available location will get it and use it for sorting else return the normal sorting from the srever.
            _longitude = [NSNumber numberWithFloat:location.longitude];
            _longitude = [NSNumber numberWithFloat:location.latitude];
        }
        
        [weakSelf fetchLocationWithKeyword:keyword];
    };
}

- (void)fetchLocationWithKeyword:(NSString *)keyword {
    [self.locationDataService getSuggestLocationsForKeyword:keyword :^(id result) {
        
        if (_longitude && _latitude) {
            // 1- get sorted list.
            // 2- return sorted list.
            self.locationList = (NSArray *)result;
        }else {
            self.locationList = (NSArray *)result;
        }
        
    } failure:^(NSString *errorMsg) {
        // handle global error
        NSLog(@"%@" , errorMsg);
    }];
}


#pragma mark - override setters
- (void)setLocationList:(NSArray *)locationList {
    _locationList = locationList;
    [self callUpdateUiDelegate];
}

#pragma mark - Private helpers

- (void)callUpdateUiDelegate {
    if (self.updateUiDelegate && [self.updateUiDelegate respondsToSelector:@selector(updateUI)]) {
        [self.updateUiDelegate updateUI];
        self.updateUiDelegate = nil;
    }
}


@end
