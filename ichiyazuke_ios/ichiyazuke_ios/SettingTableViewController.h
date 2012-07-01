//
//  SettingTableViewController.h
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/05/19.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewController : UITableViewController

@property (retain, readwrite) NSString *grade;
@property (retain, readwrite) NSString *category;
@property (retain, readwrite) NSString *level;

- (void)reloadTable;

@end