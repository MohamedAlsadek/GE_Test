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
        _latitude = [[jsonDictionary objectForKey:@"latitude"] stringValue];
        _longitude = [[jsonDictionary objectForKey:@"longitude"] stringValue];
    }
    
    return self;
}

@end


@implementation Location

// Init the object with information from a dictionary
- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary {
    if(self = [self init]) {
        // Assign all properties with keyed values from the dictionary
        _locationId = [[jsonDictionary objectForKey:@"_id"] stringValue];
        _locationKey = [jsonDictionary objectForKey:@"key"];
        _locationName = [jsonDictionary objectForKey:@"name"];
        _locationFullName = [jsonDictionary objectForKey:@"fullName"];
        _locationIataAirportCode = [jsonDictionary objectForKey:@"iata_airport_code"];
        _locationType = [jsonDictionary objectForKey:@"type"];
        _locationCountry = [jsonDictionary objectForKey:@"country"];
        
        _locationGeoPosition = [[GeoPosition alloc] initWithJSONDictionary:[jsonDictionary objectForKey:@"geo_position"]];
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