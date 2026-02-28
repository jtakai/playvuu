//
//  PVGridCell.h
//  playvuu
//
//  Created by Pablo Vasquez on 9/17/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PVProject.h"

@interface PVGridCell : UICollectionViewCell
-(void) setupWithProject:(PVProject*)project infoKey:(NSString *)infoKey;
@end
