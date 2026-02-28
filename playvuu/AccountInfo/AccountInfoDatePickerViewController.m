//
//  AccountInfoDatePickerViewController.m
//  playvuu
//
//  Created by Marcela Nievas on 8/24/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "AccountInfoDatePickerViewController.h"

@interface AccountInfoDatePickerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker * datePicker;
-(IBAction)done:(id)sender;

@property (copy, nonatomic) PVDatePickerBlock finisheBlock;
@property (retain, nonatomic) NSDate * date;

@end

@implementation AccountInfoDatePickerViewController

-(id)initWithDate:(NSDate*)date finishBlock:(PVDatePickerBlock)finishBlock
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        self.date = date;
        self.finisheBlock = finishBlock;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.datePicker setDate:self.date animated:NO];
}

-(IBAction)done:(id)sender
{
    self.finisheBlock([self.datePicker date]);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
