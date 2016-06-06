//
//  APIService.m
//  GE_Test
//
//  Created by Mohamed Alsadek on 6/6/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "APIService.h"


@interface APIService ()

@property (nonatomic, strong) HttpSessionManager *sessionManager;

@end

@implementation APIService

- (instancetype)init {
    self  = [super init];
    
    if (self) {
        _sessionManager = [[HttpSessionManager alloc] initWithBaseURL:kBaseURL];
    }
    return self;
}

- (void)getSuggestLocationsForKeyword:(NSString *)keyword :(APISuccessBlock)success failure:(APIFailureBlockWithErrorMessage)failure {
    //set request parameters
    NSString *serviceURL = [NSString stringWithFormat:@"%@%@", kBaseURL,keyword];
    [self.sessionManager getDataFromResource:serviceURL parameters:nil success:success failure:failure];
}

@end
