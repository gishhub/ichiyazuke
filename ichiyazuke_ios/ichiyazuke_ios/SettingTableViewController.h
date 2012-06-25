//
//  SettingTableViewController.h
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/05/19.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewController : UITableViewController
@property (retain, readwrite) NSString *selectedGrade;
@property (retain, readwrite) NSString *selectedCategory;
@property (retain, readwrite) NSString *selectedLevel;
- (void) reloadTable;
@end