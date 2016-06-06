//
//  FormViewController.m
//  GE_Test
//
//  Created by Mohamed Alsadek on 6/6/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "FormViewController.h"
#import "FormViewModel.h"

@interface FormViewController ()

@property (nonatomic, strong) FormViewModel *viewModel;


@end

@implementation FormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

#pragma mark - initUI
- (void)initUI {
    _viewModel = [[FormViewModel alloc] initWithDelegate:self];
    
    [self showLoadingIndicator];
    [_viewModel getLocationsForKeyword:@"ham"];
}

- (void) updateUI {
    NSLog(@"%@", _viewModel.locationList);
    [self hideLoadingIndicator];
}

#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
