//
//  PVSocializerGridViewController.h
//  playvuu
//
//  Created by Pablo Vasquez on 9/17/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

typedef enum {GridForComposer, GridForProfile} PVGridType;

@interface PVVideoGridViewController : UICollectionViewController
@property (strong, nonatomic) PFQuery *query;
- (id) initWithItemSize:(CGSize)itemSize type:(PVGridType)type;
@property (nonatomic) PVGridType gridType;

@end
