//
//  LocationDataService.h
//  GE_Test
//
//  Created by Mohamed Alsadek on 6/6/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "HttpSessionManager.h"
#import "APIService.h"
#import "Location.h"


typedef void(^DataFailureBlock)(NSString *errorMsg);
typedef void(^DataSuccessBlock)(id result);

@interface LocationDataService : NSObject


#pragma mark - Location Services
- (void)getSuggestLocationsForKeyword:(NSString *)keyword :(APISuccessBlock)success failure:(APIFailureBlockWithErrorMessage)failure;

@end
