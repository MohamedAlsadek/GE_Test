//
//  LocationDataService.m
//  GE_Test
//
//  Created by Mohamed Alsadek on 6/6/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "LocationDataService.h"

@implementation LocationDataService


- (void)getSuggestLocationsForKeyword:(NSString *)keyword :(APISuccessBlock)success failure:(APIFailureBlockWithErrorMessage)failure {
    
    APIService *apiService = [[APIService alloc] init];
    
    [apiService getSuggestLocationsForKeyword:keyword :^(id result) {
        
        if (result && ![result isEqual:[NSNull null]] && [result isKindOfClass:[NSArray class]]) {
            if (success) {
                success([Location parseLocationObjectsFromJson:result]);
            }
        }
    } failure:^(NSString *errorMsg) {
        if (failure) {
            failure (errorMsg);
        }
    }];
    
}
@end
