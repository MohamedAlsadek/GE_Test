//
//  Location.h
//  GE_Test
//
//  Created by Mohamed Alsadek on 6/6/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLPAutoCompletionObject.h"
#pragma mark - Model - Photo
static NSString* const kId              = @"_id";
static NSString* const kKey             = @"key";
static NSString* const kName            = @"name";
static NSString* const kFullName        = @"fullName";
static NSString* const kIataAirportCode = @"iata_airport_code";
static NSString* const kType            = @"type";
static NSString* const kCountry         = @"country";
static NSString* const kGeoPosition     = @"geo_position";
static NSString* const kLatitude        = @"latitude";
static NSString* const kLongitude       = @"longitude";


@interface GeoPosition : NSObject
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
- (instancetype)initWithJSONDictionary:(NSDictionary *)jsonDictionary;

@end


@interface Location : NSObject <MLPAutoCompletionObject>

@property (nonatomic, strong) NSString *locationId ;
@property (nonatomic, strong) NSString *locationKey ;
@property (nonatomic, strong) NSString *locationName ;
@property (nonatomic, strong) NSString *locationFullName ;
@property (nonatomic, strong) NSString *locationIataAirportCode ;
@property (nonatomic, strong) NSString *locationType ;
@property (nonatomic, strong) NSString *locationCountry ;
@property (nonatomic, strong) GeoPosition *locationGeoPosition ;
- (instancetype)initWithJSONDictionary:(NSDictionary *)jsonDictionary;

// convert Json location to Objects
+ (NSArray *)parseLocationObjectsFromJson:(NSDictionary *)jsonDictionary;

@end
