//
//  SettingTableViewController.m
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/05/19.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import "SettingTableViewController.h"
#import "GradeTableViewController.h"
#import "CategoryTableViewController.h"
#import "LevelTableViewController.h"


@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

@synthesize selectedGrade;
@synthesize selectedCategory;
@synthesize selectedLevel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (void) reloadTable
{
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch(section) {
        case 0:
            return @"";
            break;
        case 1:
            return @"設定";
            break;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0) {
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            cell.textLabel.text = @"ログインはこちら";
        }
    } else {
        if(indexPath.row == 0) {
            cell.textLabel.text = @"学年";
            cell.detailTextLabel.text = self.selectedGrade;
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"カテゴリ";
            cell.detailTextLabel.text = self.selectedCategory;
        }else if(indexPath.row == 2){
            cell.textLabel.text = @"難易度";
            cell.detailTextLabel.text = self.selectedLevel;
        }
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger myValue = 0;
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ログイン"
                                                            message:nil
                                                           delegate:nil
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"OK",nil];
            alert.delegate = self;
            alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            [alert show];
        }
    } else {
        if(indexPath.row == 0) {
            GradeTableViewController *gradeTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"gradeTableView"];
            gradeTableViewController.title = @"学年";
            [self.navigationController pushViewController:gradeTableViewController animated:YES];
        } else if(indexPath.row == 1) {
            CategoryTableViewController *categoryTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"categoryTableView"];
            categoryTableViewController.title = @"カテゴリ";
            [self.navigationController pushViewController:categoryTableViewController animated:YES];
        } else {
            LevelTableViewController *levelTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"levelTableView"];
            levelTableViewController.title = @"難易度";
            [self.navigationController pushViewController:levelTableViewController animated:YES];
        }
    }
    NSLog(@"myValue:%d",myValue);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UITextField *loginNameField = [alertView textFieldAtIndex:0];
        UITextField *passField = [alertView textFieldAtIndex:1];
        NSString *login = loginNameField.text;
        NSString *pass = passField.text;
        NSLog(@"id: %@",login);
        NSLog(@"password: %@",pass);
    }
}

@end
