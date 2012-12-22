//
//  SettingTableViewController.h
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/05/19.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewController : UITableViewController

@property (retain, nonatomic) NSUserDefaults *userDefaults;
@property (retain, nonatomic) NSString *grade;
@property (retain, nonatomic) NSString *category;
@property (retain, nonatomic) NSString *level;

- (void)configureView;
- (void)reloadTable;

@end