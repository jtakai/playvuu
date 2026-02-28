//
//  ChooseMovieViewController.m
//  PlayvuuSampleApp
//
//  Created by Brian Smith on 8/28/13.
//  Copyright (c) 2013 Playvuu, Inc. All rights reserved.
//

#import "ChooseMovieViewController.h"
#import "MovieViewController.h"

@interface ChooseMovieViewController ()
{
    NSString * _path;
    NSArray * _files;
}

@end

@implementation ChooseMovieViewController

- (id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _path = [[paths objectAtIndex:0] copy];

        _files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:_path error:nil];

    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    NSString * file = [_files objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [file lastPathComponent];
    
    NSDictionary * attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[_path stringByAppendingPathComponent:file] error:nil];
    NSDate * date = [attributes objectForKey:NSFileCreationDate];

    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    cell.detailTextLabel.text = [formatter stringFromDate:date];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_files count];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#if 1
    NSURL * url = [NSURL fileURLWithPath:[_path stringByAppendingPathComponent:[_files objectAtIndex:indexPath.row]]];
#else
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"playvuu399463625.399853.mov" withExtension:nil];
#endif
    
    MovieViewController * vc = [[MovieViewController alloc] initWithNibName:@"MovieView" bundle:nil];
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
