//
//  PVSocializerTableViewController.m
//  playvuu
//
//  Created by Nicolas Miyasato on 9/15/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVSocializerTableViewController.h"
#import "PVProject.h"
#import "PVVideoCell.h"

@interface PVSocializerTableViewController ()

@end

@implementation PVSocializerTableViewController

#pragma mark -
#pragma mark TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PVVideoCell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    
    static NSString *CellIdentifier = @"PVVideoCell";
    PVVideoCell *cell = (PVVideoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadFirstNibNamedWithNoOwner:[PVVideoCell class]];
        ASSERT(cell != nil);
    }
    
    PVProject *project = (PVProject *)object;
    ASSERT_CLASS(project, PVProject);
    
    cell.sharePressedBlock = ^ {
        // @TODO: Miya -- Share button pressed!
        NSLog(@"ShareButtonPressed");
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setUserInteractionEnabled:YES];
    [cell setupWithProject:project videoCellType:PVShareType];

    return cell;
}

@end
