//
//  PVSocializerGridViewController.m
//  playvuu
//
//  Created by Pablo Vasquez on 9/17/13.
//  Copyright (c) 2013 Playvuu Inc. All rights reserved.
//

#import "PVVideoGridViewController.h"
#import "PVGridCell.h"
#import "PVProject.h"

@interface PVVideoGridViewController (){
}

@property (strong, nonatomic) NSArray *projects;

@end

@implementation PVVideoGridViewController

- (void) viewSetup {
    UICollectionViewFlowLayout *layOut  = (UICollectionViewFlowLayout*) self.collectionView.collectionViewLayout;
    ASSERT_CLASS(layOut, UICollectionViewFlowLayout);
    
    switch(self.gridType){
        case GridForComposer:
            layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            self.collectionView.allowsMultipleSelection = YES;
            self.collectionView.allowsSelection = YES;
            self.collectionView.collectionViewLayout = layOut;
            break;
            
        case GridForProfile:
            layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
            layOut.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
            self.collectionView.backgroundColor = [UIColor colorWithR:241 G:241 B:241 A:255];
            
        default:
            break;
    }
    
    // Register the xib file for use with this collectionview
    UINib *nib = [UINib nibWithNibName:@"PVGridCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"PVGridCell"];
}

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self reloadData];
    }
    return self;
}

- (id) initWithItemSize:(CGSize)itemSize type:(PVGridType)type{
    self.gridType = type;
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.itemSize = itemSize;
    
    self = [super initWithCollectionViewLayout:layOut];
    if (self) {
        [self reloadData];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self viewSetup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.projects count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PVGridCell";
    
    PVGridCell *cell = (PVGridCell *)[collView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadFirstNibNamedWithNoOwner:[PVGridCell class]];
        ASSERT(cell != nil);
    }
    
    PVProject *project = (PVProject *)[self.projects objectAtIndex:indexPath.item];
    ASSERT_CLASS(project, PVProject);
    
    [cell setupWithProject:project infoKey:@"authorName"];
    cell.backgroundColor = self.collectionView.backgroundColor;
    
    return cell;
}

- (void)reloadData{
    
    PFQuery *query = [PFQuery queryWithClassName:[PVProject parseClassName] predicate:nil];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if(!error){
            self.projects = objects;
            [self.collectionView reloadData];
        }else
            NSLog(@"Could not fetch objects for %@", query);
    }];
}


@end
