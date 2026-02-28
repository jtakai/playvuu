//
//  SocializerViewController.h
//  playvuu
//
//  Created by Pablo Vasquez on 8/13/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocializerViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *searchResults;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UIView *bubbleLayer;

- (IBAction)toggleContent:(id)sender;
- (IBAction)reloadData:(id)sender;
- (IBAction)showMenu:(id)sender;
- (IBAction)showComposer:(id)sender;

@end
