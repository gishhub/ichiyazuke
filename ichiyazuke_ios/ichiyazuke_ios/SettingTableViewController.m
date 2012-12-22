//
//  SettingTableViewController.m
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/05/19.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import "SettingTableViewController.h"
#import "LoginTableViewController.h"
#import "GradeTableViewController.h"
#import "CategoryTableViewController.h"
#import "LevelTableViewController.h"
#import "PanelViewController.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

@synthesize grade;
@synthesize category;
@synthesize level;

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
    [self configureView];
}

- (void)configureView
{
    //NSUserDefaultsに保存された値を読み込み
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    grade    = [defaults stringForKey:@"selectedGrade"];
    category = [defaults stringForKey:@"selectedCategory"];
    level    = [defaults stringForKey:@"selectedLevel"];
    
    //ひとつ前のViewControllerを取得するために配列を使う
    NSArray *naviArray = [self.navigationController viewControllers];
    NSInteger nowIndex = [naviArray count];
    
    //ひとつ前の画面がログイン画面の場合
    if ([[naviArray objectAtIndex:nowIndex-2] isMemberOfClass:[LoginTableViewController class]]){
        
        //戻るボタンを隠す
        self.navigationItem.hidesBackButton = YES;
        
        //問題へボタン設置
        UIBarButtonItem *updateBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"問題へ", @"")
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(goPanel)];
        self.navigationItem.rightBarButtonItem = updateBtn;
    } else {
        //更新ボタン設置
        UIBarButtonItem *updateBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"更新", @"")
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(goPanel)];
        self.navigationItem.rightBarButtonItem = updateBtn;
    }
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
- (void)reloadTable
{
    //学年とカテゴリの不整合があれば修正
    if ([self.grade isEqualToString:@"高校１年生"]) {
        if (self.category != @"方程式と不等式" && self.category != @"二次関数" && self.category != @"三角比" && self.category != @"集合・命題・証明" &&self.category != @"場合の数・確率"){
            self.category = @"方程式と不等式";
        }
    } else if ([self.grade isEqualToString:@"高校２年生"]) {
        if (self.category != @"式と証明" && self.category != @"三角関数" && self.category != @"指数・対数関数" && self.category != @"微分と積分" &&self.category != @"数列" &&self.category != @"ベクトル"){
            self.category = @"式と証明";
        }
    } else if ([self.grade isEqualToString:@"高校３年生"]) {
        if (self.category != @"極限" && self.category != @"微分法と積分法" && self.category != @"行列"){
            self.category = @"極限";
        }
    }
    //TableViewを再表示
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
            return NSLocalizedString(@"設定", @"");
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

            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

            // ログインしているかどうか
            if ([defaults boolForKey:@"login"] == YES){
                cell.textLabel.text = NSLocalizedString(@"ログアウト", @"");
            } else {
                cell.textLabel.text = NSLocalizedString(@"ログインはこちら", @"");
            }
        }
    } else {
        if(indexPath.row == 0) {
            cell.textLabel.text = NSLocalizedString(@"学年", @"");
            cell.detailTextLabel.text = self.grade;
        }else if(indexPath.row == 1){
            cell.textLabel.text = NSLocalizedString(@"カテゴリ", @"");
            cell.detailTextLabel.text = self.category;
        }else if(indexPath.row == 2){
            cell.textLabel.text = NSLocalizedString(@"難易度", @"");
            cell.detailTextLabel.text = self.level;
        }
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {

            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

            // ログインしているかどうか
            if ([defaults boolForKey:@"login"] == YES){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ログアウトしますか？", @"")
                                                                message:nil
                                                               delegate:nil
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"OK",nil];
                alert.delegate = self;
                [alert show];
            } else {
                [self goLogin];
            }
        }
    } else {
        if(indexPath.row == 0) {
            GradeTableViewController *gradeTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"gradeTableViewController"];
            gradeTableViewController.title = NSLocalizedString(@"学年", @"");
            [self.navigationController pushViewController:gradeTableViewController animated:YES];
        } else if(indexPath.row == 1) {
            CategoryTableViewController *categoryTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"categoryTableViewController"];
            categoryTableViewController.title = NSLocalizedString(@"カテゴリ", @"");
            [self.navigationController pushViewController:categoryTableViewController animated:YES];
        } else {
            LevelTableViewController *levelTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"levelTableViewController"];
            levelTableViewController.title = NSLocalizedString(@"難易度", @"");
            [self.navigationController pushViewController:levelTableViewController animated:YES];
        }
    }
}

- (void)goLogin
{
    LoginTableViewController *loginTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginTableViewController"];
    [self.navigationController pushViewController:loginTableViewController animated:YES];
}

- (void)goPanel
{
    //NSUserDefaultsに値を保存
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:grade    forKey:@"selectedGrade"];
    [defaults setObject:category forKey:@"selectedCategory"];
    [defaults setObject:level    forKey:@"selectedLevel"];
    [defaults synchronize];
    
    //パネル画面へGO
    PanelViewController *panelViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"panelViewController"];
    [self.navigationController pushViewController:panelViewController animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //NSUserDefaultsに値を保存
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:@"login"];  // ログアウト
        [defaults synchronize];

        //ログイン画面へGO
        [self goLogin];
    }
}

@end
