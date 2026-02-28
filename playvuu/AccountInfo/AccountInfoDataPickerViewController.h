//
//  AccountInfoDataPickerViewController.h
//  playvuu
//
//  Created by Marcela Nievas on 8/24/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVTableConstants.h"

@interface AccountInfoDataPickerViewController : UIViewController <UIPickerViewDataSource>

-(id)initWithData:(NSString*)data values:(NSArray*)values finishBlock:(PVDataPickerBlock)finishBlock;

@end
