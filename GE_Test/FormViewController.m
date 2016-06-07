//
//  FormViewController.m
//  GE_Test
//
//  Created by Mohamed Alsadek on 6/6/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "FormViewController.h"
#import "MLPAutoCompleteTextFieldDelegate.h"
#import "MLPAutoCompleteTextField.h"
#import "CustomAutoCompleteCell.h"
#import "RMDateSelectionViewController.h"
#import "LocationService.h"
#import <pop/POP.h>

@interface FormViewController () <MLPAutoCompleteTextFieldDelegate>

@property (weak, nonatomic) IBOutlet MLPAutoCompleteTextField *textFieldFrom;
@property (weak, nonatomic) IBOutlet MLPAutoCompleteTextField *textFieldTo;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDate;
@property (weak, nonatomic) IBOutlet UIButton *buttonSearch;

//Animation Views
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIView *viewForm;


@end

@implementation FormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)viewDidAppear:(BOOL)animated {
    [self appearWithAnimation];
}

#pragma mark - initUI
- (void)initUI {
    self.viewForm.hidden = NO;
    self.viewHeader.hidden = NO;
    [self configureElements];
    [self appearWithAnimation];
}

-(void)configureElements {
    self.buttonSearch.hidden = YES;
    
    // Textfield configuration
    [self.textFieldFrom registerAutoCompleteCellClass:[CustomAutoCompleteCell class] forCellReuseIdentifier:@"CustomCellId"];
    self.textFieldFrom.delegate = self;
    
    [self.textFieldTo registerAutoCompleteCellClass:[CustomAutoCompleteCell class] forCellReuseIdentifier:@"CustomCellId"];
    self.textFieldTo.delegate = self;
    
    self.textFieldDate.delegate = self;
}

- (void)endEditing {
    [self.view endEditing:YES];
}


#pragma - mark - Animations
- (void)appearWithAnimation {
    // Animation Header View
    
    self.viewForm.hidden = NO;
    self.viewHeader.hidden = NO;
    [self animateHeaderView];
    [self animateViewForm];
}

- (void)animateHeaderView {
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.fromValue = @(0.0);
    anim.toValue = @(1.0);
    [self.viewHeader pop_addAnimation:anim forKey:@"fade"];
}

- (void)animateViewForm {
    POPSpringAnimation *spin = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    
    spin.fromValue = @(M_PI / 4);
    spin.toValue = @(0);
    spin.springBounciness = 20;
    spin.velocity = @(10);
    [self.viewForm.layer pop_addAnimation:spin forKey:@"likeAnimation"];
}

-(void)animateSearchButton {
    POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    sprintAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.9, 0.9)];
    sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    sprintAnimation.springBounciness = 20.f;
    [self.buttonSearch  pop_addAnimation:sprintAnimation forKey:@"springAnimation"];
}

#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textField 
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - MLPAutoCompleteTextField Delegate
- (BOOL)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
          shouldConfigureCell:(UITableViewCell *)cell
       withAutoCompleteString:(NSString *)autocompleteString
         withAttributedString:(NSAttributedString *)boldedString
        forAutoCompleteObject:(id<MLPAutoCompletionObject>)autocompleteObject
            forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //This is your chance to customize an autocomplete tableview cell before it appears in the autocomplete tableview    
    return YES;
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
  didSelectAutoCompleteString:(NSString *)selectedString
       withAutoCompleteObject:(id<MLPAutoCompletionObject>)selectedObject
            forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(selectedObject){
        NSLog(@"selected object from autocomplete menu %@ with string %@", selectedObject, [selectedObject autocompleteString]);
    } else {
        NSLog(@"selected string '%@' from autocomplete menu", selectedString);
    }
}

#pragma mark - Actions 

- (IBAction)actionSearch:(id)sender {
    // make sure to dismiss all keyboards
    [self endEditing];
    [self animateSearchButton];
    
}

#pragma mark - DatePicker Handling
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.textFieldDate) {
        [self presentDatePicker];
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self checkFormCompleted];
}

- (void)checkFormCompleted {
    if (![self.textFieldTo.text isEqualToString:@""] &&
        ![self.textFieldFrom.text isEqualToString:@""] &&
        ![self.textFieldDate.text isEqualToString:@""]) {
        
        self.buttonSearch.hidden = NO;
    }
    else {
        self.buttonSearch.hidden = YES;
    }
}

- (void)presentDatePicker {
    //Create select action
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *stringFromDate = [formatter stringFromDate:((UIDatePicker *)controller.contentView).date];
        self.textFieldDate.text = stringFromDate;
        [self checkFormCompleted];
    }];
    
    //Create cancel action
    RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
        NSLog(@"Date selection was canceled");
    }];
    
    //Create date selection view controller
    RMDateSelectionViewController *dateSelectionController = [RMDateSelectionViewController actionControllerWithStyle:RMActionControllerStyleWhite selectAction:selectAction andCancelAction:cancelAction];
    dateSelectionController.datePicker.datePickerMode = UIDatePickerModeDate;
    dateSelectionController.title = @"Trip Date";
    dateSelectionController.message = @"Please choose your trip date";
    
    //Now just present the date selection controller using the standard iOS presentation method
    [self presentViewController:dateSelectionController animated:YES completion:nil];
}

@end
