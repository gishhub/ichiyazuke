//
//  LoginTableViewController.h
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/07/07.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTableViewController : UITableViewController

@property (retain, nonatomic) NSUserDefaults *userDefaults;
@property (retain, nonatomic) UITextField *username;
@property (retain, nonatomic) UITextField *password;

- (void)configureView;
- (void)selectedLoginBtn:(id)sender;
- (void)selectedSignUpBtn:(id)sender;

@end
