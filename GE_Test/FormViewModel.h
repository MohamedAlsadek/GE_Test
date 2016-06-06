//
//  FormViewModel.h
//  GE_Test
//
//  Created by Mohamed Alsadek on 6/6/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "APIParams.h"

@interface FormViewModel : NSObject

@property (nonatomic, readonly) NSArray *locationList;

#pragma mark - Initialization
- (instancetype)initWithDelegate:(id)delegate;

#pragma mark - fetching data
- (void)getLocationsForKeyword:(NSString *)keyword;


@end
