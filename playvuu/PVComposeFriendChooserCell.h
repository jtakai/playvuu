//
//  PVComposeFriendChooserCell.h
//  playvuu
//
//  Created by Nicolas Miyasato on 9/18/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PVComposeFriendViewModel;

@interface PVComposeFriendChooserCell : UITableViewCell

-(void) setupWithModel:(PVComposeFriendViewModel*)model;

+(CGFloat) height;

@end
