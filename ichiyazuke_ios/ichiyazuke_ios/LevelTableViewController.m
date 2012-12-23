//
//  LevelTableViewController.m
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/05/26.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import "SettingTableViewController.h"
#import "LevelTableViewController.h"

@interface LevelTableViewController ()

@end

@implementation LevelTableViewController

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

// ios5.1用の記述
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

// ios6.0用の記述
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
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
    return 3;
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
            cell.textLabel.text = @"レベル１";
        }else if(indexPath.row == 1) {
            cell.textLabel.text = @"レベル２";
        }else {
            cell.textLabel.text = @"レベル３";
        }
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // デフォルトでは選択されたrowはずっとハイライトされるけど、スッとそのハイライトが消えるようにする
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
            settingTableViewController.level = @"レベル１";
        }else if(indexPath.row == 1) {
            settingTableViewController.level = @"レベル２";
        }else {
            settingTableViewController.level = @"レベル３";
        }
        //settingTableViewControllerの再描画
        [settingTableViewController reloadTable];

        // 前画面に戻る
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
