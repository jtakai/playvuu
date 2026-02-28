//
//  ProfileInfoViewController.h
//  playvuu
//
//  Created by XCodeClub on 8/13/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PVUserData.h"
#import "AccountInfoCell.h"

@class AccountInfoViewController;

@protocol AccountInfoViewControllerDelegate <NSObject>
- (void)saveData:(PVUserData *)userData;
- (PVUserData *)getData;
@end

@interface AccountInfoViewController : UIViewController<AccountInfoCellParent>

@property (nonatomic, weak) id<AccountInfoViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readonly, nonatomic) NSArray *cells;

- (IBAction)saveData:(UIBarButtonItem *)sender;
- (IBAction)cancelView:(UIBarButtonItem *)sender;


@end