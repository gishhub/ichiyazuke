//
//  LoginTableViewController.m
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/07/07.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import "LoginTableViewController.h"
#import "SettingTableViewController.h"

@interface LoginTableViewController ()

@end

@implementation LoginTableViewController

@synthesize username = _username;
@synthesize password = _password;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];

    // 戻るボタン隠す
    self.navigationItem.hidesBackButton = YES;

    self.title = @"サインイン";
    //self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginBtn.frame = CGRectMake(30, 120, 260, 35);
    [loginBtn setTitle:@"ログイン" forState:UIControlStateNormal];
    [loginBtn addTarget:self
                 action:@selector(selectedLoginBtn:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *signUpBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signUpBtn.frame = CGRectMake(30, 160, 260, 35);
    [signUpBtn setTitle:@"新規登録" forState:UIControlStateNormal];
    [signUpBtn addTarget:self
                  action:@selector(selectedSignUpBtn:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpBtn];
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
    return 2;
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
        if (indexPath.row == 0) {
            self.username = [[UITextField alloc] initWithFrame:CGRectMake(100.0, 14.0, 200.0, 50.0)];
            self.username.returnKeyType = UIReturnKeyDone;
            self.username.placeholder = @"UserID or Email";
            self.username.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
            [cell addSubview:self.username];
            cell.textLabel.text = @"ユーザ名";
            cell.textLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
            if ([self.username resignFirstResponder]) {
                [self.username becomeFirstResponder];
            }
        } else if (indexPath.row == 1) {
            self.password = [[UITextField alloc] initWithFrame:CGRectMake(100.0, 14.0, 200.0, 50.0)];
            self.password.returnKeyType = UIReturnKeyDone;
            self.password.placeholder = @"Password";
            self.password.secureTextEntry = YES;
            self.password.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
            [cell addSubview:self.password];
            cell.textLabel.text = @"パスワード";
            cell.textLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        }
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)selectedLoginBtn:(id)sender
{
    // NSUserDefaultsに値を保存
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"login"];  // ログイン
    [defaults synchronize];

    //設定画面へGO
    SettingTableViewController *settingTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"settingTableViewController"];
    [self.navigationController pushViewController:settingTableViewController animated:YES];
}

- (void)selectedSignUpBtn:(id)sender
{
    // NSUserDefaultsに値を保存
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"login"];  // ログイン
    [defaults synchronize];
    
    //設定画面へGO
    SettingTableViewController *settingTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"settingTableViewController"];
    [self.navigationController pushViewController:settingTableViewController animated:YES];
}

@end
