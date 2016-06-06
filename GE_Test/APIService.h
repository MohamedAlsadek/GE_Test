//
//  APIService.h
//  GE_Test
//
//  Created by Mohamed Alsadek on 6/6/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "HttpSessionManager.h"

@interface APIService : NSObject

- (void)getSuggestLocationsForKeyword:(NSString *)keyword :(APISuccessBlock)success failure:(APIFailureBlockWithErrorMessage)failure;

@end
