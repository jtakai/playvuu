//
//  ProfileInfoViewController.m
//  playvuu
//
//  Created by XCodeClub on 8/13/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "AccountInfoViewController.h"
#import <FacebookSDK/FBRequest.h>
#import <QuartzCore/QuartzCore.h>
#import "PVTableConstants.h"
#import "AccountInfoYourNameCell.h"
#import "AccountInfoDatePickerViewController.h"
#import "AccountInfoDataPickerViewController.h"

NSString* const kDisplayName        = @"diplayName";

NSString* const kFirstName          = @"firstName";
NSString* const kLastName           = @"lastName";
NSString* const kLoginName          = @"loginName";
NSString* const kEmail              = @"email";

NSString* const kGender             = @"gender";
NSString* const kAgeRange           = @"ageRange";
NSString* const kBirthday           = @"birthday";
NSString* const kRelationship       = @"relationship";

NSString* const kProfilePicture     = @"profilePicture";
NSString* const kLocale             = @"locale";
NSString* const kLocation           = @"location";
NSString* const kLanguage           = @"language";

NSString* const kTimezone           = @"timezone";
NSString* const kCurrency           = @"currency";


@interface AccountInfoViewController (){
    PVUserData * userData;
}
@property (nonatomic, retain) NSMutableDictionary * dataValues;
@property (nonatomic, assign) CGRect tableViewOriginalRect;
@property (nonatomic, weak) AccountInfoCell * currentCell;
-(IBAction)dismissKeyboard:(id)sender;
@end

@implementation AccountInfoViewController

@synthesize tableView;
@synthesize dataValues;
@synthesize tableViewOriginalRect;
@synthesize currentCell;

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableViewOriginalRect = tableView.frame;
    userData = [self.delegate getData];
    [self updateView];
}

// Set received values if they are not nil and reload the table
- (void)updateView
{
    self.dataValues = [NSMutableDictionary dictionary];
    
    [self setAtDataObject:userData.firstName forKey:kFirstName orNullValue:@""];
    [self setAtDataObject:userData.lastName forKey:kLastName orNullValue:@""];
    [self setAtDataObject:userData.userName forKey:kLoginName orNullValue:@""];
    [self setAtDataObject:userData.email forKey:kEmail orNullValue:@""];
    
    [self setAtDataObject:userData.gender forKey:kGender orNullValue:@""];
    [self setAtDataObject:@"" forKey:kAgeRange orNullValue:@""];            // TODO
    [self setAtDataObject:userData.birthday forKey:kBirthday orNullValue:[NSDate date]];
    [self setAtDataObject:userData.marital forKey:kRelationship orNullValue:@""];
    [self setAtDataObject:userData.profilePicture forKey:kProfilePicture orNullValue:[NSNull null]];
    [self setAtDataObject:@"" forKey:kLocale orNullValue:@""];  // TODO
    [self setAtDataObject:userData.location forKey:kLocation orNullValue:@""];
    [self setAtDataObject:@"" forKey:kLanguage orNullValue:@""];    // TODO

    [self setAtDataObject:@"" forKey:kTimezone orNullValue:@""];  // TODO
    [self setAtDataObject:@"" forKey:kCurrency orNullValue:@""];  // TODO

    [self dataUpdated];
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(UseKeyboardWillAppear:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(UseKeyboardWillDissappear:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}

-(void) UseKeyboardWillAppear:(NSNotification*) notification
{
    NSDictionary *info = [notification userInfo];    
    CGRect keyboardFrameEnd = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

    CGRect frame = self.tableViewOriginalRect;
    frame.size.height -= keyboardFrameEnd.size.height;
    [self.tableView setFrame:frame];
    
    [self centerCurrentCell];
}

-(void)centerCurrentCell
{
    if (self.currentCell)
    {
        NSIndexPath* newCellIndexPath = [NSIndexPath indexPathForRow:self.currentCell.row
                                                           inSection:0];
        [self.tableView selectRowAtIndexPath:newCellIndexPath
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionTop];
    }
}

-(void) UseKeyboardWillDissappear:(NSNotification*) notification
{
    [self.tableView setFrame:self.tableViewOriginalRect];
}

-(IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
    [self.tableView endEditing:YES];
}

-(void)setAtDataObject:(id)object forKey:(NSString*)key orNullValue:(id)nullObject
{
    if (object)
    {
        [self.dataValues setObject:object forKey:key];
    }
    else
    {
        [self.dataValues setObject:nullObject forKey:key];
    }
}

- (IBAction)saveData:(UIBarButtonItem *)sender
{
    for (AccountInfoCell * cell in [self.tableView visibleCells])
    {
        [cell endEditing];
    }
    
    [self save];
}

-(void)save
{
    PFFile *profilePictureFile = [self.dataValues objectForKey:kProfilePicture];
    if (profilePictureFile && (!userData.profilePicture
        || [profilePictureFile.url isEqualToString:userData.profilePicture.url]))
    {
        NSString *imageFileName = [NSString stringWithFormat:@"%@_profile.png", userData.email];
        //Set the correct name for the file and discard the old one.
        PFFile *saveFile = [PFFile fileWithName:imageFileName data:[profilePictureFile getData]];
        [saveFile saveInBackground];
        
        userData.profilePicture = saveFile;
    }
    
    userData.lastName = [self.dataValues objectForKey:kLastName];
    userData.firstName = [self.dataValues objectForKey:kFirstName];
    userData.userName = [self.dataValues objectForKey:kLoginName];
    userData.gender = [self.dataValues objectForKey:kGender];
    userData.displayName = [self.dataValues objectForKey:kDisplayName];
    userData.canonical = [[self.dataValues objectForKey:kDisplayName] lowercaseString];
    userData.birthday = [[self.dataValues objectForKey:kBirthday] description];
    userData.location = [self.dataValues objectForKey:kLocation];
    userData.marital = [self.dataValues objectForKey:kRelationship];

    TRACE(@"locale:%@", [self.dataValues objectForKey:kLocale]);
    TRACE(@"ageRange:%@", [self.dataValues objectForKey:kAgeRange]);
    TRACE(@"language:%@", [self.dataValues objectForKey:kLanguage]);
    //TRACE(@"relationship:%@", [self.dataValues objectForKey:kRelationship]);
    TRACE(@"timezone:%@", [self.dataValues objectForKey:kTimezone]);
    TRACE(@"currency:%@", [self.dataValues objectForKey:kCurrency]);
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate saveData:userData];
    }];
}

