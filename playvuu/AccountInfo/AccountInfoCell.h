//
//  AccountInfoCell.h
//  playvuu
//
//  Created by Marcela Nievas on 8/23/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVTableConstants.h"

@class AccountInfoCell;

@protocol AccountInfoCellParent <NSObject>

-(void)dataUpdated;
-(void)cellBeingSelected:(AccountInfoCell*)cell;
-(void)presentImagePickerController:(UIImagePickerController*)picker;
-(void)presentDatePicketWithDate:(NSDate*)date finishBlock:(PVDatePickerBlock)finishBlock;
-(void)presentDataPicketWithData:(NSString*)data values:(NSArray*)values finishBlock:(PVDataPickerBlock)finishBlock;
-(void)goNextCell:(AccountInfoCell*)cell;
@end


@interface AccountInfoCell : UITableViewCell //<UITextFieldDelegate>

@property (nonatomic, retain) NSDictionary * metadata;
@property (nonatomic, retain) NSMutableDictionary * data;
@property (nonatomic, assign) NSUInteger row;
@property (nonatomic, assign) id<AccountInfoCellParent> delegate;
@property (weak, nonatomic) UIResponder *first; //First responder

-(void)reload;
-(void)endEditing; // To finish up the editing process and have fresh data at self.data

@end
