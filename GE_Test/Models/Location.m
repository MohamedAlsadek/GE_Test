//
//  Location.m
//  GE_Test
//
//  Created by Mohamed Alsadek on 6/6/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "Location.h"


@implementation GeoPosition

// Init the object with information from a dictionary
- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary {
    if(self = [self init]) {
        // Assign all properties with keyed values from the dictionary
        _latitude = [[jsonDictionary objectForKey:kLatitude] stringValue];
        _longitude = [[jsonDictionary objectForKey:kLongitude] stringValue];
    }
    
    return self;
}

@end


@implementation Location

// Init the object with information from a dictionary
- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary {
    if(self = [self init]) {
        // Assign all properties with keyed values from the dictionary
        _locationId = [[jsonDictionary objectForKey:kId] stringValue];
        _locationKey = [jsonDictionary objectForKey:kKey];
        _locationName = [jsonDictionary objectForKey:kName];
        _locationFullName = [jsonDictionary objectForKey:kFullName];
        _locationIataAirportCode = [jsonDictionary objectForKey:kIataAirportCode];
        _locationType = [jsonDictionary objectForKey:kType];
        _locationCountry = [jsonDictionary objectForKey:kCountry];
        
        _locationGeoPosition = [[GeoPosition alloc] initWithJSONDictionary:[jsonDictionary objectForKey:kGeoPosition]];
    }
    
    return self;
}

- (NSString *)autocompleteString {
    return _locationFullName;
}

+ (NSArray *)parseLocationObjectsFromJson:(NSDictionary *)jsonDictionary {
    
    NSArray *locations = (NSArray *)jsonDictionary ;
    
    NSMutableArray *locationObjs = [[NSMutableArray alloc] init] ;
    
    for (NSDictionary *tempLocationDict in locations) {
        Location *locationObj = [[Location alloc] initWithJSONDictionary:tempLocationDict] ;
        [locationObjs addObject:locationObj] ;
    }
    
    return locationObjs ;

}

@end