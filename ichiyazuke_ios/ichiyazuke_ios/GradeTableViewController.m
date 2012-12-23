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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if(indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"高校１年生";
                break;
            case 1:
                cell.textLabel.text = @"高校２年生";
                break;
            case 2:
                cell.textLabel.text = @"高校３年生";
                break;
            default:
                break;
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
        switch (indexPath.row) {
            case 0:
                settingTableViewController.grade = @"高校１年生";
                break;
            case 1:
                settingTableViewController.grade = @"高校２年生";
                break;
            case 2:
                settingTableViewController.grade = @"高校３年生";
                break;
            default:
                break;
        }
        //settingTableViewControllerの再描画
        [settingTableViewController reloadTable];

        // 前画面に戻る
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
