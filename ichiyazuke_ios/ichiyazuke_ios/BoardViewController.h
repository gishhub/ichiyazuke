//
//  BoardViewController.h
//  ichiyazuke_ios
//
//  Created by 高田 祐一 on 12/05/03.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
- (IBAction)tweetButton:(id)sender;

@end
