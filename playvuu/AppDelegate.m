//
//  AppDelegate.m
//  playvuu
//
//  Created by Pablo Vasquez on 7/23/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "SWRevealViewController.h"
#import "PVNavigationController.h"
#import "MenuViewController.h"
#import "cocos2d.h"
#import "Parse/Parse.h"
#import "PVUserData.h"
#import "PVUser.h"

#import "AdHocUserInfo.h"
#import "PVUser.h"
#import "PVStatusVars.h"
#import "TestFlight.h"
#define NSLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Testflight session start.
    // playvuu-dev token
    //[TestFlight takeOff:@"637455cb-a25b-4349-a8af-4a30a102636c"];
    
    // playvuu token
    [TestFlight takeOff:@"b459a3b0-d779-4452-a24b-24c0c7c6af05"];
    
    /* Setup on the root view controller */
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    NSLog(@"Launching %@", bundleIdentifier);
    
    [Parse setApplicationId:@"C16oVgZxUnw7QmFAxHvWfhPm7aG7OPjzVEHsjzqa" clientKey:@"r5N536aR70By8x8yeqmDK3yIki4HY1IOmZrFSLhx"];
    [PFFacebookUtils initializeFacebook];
    
    [PFTwitterUtils initializeWithConsumerKey:@"VTImzp8cjNvM5MUREOskA" consumerSecret:@"qBavOpJjYtjiFf3rBnM6iwMLCHs2cEP0n4wgNmqnKhU"];
    
    [PVProfile registerSubclass];
    
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    if ([currSysVer isEqualToString:@"7.0"])
        [[UINavigationBar appearance] setBarTintColor:[UIColor navigationBarBlueColor]];
    else
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar_bg.png"] forBarMetrics:UIBarMetricsDefault];    
    
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            UITextAttributeTextColor: [UIColor whiteColor],
                                                            UITextAttributeFont: [UIFont fontWithName:@"ProximaNova-Regular" size:20.0f]
                                                            }];
    
    //[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    [PVStatusVars refreshUser];
    
    
    SWRevealViewController *rootVc = (SWRevealViewController *)self.window.rootViewController;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    
    PVNavigationController *navVc = (PVNavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"MainNavigation"];
    MenuViewController *menuVc = (MenuViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"MenuView"];
    
    [rootVc setRearViewController:menuVc];
    [rootVc setFrontViewController:navVc];
    
    /*
    PFQuery *query = [PVUser query];
    
    PVUser *user = (PVUser *)[PVUser currentUser];
    
    if([user isAuthenticated])
        [user.userData fetchIfNeeded];*/

    /*[AdHocUserInfo addUsers];
    [AdHocUserInfo addPics];*/
    
    return YES;
}

// ****************************************************************************
// App switching methods to support Facebook Single Sign-On.
// ****************************************************************************
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [PFFacebookUtils handleOpenURL:url];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [FBSession.activeSession close];
    CC_DIRECTOR_END();
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}



@end
