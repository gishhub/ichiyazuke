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

@synthesize username;
@synthesize password;

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
    // 戻るボタン隠す
    self.navigationItem.hidesBackButton = YES;
    
    self.title = NSLocalizedString(@"サインイン", @"");
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginBtn.frame = CGRectMake(30, 120, 260, 40);
    [loginBtn setTitle:NSLocalizedString(@"ログイン", @"") forState:UIControlStateNormal];
    [loginBtn addTarget:self
                 action:@selector(selectedLoginBtn:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *signUpBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signUpBtn.frame = CGRectMake(30, 170, 260, 40);
    [signUpBtn setTitle:NSLocalizedString(@"新規登録", @"") forState:UIControlStateNormal];
    [signUpBtn addTarget:self
                  action:@selector(selectedSignUpBtn:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpBtn];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if(indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.username = [[UITextField alloc] initWithFrame:CGRectMake(100.0, 14.0, 200.0, 50.0)];
            self.username.placeholder = NSLocalizedString(@"IDまたはメールアドレス", @"");
            self.username.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
            self.username.returnKeyType = UIReturnKeyDone;
            self.username.autocorrectionType = UITextAutocorrectionTypeNo;
            self.username.autocapitalizationType = UITextAutocapitalizationTypeNone;
            [cell addSubview:self.username];
            cell.textLabel.text = NSLocalizedString(@"ユーザ名", @"");
            cell.textLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
            if ([self.username resignFirstResponder]) {
                [self.username becomeFirstResponder];
            }
            [self.username addTarget:self
                              action:nil
                    forControlEvents:UIControlEventEditingDidEndOnExit];
        } else if (indexPath.row == 1) {
            self.password = [[UITextField alloc] initWithFrame:CGRectMake(100.0, 14.0, 200.0, 50.0)];
            self.password.placeholder = NSLocalizedString(@"入力してください", @"");
            self.password.returnKeyType = UIReturnKeyDone;
            self.password.secureTextEntry = YES;
            self.password.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
            self.password.autocorrectionType = UITextAutocorrectionTypeNo;
            self.password.autocapitalizationType = UITextAutocapitalizationTypeNone;
            [cell addSubview:self.password];
            cell.textLabel.text = NSLocalizedString(@"パスワード", @"");
            cell.textLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        }
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // デフォルトでは選択されたrowはずっとハイライトされるけど、スッとそのハイライトが消えるようにする
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	self.username = textField;
	self.password = textField;
    NSLog(@"%@",self.username);
    NSLog(@"%@",self.password);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (void)selectedLoginBtn:(id)sender
{
    if ([self.username.text length] == 0 || [self.password.text  length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ログイン失敗", @"")
                                                        message:NSLocalizedString(@"ユーザ名またはパスワードが空です", @"")
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK",nil];
        alert.delegate = self;
        [alert show];
    } else {
        //ログイン情報をPOSTで送信
        //trueならログイン成功、falseならログイン失敗
        //NSString *url = @"http://49.212.136.103:8080/ichiyazuke_web/login";
        NSString *url = @"http://localhost:8080/ichiyazuke_web/login";

        /* POST */
        NSString *keyValue = [NSString stringWithFormat:@"username=%@&passward=%@", self.username.text, self.password.text];
        NSData *post = [keyValue dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:post];
        
        NSData   *response    = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *loginResult = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        
        if ([loginResult boolValue]){
            // NSUserDefaultsに値を保存
            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:YES forKey:@"login"];  // ログイン
            [defaults synchronize];
            
            //設定画面へGO
            SettingTableViewController *settingTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"settingTableViewController"];
            [self.navigationController pushViewController:settingTableViewController animated:YES];        
        } else {
            //ポップアップする
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ログイン失敗", @"")
                                                            message:NSLocalizedString(@"ユーザ名またはパスワードが間違っています", @"")
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK",nil];
            alert.delegate = self;
            [alert show];
        }
    }
}

- (void)selectedSignUpBtn:(id)sender
{
    if ([self.username.text length] == 0 || [self.password.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"新規登録失敗", @"")
                                                        message:NSLocalizedString(@"ユーザ名またはパスワードが空です", @"")
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK",nil];
        alert.delegate = self;
        [alert show];
    } else {
        //新規登録情報をPOSTで送信
        //trueなら新規登録成功、falseなら新規登録失敗
        NSString *url = @"http://49.212.136.103:8080/ichiyazuke_web/signup";
        //NSString *url = @"http://localhost:8080/ichiyazuke_web/signup";
        
        /* POST */
        NSString *keyValue = [NSString stringWithFormat:@"username=%@&passward=%@", self.username.text, self.password.text];
        NSData *post = [keyValue dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:post];

        NSData   *response     = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *signupResult = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];

        if ([signupResult boolValue]) {
            // NSUserDefaultsに値を保存
            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:YES forKey:@"login"];  // ログイン
            [defaults synchronize];

            //設定画面へGO
            SettingTableViewController *settingTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"settingTableViewController"];
            [self.navigationController pushViewController:settingTableViewController animated:YES];        
        } else {
            //ポップアップする
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"新規登録失敗", @"")
                                                            message:NSLocalizedString(@"もう既に使われているユーザ名です", @"")
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK",nil];
            alert.delegate = self;
            [alert show];
        }
    }
}

@end
