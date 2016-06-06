//
//  ParentViewController.m
//  GE_Test
//
//  Created by Mohamed Alsadek on 6/6/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "ParentViewController.h"

@interface ParentViewController (){
    BOOL isLoadingIndicatorActive ;
}


@end

@implementation ParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - loading indicator configuration
-(void) showLoadingIndicator {
    if (isLoadingIndicatorActive) {
        return ;
    }
    
    isLoadingIndicatorActive = YES ;
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:self.spinner];
    
    [LayoutManager setConstraintCenterForView:self.spinner andView2:self.view inView:self.view] ;
    
    //switch to background thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        //back to the main thread for the UI call
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.spinner startAnimating];
        });
    });
}

-(void) hideLoadingIndicator {
    isLoadingIndicatorActive = NO ;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.spinner stopAnimating];
    });
}

@end
