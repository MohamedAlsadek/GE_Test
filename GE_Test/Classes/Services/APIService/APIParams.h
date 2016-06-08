//
//  APIParams.h
//  GE_Test
//
//  Created by Mohamed Alsadek on 6/6/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#ifndef APIParams_h
#define APIParams_h



static NSString* const kBaseURL             = @"http://api.goeuro.com/api/v2/position/suggest/de/";

#pragma mark - Basic Error Handling
static const NSInteger KBadRequestError   = 400;
static const NSInteger KUnauthorizedError = 401;
static const NSInteger KForbiddenError    = 403;

static NSString * const kMFAHttpSessionManagerErrorDomain  = @"MFAErrorDomain";
static NSString * const kMFAHttpSessionManagerErrorMessage = @"MFAErrorMessage";

#endif /* APIParams_h */
