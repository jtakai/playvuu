//
//  PVProject.h
//  playvuu
//
//  Created by Pablo Vasquez on 8/29/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#if !defined(_PVPROJECT_H)
#define _PVPROJECT_H

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>

@interface PVProject : PFObject <PFSubclassing>

@property (retain) NSString *title;        // Project's title
@property (retain) NSString *keywords;     // a string with all keywords for project search.
@property (retain) PFFile *slideTexture;   // Texture with slideshow data.
@property (retain) PFFile *thumbVideo;     // Probably not necessary.
@property (retain) PFFile *fullVideo;      // Full video file for playing.
@property (retain) NSDictionary *layerData;// Just a draft.
@property (retain) NSDictionary *activity; // For comments? We should probably make it a PFObject itself.
@property (retain) NSString *authorName;       // The author's PVUser objectId
@property (retain) NSString *authorId;         // ObjectId for the author's PVUser object
@property (retain) NSString *localVideoURL;    // Local URL for the video file

//what about masterVideo? Just share?
//facebookLink/twitterLink ?

-(void)setSlideShow:(UIImage *)slideShow;
+(PVProject *)newProjectWithTitle:(NSString *)title;

@end

#endif //_PVPROJECT_H
