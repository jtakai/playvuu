//
//  ShuffleViewController.h
//  TestingPicker
//
//  Created by MN on 7/18/13.
//  Copyright (c) 2013 MN. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * kItemKey;
extern NSString * kItemImage;
extern NSString * kItemLabel;

@interface ShuffleViewController : UIViewController
{
    
}

-(void)setCities:(NSArray*)cities;
-(void)setReelConfiguration:(NSArray*)reels;
- (IBAction)showMenu:(id)sender;

@end
