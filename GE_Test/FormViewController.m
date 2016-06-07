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

@interface FormViewController () <MLPAutoCompleteTextFieldDelegate>

@property (weak, nonatomic) IBOutlet MLPAutoCompleteTextField *textFieldFrom;
@property (weak, nonatomic) IBOutlet MLPAutoCompleteTextField *textFieldTo;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDate;
 
@property (weak, nonatomic) IBOutlet UIButton *buttonSearch;

@end

@implementation FormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

#pragma mark - initUI
- (void)initUI {
    // Textfield configuration
    [self.textFieldFrom registerAutoCompleteCellClass:[CustomAutoCompleteCell class] forCellReuseIdentifier:@"CustomCellId"];
    [self.textFieldTo registerAutoCompleteCellClass:[CustomAutoCompleteCell class] forCellReuseIdentifier:@"CustomCellId"];
    
    self.textFieldDate.delegate = self;

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
    [self.view endEditing:YES];
    
    }

#pragma mark - DatePicker Handling
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.textFieldDate) {
        [self presentDatePicker];
        return NO;
    }
    return YES;
}

- (void)presentDatePicker {
    //Create select action
    RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *stringFromDate = [formatter stringFromDate:((UIDatePicker *)controller.contentView).date];
        self.textFieldDate.text = stringFromDate;
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
