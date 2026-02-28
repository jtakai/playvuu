//
//  AccountInfoCell.m
//  playvuu
//
//  Created by Marcela Nievas on 8/23/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "AccountInfoCell.h"

@implementation AccountInfoCell

@synthesize metadata, data, row;

-(void)reload
{
    // to be overwritten.
}

-(void)endEditing
{
    // to be overwritten.
}

/*
- (BOOL) textFieldShouldReturn:(UITextField*)textField {
    // Let's just suppose it's a UITableView...
    UITableView *tableView = (UITableView *)[self superview];
    
    if([tableView isKindOfClass:[UITableView class]]){
        NSInteger thisRow = [tableView indexPathForCell:self].row ;
        // next cell in table
        NSIndexPath* nextIndexPath = [NSIndexPath indexPathForRow:thisRow+1 inSection:0];
        AccountInfoCell* nextCell = (AccountInfoCell*)[tableView cellForRowAtIndexPath:nextIndexPath];
        if(nextCell && [nextCell isKindOfClass: [AccountInfoCell class]])
            [nextCell.first becomeFirstResponder] ;
        else
            [textField resignFirstResponder] ;
    }
    
    return YES ;
}
*/

@end
