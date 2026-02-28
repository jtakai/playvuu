//
//  AccountInfoDataPickerViewController.m
//  playvuu
//
//  Created by Marcela Nievas on 8/24/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "AccountInfoDataPickerViewController.h"

@interface AccountInfoDataPickerViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView * dataPicker;
@property (copy, nonatomic) PVDataPickerBlock finisheBlock;
@property (retain, nonatomic) NSString * data;
@property (retain, nonatomic) NSArray* values;

-(IBAction)done:(id)sender;

@end

@implementation AccountInfoDataPickerViewController

-(id)initWithData:(NSString*)data values:(NSArray*)values  finishBlock:(PVDataPickerBlock)finishBlock
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        self.data = data;
        self.values = values;
        self.finisheBlock = finishBlock;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.dataPicker selectRow:0 inComponent:0 animated:NO];
    [self.values enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop)
    {
        if ([obj isEqualToString:self.data])
        {
            [self.dataPicker selectRow:idx inComponent:0 animated:NO];
            *stop = YES;
        }
    }];
}

-(IBAction)done:(id)sender
{
    NSUInteger index = [self.dataPicker selectedRowInComponent:0];
    NSString * dataValue = [self.values objectAtIndex:index];
    
    self.finisheBlock(dataValue);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIPickerViewDataSource

//// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.values count];
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.values objectAtIndex:row];
    
}

@end
