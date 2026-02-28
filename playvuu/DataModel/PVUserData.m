//
//  PVUserData.m
//  playvuu
//
//  Created by Pablo Vasquez on 8/13/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVUserData.h"
#import "TestFlight.h"
#define NSLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@implementation PVUserData

@dynamic location, firstName, lastName, email, gender, userName, profilePicture;
@dynamic marital, birthday, displayName,canonical;

+(void) load{
    [PVUserData registerSubclass];
    [super load];
}


+ (NSString *)parseClassName {
    return @"PVUserData";
}

-(void)updateNames{
    self.displayName = [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName ];
    self.canonical = [self.displayName lowercaseString];
}

// Returns a copy of the current PVUserdata.
// Used for saving data in AccountInfoViewController
- (PVUserData *)copy{
    
    PVUserData *copyObject = [PVUserData object];
    if(copyObject){
        copyObject.location = self.location;
        copyObject.firstName = self.firstName;
        copyObject.lastName = self.lastName;
        copyObject.displayName = self.displayName;
        copyObject.email = self.email;
        copyObject.gender = self.gender;
        copyObject.userName = self.userName;
        copyObject.marital = self.marital;
        copyObject.birthday = self.birthday;
        copyObject.profilePicture = self.profilePicture;
    }
    
    return copyObject;
}

+ (void)saveWithFacebookUser:(PVUser *)user{
    PVUserData *retObject = [PVUserData object];
    
    // Send request to Facebook
    if(retObject){
        FBRequest *request = [FBRequest requestForMe];
        [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            // handle response
            if (!error) {
                NSLog(@"Enumerating keys");
                NSDictionary *fbData = (NSDictionary *)result;
                for (NSString *key in fbData){
                    NSLog(@"%@", key);
                }
                /*
                
                NSString * picURL = fbData[@"picture_url"];
                if (picURL) {
                    NSURL *pictureURL = [NSURL URLWithString: picURL];
                    
                    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:pictureURL
                                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                          timeoutInterval:2.0f];
                    // Run network request asynchronously
                    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
*/
                retObject.location = fbData[@"location"][@"name"];
                retObject.gender = fbData[@"gender"];
                retObject.birthday = fbData[@"birthday"];
                retObject.email = fbData[@"email"];
                retObject.marital = fbData[@"relationship_status"];
                retObject.firstName = fbData[@"first_name"];
                retObject.lastName = fbData[@"last_name"];
                [retObject updateNames];
                retObject.displayName = fbData[@"name"];
                user.userData = retObject;
                [user saveInBackground];
                
            } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                        isEqualToString: @"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
                NSLog(@"The facebook session was invalidated");
            } else {
                NSLog(@"Some other error: %@", error);
            }
        }];
    }
}

@end
