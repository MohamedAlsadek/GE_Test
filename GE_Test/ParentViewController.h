//
//  ParentViewController.h
//  GE_Test
//
//  Created by Mohamed Alsadek on 6/6/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutManager.h"

@interface ParentViewController : UIViewController

/// UIElements.
@property UIActivityIndicatorView *spinner;

//Loading Indicator Functions
- (void)showLoadingIndicator;
- (void)hideLoadingIndicator;

@end
