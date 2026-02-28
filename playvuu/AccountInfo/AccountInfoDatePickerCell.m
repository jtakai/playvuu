//
//  AccountInfoDatePickerCell.m
//  playvuu
//
//  Created by Marcela Nievas on 8/24/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "AccountInfoDatePickerCell.h"
#import "PVTableConstants.h"

@interface AccountInfoDatePickerCell ()

@property (nonatomic, weak) IBOutlet UILabel * fieldTitle;
@property (nonatomic, weak) IBOutlet UITextField * fieldInput;

@end


@implementation AccountInfoDatePickerCell

@synthesize fieldTitle, fieldInput;


-(void)reload
{
    [super reload];

    if (self.metadata && self.data)
    {
        fieldTitle.text = [self.metadata objectForKey:kMetadataFieldTitle];
        fieldInput.placeholder = [self.metadata objectForKey:kMetadataFieldPlaceHolder];
        fieldInput.delegate = self;
        
        NSString * outputField = [self.metadata objectForKey:kMetadataOutputField];
        NSDate * date = [self.data objectForKey:outputField];
        if (date)
        {
            fieldInput.text = [self dateFormatted:date];
        }
    }
}

-(NSString*)dateFormatted:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    return [dateFormatter stringFromDate:date];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSDate * currentDate = [self.data objectForKey:[self.metadata objectForKey:kMetadataOutputField]];
    
    if (!currentDate)
    {
        currentDate = [NSDate date];
    }
    
    [self.delegate presentDatePicketWithDate:currentDate
                                 finishBlock:^(NSDate *date)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        
        NSString * dateString = [dateFormatter stringFromDate:date];
        
        [self.data setObject:date forKey:[self.metadata objectForKey:kMetadataOutputField]];
        fieldInput.text = dateString;
        [self.delegate dataUpdated];
    }];
    
    [self.delegate cellBeingSelected:self];
    
    return NO;
}
      
@end
