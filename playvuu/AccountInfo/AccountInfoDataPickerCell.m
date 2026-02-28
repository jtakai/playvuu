//
//  AccountInfoDataPickerCell.m
//  playvuu
//
//  Created by Marcela Nievas on 8/24/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "AccountInfoDataPickerCell.h"

@interface AccountInfoDataPickerCell ()

@property (nonatomic, weak) IBOutlet UILabel * fieldTitle;
@property (nonatomic, weak) IBOutlet UITextField * fieldInput;

@end

@implementation AccountInfoDataPickerCell

@synthesize fieldTitle, fieldInput;

-(void)reload
{
    [super reload];
    
    if (self.metadata && self.data)
    {
        fieldTitle.text = [self.metadata objectForKey:kMetadataFieldTitle];
        
        NSArray * values = [self.metadata objectForKey:kMetadataValues];
        if ([values count] > 0)
        {
            fieldInput.placeholder = [values objectAtIndex:0];
        }
        else
        {
            fieldInput.placeholder = @"";
        }
        fieldInput.delegate = self;
        //self.first = fieldInput;
        
        NSString * outputField = [self.metadata objectForKey:kMetadataOutputField];
        NSString * dataValue = [self.data objectForKey:outputField];
        if (dataValue)
        {
            fieldInput.text = dataValue;
        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSString * dataValue = [self.data objectForKey:[self.metadata objectForKey:kMetadataOutputField]];
    
    if (!dataValue)
    {
        dataValue = @"";
    }
    
    NSArray * values = [self.metadata objectForKey:kMetadataValues];
    
    [self.delegate presentDataPicketWithData:dataValue
                                      values:values
                                 finishBlock:^(NSString *dataValue)
     {
         [self.data setObject:dataValue forKey:[self.metadata objectForKey:kMetadataOutputField]];
         fieldInput.text = dataValue;
         [self.delegate dataUpdated];
     }];
    
    [self.delegate cellBeingSelected:self];
    return NO;
}

@end
