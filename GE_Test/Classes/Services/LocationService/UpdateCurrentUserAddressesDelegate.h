//
//  UpdateCurrentUserAddressesDelegate.h
//  Fitness
//
//  Created by Nahla Mortada on 2/3/16.
//  Copyright © 2016 modeso. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UpdateCurrentUserLocationDelegate <NSObject>

- (void)didUpdateWithLocation:(CLLocation *)newLocation;
- (void)didFailWithError:(NSString *)errorMessage;

@end
