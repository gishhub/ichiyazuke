//
//  CategoryTableViewController.m
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/05/26.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import "SettingTableViewController.h"
#import "CategoryTableViewController.h"

@interface CategoryTableViewController ()

@end

@implementation CategoryTableViewController

@synthesize grade;

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
    //ひとつ前のViewControllerを取得するために配列を使う
    NSArray *naviArray = [self.navigationController viewControllers];
    NSInteger nowIndex = [naviArray count];
    SettingTableViewController *settingTableViewController = (SettingTableViewController *)[naviArray objectAtIndex:nowIndex-2];
    
    self.grade = settingTableViewController.grade;
    
    NSLog(@"%@", self.grade);
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
    NSLog(@"%@", self.grade);
    if ([self.grade isEqualToString:@"高校１年生"]) {
        NSLog(@"%@", @"CategoryTableViewController:高校１年生です");
        return 5;
    } else if ([self.grade isEqualToString:@"高校２年生"]) {
        NSLog(@"%@", @"CategoryTableViewController:高校２年生です");
        return 6;
    } else if ([self.grade isEqualToString:@"高校３年生"]) {
        return 3;
    } else {
        return 6;
    }
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
        if ([self.grade isEqualToString:@"高校１年生"]) {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"方程式と不等式";
                    break;
                    
                case 1:
                    cell.textLabel.text = @"二次関数";
                    break;
                    
                case 2:
                    cell.textLabel.text = @"三角比";
                    break;
                    
                case 3:
                    cell.textLabel.text = @"集合・命題・証明";
                    break;
                    
                case 4:
                    cell.textLabel.text = @"場合の数・確率";
                    break;
                    
                default:
                    NSLog(@"%@", @"CategoryTableViewController:設定してない列です");

            }
        } else if ([self.grade isEqualToString:@"高校２年生"]) {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"式と証明";
                    break;
                    
                case 1:
                    cell.textLabel.text = @"三角関数";
                    break;
                    
                case 2:
                    cell.textLabel.text = @"指数・対数関数";
                    break;
                    
                case 3:
                    cell.textLabel.text = @"微分と積分";
                    break;
                    
                case 4:
                    cell.textLabel.text = @"数列";
                    break;
                    
                case 5:
                    cell.textLabel.text = @"ベクトル";
                    break;

                default:
                    NSLog(@"%@", @"CategoryTableViewController:設定してない列です");
            }
        } else if ([self.grade isEqualToString:@"高校３年生"]) {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"極限";
                    break;
                    
                case 1:
                    cell.textLabel.text = @"微分法と積分法";
                    break;
                    
                case 2:
                    cell.textLabel.text = @"行列";
                    break;
                    
                default:
                    NSLog(@"%@", @"CategoryTableViewController:設定してない列です");
            }
        } else {
            NSLog(@"%@", @"CategoryTableViewController:設定してない列です");
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
        
        if ([self.grade isEqualToString:@"高校１年生"]) {
            switch (indexPath.row) {
                case 0:
                    settingTableViewController.category = @"方程式と不等式";
                    break;
                    
                case 1:
                    settingTableViewController.category = @"二次関数";
                    break;
                    
                case 2:
                    settingTableViewController.category = @"三角比";
                    break;
                    
                case 3:
                    settingTableViewController.category = @"集合・命題・証明";
                    break;
                    
                case 4:
                    settingTableViewController.category = @"場合の数・確率";
                    break;
                    
                default:
                    NSLog(@"%@", @"CategoryTableViewController:設定してない列です");
            }
        } else if ([self.grade isEqualToString:@"高校２年生"]) {
            switch (indexPath.row) {
                case 0:
                    settingTableViewController.category = @"式と証明";
                    break;
                    
                case 1:
                    settingTableViewController.category = @"三角関数";
                    break;
                    
                case 2:
                    settingTableViewController.category = @"指数・対数関数";
                    break;
                    
                case 3:
                    settingTableViewController.category = @"微分と積分";
                    break;
                    
                case 4:
                    settingTableViewController.category = @"数列";
                    break;
                    
                case 5:
                    settingTableViewController.category = @"ベクトル";
                    break;

                default:
                    NSLog(@"%@", @"CategoryTableViewController:設定してない列です");
            }
        } else if ([self.grade isEqualToString:@"高校３年生"]) {
            switch (indexPath.row) {
                case 0:
                    settingTableViewController.category = @"極限";
                    break;
                    
                case 1:
                    settingTableViewController.category = @"微分法と積分法";
                    break;
                    
                case 2:
                    settingTableViewController.category = @"行列";
                    break;

                default:
                    NSLog(@"%@", @"CategoryTableViewController:設定してない列です");
            }
        }

        //settingTableViewControllerの再描画
        [settingTableViewController reloadTable];
        
        // 前画面に戻る
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
