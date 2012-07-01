//
//  GradeTableViewController.m
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/05/26.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import "SettingTableViewController.h"
#import "GradeTableViewController.h"

@interface GradeTableViewController ()

@end

@implementation GradeTableViewController

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            cell.textLabel.text = @"中学１年生";
        }else if(indexPath.row == 1) {
            cell.textLabel.text = @"中学２年生";
        }else if(indexPath.row == 2){
            cell.textLabel.text = @"中学３年生";
        }else if(indexPath.row == 3){
            cell.textLabel.text = @"高校１年生";
        }else if(indexPath.row == 4){
            cell.textLabel.text = @"高校２年生";
        }else {
            cell.textLabel.text = @"高校３年生";
        }
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *logger = @"";

    // デフォルトでは選択されたrowはずっとハイライトされるけど、スッとそのハイライトが消えるようにする
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];

    //選択されたcellを取得
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //チェックマークをつけたりはずしたりする
	if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}else {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
    
    //ひとつ前のViewControllerを取得するために配列を使う
    NSArray *naviArray = [self.navigationController viewControllers];
    NSInteger nowIndex = [naviArray count];
    SettingTableViewController *settingTableViewController = (SettingTableViewController *)[naviArray objectAtIndex:nowIndex-2];

    // そのsectionのそのrowが選択されたら
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            settingTableViewController.grade = @"中学1年生";
        } else if(indexPath.row == 1) {
            settingTableViewController.grade = @"中学2年生";
        } else if(indexPath.row == 2) {
            settingTableViewController.grade = @"中学3年生";
        } else if(indexPath.row == 3) {
            settingTableViewController.grade = @"高校1年生";
        } else if(indexPath.row == 4) {
            settingTableViewController.grade = @"高校2年生";
        } else if(indexPath.row == 5) {
            settingTableViewController.grade = @"高校3年生";
        } else {
            logger = @"GradeTableViewController:設定してない列です";
            NSLog(@"%@", logger);
        }
        //settingTableViewControllerの再描画
        [settingTableViewController reloadTable];

        // 前画面に戻る
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
