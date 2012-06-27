//
//  PanelViewController.h
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/06/28.
//  Copyright (c) 2012年 gishhub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanelViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
- (IBAction)tweetButton:(id)sender;
@end