- (IBAction)cancelView:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self cells] count];
}

- (AccountInfoCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * cells = [self cells];
    NSDictionary * cellConfig = [cells objectAtIndex:indexPath.row];
    
    NSString * cellId = [cellConfig objectForKey:kCellId];
    NSDictionary * cellMetadata = [cellConfig objectForKey:kCellMetadata];
    
    AccountInfoCell* cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellId
                                              owner:nil
                                            options:nil] lastObject];
    }
    
    cell.row = indexPath.row;
    cell.metadata = cellMetadata;
    cell.data = self.dataValues;
    cell.delegate = self;

    [cell reload];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * cells = [self cells];
    NSDictionary * cellConfig = [cells objectAtIndex:indexPath.row];

    return [[cellConfig objectForKey:kCellHeight] integerValue];
}

#pragma mark - UITableView Helper

NSString* const kCellSeparator        = @"43";

- (NSArray*)cells
{
    static NSArray* _cells;
    
    if(!_cells){
        _cells = @[
                   @{
                       kCellId            : @"AccountInfoYourNameCell",
                       kCellHeight        : @"110",
                       kCellMetadata      : @{
                               kMetadataOutputFieldName           : kDisplayName,
                               kMetadataOutputFieldEmail          : kEmail,
                               kMetadataOutputFieldProfilePicture : kProfilePicture
                               }
                       },
                   @{
                       kCellId            : @"AccountInfoFieldCell",
                       kCellHeight        : kCellSeparator,
                       kCellMetadata      : @{
                               kMetadataFieldTitle : @"Login Name",
                               kMetadataFieldPlaceHolder : @"Login Name",
                               kMetadataOutputField: kLoginName
                               }
                       },
                   @{
                       kCellId            : @"AccountInfoFieldCell",
                       kCellHeight        : kCellSeparator,
                       kCellMetadata      : @{
                               kMetadataFieldTitle : @"First Name",
                               kMetadataFieldPlaceHolder : @"First Name",
                               kMetadataOutputField: kFirstName
                               }
                       },
                   @{
                       kCellId            : @"AccountInfoFieldCell",
                       kCellHeight        : kCellSeparator,
                       kCellMetadata      : @{
                               kMetadataFieldTitle : @"Last Name",
                               kMetadataFieldPlaceHolder : @"Last Name",
                               kMetadataOutputField: kLastName
                               }
                       },
                   @{
                       kCellId            : @"AccountInfoFieldCell",
                       kCellHeight        : kCellSeparator,
                       kCellMetadata      : @{
                               kMetadataFieldTitle : @"Email",
                               kMetadataFieldPlaceHolder : @"Email",
                               kMetadataFieldValidationType : kFieldValidationEmail,
                               kMetadataOutputField: kEmail
                               }
                       },
                   @{
                       kCellId            : @"AccountInfoGenderCell",
                       kCellHeight        : kCellSeparator,
                       kCellMetadata      : @{
                               kMetadataOutputField: kGender
                               }
                       },
                   /*@{
                       kCellId            : @"AccountInfoDataPickerCell",
                       kCellHeight        : kCellSeparator,
                       kCellMetadata      : @{
                               kMetadataFieldTitle : @"Age Range",
                               kMetadataValues: @[ @"0-20", @"21-40", @"41-60", @"61-80", @"81+" ],
                               kMetadataOutputField: kAgeRange,
                               }
                       },*/
                   @{
                       kCellId            : @"AccountInfoDataPickerCell",
                       kCellHeight        : kCellSeparator,
                       kCellMetadata      : @{
                               kMetadataFieldTitle : @"Location",
                               kMetadataValues: @[ @"United States", @"Canada", @"Latin America", @"Europe", @"Asia", @"Other" ],
                               kMetadataOutputField: kLocation,
                               }
                       },
                   /*@{
                       kCellId            : @"AccountInfoDataPickerCell",
                       kCellHeight        : kCellSeparator,
                       kCellMetadata      : @{
                               kMetadataFieldTitle : @"Time Zone",
                               kMetadataValues: @[ @"-12:00", @"-11:00", @"-10:00", @"-9:00", @"-8:00", @"-7:00", @"-6:00", @"-5:00", @"-4:00", @"-3:00", @"-2:00", @"-1:00",
                                                   @"0:00",
                                                   @"+1:00", @"+2:00", @"+3:00", @"+4:00", @"+5:00", @"+6:00", @"+7:00", @"+8:00", @"+9:00", @"+10:00", @"+11:00", @"+12:00"],
                               kMetadataOutputField: kTimezone,
                               }
                       },
                   @{
                       kCellId            : @"AccountInfoDataPickerCell",
                       kCellHeight        : kCellSeparator,
                       kCellMetadata      : @{
                               kMetadataFieldTitle : @"Currency",
                               kMetadataValues: @[ @"$", @"u$s", @"€", @"Other" ],
                               kMetadataOutputField: kCurrency,
                               }
                       },
                   @{
                       kCellId            : @"AccountInfoFieldCell",
                       kCellHeight        : kCellSeparator,
                       kCellMetadata      : @{
                               kMetadataFieldTitle : @"Locale",
                               kMetadataFieldPlaceHolder : @"Locale",
                               kMetadataOutputField: kLocale
                               }
                       },*/
                   @{
                       kCellId            : @"AccountInfoDataPickerCell",
                       kCellHeight        : kCellSeparator,
                       kCellMetadata      : @{
                               kMetadataFieldTitle : @"Language",
                               kMetadataValues: @[ @"English", @"Spanish", @"German", @"French", @"Chinese", @"Japanese", @"Korean", @"Other" ],
                               kMetadataOutputField: kLanguage,
                               }
                       },
                   @{
                       kCellId            : @"AccountInfoDataPickerCell",
                       kCellHeight        : kCellSeparator,
                       kCellMetadata      : @{
                               kMetadataFieldTitle : @"Relationship",
                               kMetadataValues: @[ @"Single", @"Married", @"Dating", @"Divorce", @"Unknown" ],
                               kMetadataOutputField: kRelationship,
                               }
                       },
//                   @{
//                       kCellId            : @"AccountInfoFieldCell",
//                       kCellHeight        : kCellSeparator,
//                       kCellMetadata      : @{
//                               kMetadataFieldTitle : @"TEST",
//                               kMetadataFieldPlaceHolder : @"TEST",
//                               kMetadataOutputField: @"test"
//                               }
//                       },

                   ];
    }
    
    return _cells;
}

