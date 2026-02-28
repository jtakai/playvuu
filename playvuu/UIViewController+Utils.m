//
//  UIViewController+Utils.m
//  playvuu
//
//  Created by Nicolas Miyasato on 9/15/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)

-(void) removeAllChildViewControllers {
    [self.childViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromParentViewController];
    }];
}

-(void)presentUserSign{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"UserSign" bundle: nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
