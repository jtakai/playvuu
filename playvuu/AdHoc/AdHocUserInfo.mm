//
//  AdHocUserInfo.m
//  playvuu
//
//  Created by Pablo Vasquez on 8/12/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "AdHocUserInfo.h"
#import "Parse/Parse.h"
#import "PVUser.h"

@implementation AdHocUserInfo

static const NSString *username = @"username";
static const NSString *password = @"password";
static const NSString *adHocPass = @"nolase";
static const NSString *name = @"name";
static const NSString *lastName = @"last_name";
static const NSString *gender = @"gender";
static const NSString *email = @"email";
static const NSString *picture = @"picture";
static const NSString *location = @"location";
static const NSString *status = @"status";



static NSArray * adHocUsers = @[@{
                                    username : @"chiquita",
                                    password : adHocPass,
                                    name : @"Mirtha",
                                    lastName : @"Legrand",
                                    gender :  @"female",
                                    email : @"chiquita@el9.com.ar",
                                    picture : @"fem1.png",
                                    location: @"Buenos Aires",
                                    status: @"Let's have lunch!",
                                    },
                                @{
                                    username : @"sbergman",
                                    password : adHocPass,
                                    name : @"Sergio",
                                    lastName : @"Bergman",
                                    gender :  @"male",
                                    email : @"rabino@pro.com.ar",
                                    picture : @"male1.png",
                                    location: @"Tel Aviv",
                                    status: @"I'm meyer's disciple",
                                    },
                                @{
                                    username : @"ajapkin",
                                    password : adHocPass,
                                    name : @"Alejandro",
                                    lastName : @"Japkin",
                                    gender :  @"male",
                                    email : @"ajapkin@nina-corp.com",
                                    picture : @"male2.png",
                                    location: @"Moscow",
                                    status: @"Jack Obson :P",
                                    },
                                @{
                                    username : @"gaby",
                                    password : adHocPass,
                                    name : @"Gabriela",
                                    lastName : @"Michetti",
                                    gender :  @"female",
                                    email : @"nocamino@pro.com",
                                    picture : @"fem2.png",
                                    location: @"Madrid",
                                    status: @"It's gonna be good!",
                                    },
                                @{
                                    username : @"hrlarreta",
                                    password : adHocPass,
                                    name : @"Horacio",
                                    lastName : @"Rodriguez Larreta",
                                    gender :  @"male",
                                    email : @"pelado@pro.com",
                                    picture : @"male3.png",
                                    location: @"Los Angeles",
                                    status: @"Baldie head",
                                    },
                                @{
                                    username : @"hmoyano",
                                    password : adHocPass,
                                    name : @"Hugo",
                                    lastName : @"Moyano",
                                    gender :  @"male",
                                    email : @"hugo@cgt.org",
                                    picture : @"male4.png",
                                    location: @"London",
                                    status: @"I want Carlos back",
                                    },
                                @{
                                    username : @"smassa",
                                    password : adHocPass,
                                    name : @"Sergio",
                                    lastName : @"Massa",
                                    gender :  @"male",
                                    email : @"smassa@fr.org",
                                    picture : @"male5.png",
                                    location: @"Cordoba",
                                    status: @"Yessa!",
                                    },
                                @{
                                    username : @"jdevido",
                                    password : adHocPass,
                                    name : @"Julio",
                                    lastName : @"De Vido",
                                    gender :  @"male",
                                    email : @"jdevido@fpv.org",
                                    picture : @"male6.png",
                                    location: @"Johannesburg",
                                    status: @"Batman sucks",
                                    },
                                @{
                                    username : @"frandazzo",
                                    password : adHocPass,
                                    name : @"Florencio",
                                    lastName : @"Randazzo",
                                    gender :  @"male",
                                    email : @"frandazzo@fpv.org",
                                    picture : @"male7.png",
                                    location: @"Maputo",
                                    status: @"Don't use the train today",
                                    },
                                @{
                                    username : @"bcarambula",
                                    password : adHocPass,
                                    name : @"Berugo",
                                    lastName : @"Carambula",
                                    gender :  @"male",
                                    email : @"bcarambula@el9.com",
                                    picture : @"male8.png",
                                    location: @"Kabul",
                                    status: @"Clink!",
                                    },
                                @{
                                    username : @"vhmorales",
                                    password : adHocPass,
                                    name : @"Victor Hugo",
                                    lastName : @"Morales",
                                    gender :  @"male",
                                    email : @"vh@fpv.org",
                                    picture : @"male9.png",
                                    location: @"Caseros",
                                    status: @"Goooooooal!",
                                    },
                                @{
                                    username : @"vdonda",
                                    password : adHocPass,
                                    name : @"Vicky",
                                    lastName : @"Donda",
                                    gender :  @"female",
                                    email : @"vdonda@org.ar",
                                    picture : @"fem3.png",
                                    location: @"Sao Paulo",
                                    status: @"Where's my mother?",
                                    },
                                @{
                                    username : @"mstolbizer",
                                    password : adHocPass,
                                    name : @"Margarita",
                                    lastName : @"Stolbizer",
                                    gender :  @"female",
                                    email : @"stolbi@unen.org",
                                    picture : @"fem4.png",
                                    location: @"Montevideo",
                                    status: @"Pulling myself",
                                    },
                                @{
                                    username : @"mnannis",
                                    password : adHocPass,
                                    name : @"Mariana",
                                    lastName : @"Nannis",
                                    gender :  @"female",
                                    email : @"mnannis@cualquiera.org",
                                    picture : @"fem5.png",
                                    location: @"Dallas",
                                    status: @"Pure glamour today!",
                                    },
                                @{
                                    username : @"kmazocco",
                                    password : adHocPass,
                                    name : @"Karina",
                                    lastName : @"Mazocco",
                                    gender :  @"female",
                                    email : @"kmazocco@venus.com",
                                    picture : @"fem6.png",
                                    location: @"Bagdad",
                                    status: @"Hmmmmm"
                                    },
                                ];

+(void)addPics{
    for(NSDictionary *userInfo in adHocUsers){
        PVUser *user = [PVUser logInWithUsername:[userInfo objectForKey:username] password:[userInfo objectForKey:password]];
        PVUserData *userData = user.userData;
        
        UIImage *image = [UIImage imageNamed:[userInfo objectForKey:picture]];
        NSData *imageData =  UIImagePNGRepresentation(image);
        PFFile *pictureFile = [PFFile fileWithName:[userInfo objectForKey:picture] data: imageData];
        [pictureFile save];
        userData.profilePicture = pictureFile;
        [user save];
        [PVUser logOut];
    }
}

+(void)addUsers{
    
    for(NSDictionary *userInfo in adHocUsers){

        PVUser *user = [PVUser object];
        PVUserData *userData = [PVUserData object];
        user.userData = userData;
        
        // We set all the data into the PVUser
        [user setEmailFields:[userInfo objectForKey:email]];
        user.password = [userInfo objectForKey:password];
        user.status = [userInfo objectForKey:status];
        userData.firstName = [userInfo objectForKey:name];
        userData.lastName = [userInfo objectForKey:lastName];
        [userData updateNames];
        userData.gender = [userInfo objectForKey:gender];
        userData.location = [userInfo objectForKey:location];
        
        UIImage *image = [UIImage imageNamed:[userInfo objectForKey:picture]];
        NSData *imageData =  UIImagePNGRepresentation(image);
        PFFile *pictureFile = [PFFile fileWithName:[userInfo objectForKey:picture] data: imageData];
        [pictureFile save];
        
        userData.profilePicture = pictureFile;

        [user signUp];
    }
    
}

@end
