//
//  DEMODataSource.m
//  MLPAutoCompleteDemo
//
//  Created by Eddy Borja on 5/28/14.
//  Copyright (c) 2014 Mainloop. All rights reserved.
//

#import "AutocompleteTextFieldDataSource.h"
#import "CustomAutoCompleteObject.h"
#import "LocationDataService.h"

@interface AutocompleteTextFieldDataSource ()

@property (strong, nonatomic) LocationDataService *locationDataService;
@property (strong, nonatomic) NSArray *countryObjects;

@end


@implementation AutocompleteTextFieldDataSource


#pragma mark - MLPAutoCompleteTextField DataSource


//example of asynchronous fetch:
- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void (^)(NSArray *))handler
{
    _locationDataService = [[LocationDataService alloc] init];
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        //Your main thread code goes in here
        
        [_locationDataService getSuggestLocationsForKeyword:string :^(id result) {
            
            handler(result);
            
        } failure:^(NSString *errorMsg) {
        
        }];
    });
}


@end