#pragma mark - AccountInfoCellParent

-(void)dataUpdated
{
    NSString * displayName = [NSString stringWithFormat:@"%@ %@",
                              [self.dataValues objectForKey:kFirstName],
                              [self.dataValues objectForKey:kLastName]];
    [self.dataValues setObject:displayName forKey:kDisplayName];
    
    [self.tableView reloadData];
}

-(void)cellBeingSelected:(AccountInfoCell*)cell
{
    ASSERT_CLASS(cell, AccountInfoCell);
    self.currentCell = cell;

    [self centerCurrentCell];
}

-(void)presentImagePickerController:(UIImagePickerController*)picker
{
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)presentDatePicketWithDate:(NSDate*)date finishBlock:(PVDatePickerBlock)finishBlock
{
    AccountInfoDatePickerViewController * vc = [[AccountInfoDatePickerViewController alloc] initWithDate:date finishBlock:finishBlock];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)presentDataPicketWithData:(NSString*)data values:(NSArray*)values finishBlock:(PVDataPickerBlock)finishBlock
{
    AccountInfoDataPickerViewController * vc = [[AccountInfoDataPickerViewController alloc] initWithData:data values:values finishBlock:finishBlock];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)goNextCell:(AccountInfoCell*)cell
{
//    NSUInteger nextRow = cell.row + 1;
//    if (nextRow >= [dataValues count])
//    {
//        nextRow = 1;
//    }
//    
//    for (NSIndexPath * index in [self.tableView indexPathsForVisibleRows])
//    {
//        AccountInfoCell * cellNext = (AccountInfoCell*)[self.tableView cellForRowAtIndexPath:index];
//        ASSERT_CLASS(cellNext, AccountInfoCell);
//        
//        if (cellNext.row == nextRow)
//        {
//            [self.tableView selectRowAtIndexPath:index
//                                        animated:YES
//                                  scrollPosition:cellNext.row];
//            break;
//        }
//    }
}

@end

