//
//  PanelTableViewCell.h
//  ichiyazuke_ios
//
//  Created by Yuichi Takada on 12/12/31.
//
//

#import <UIKit/UIKit.h>

@interface PanelTableViewCell : UITableViewCell

@property (retain, nonatomic) UILabel *titleLabel;
@property (retain, nonatomic) UILabel *contentsLabel;

- (void)configureCell;

@end
