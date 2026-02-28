//
//  AccountInfoDatePickerViewController.h
//  playvuu
//
//  Created by Marcela Nievas on 8/24/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVTableConstants.h"

@interface AccountInfoDatePickerViewController : UIViewController

-(id)initWithDate:(NSDate*)date finishBlock:(PVDatePickerBlock)finishBlock;

@end
