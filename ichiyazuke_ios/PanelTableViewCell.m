//
//  PanelTableViewCell.m
//  ichiyazuke_ios
//
//  Created by Yuichi Takada on 12/12/31.
//
//

#import "PanelTableViewCell.h"

@implementation PanelTableViewCell

@synthesize titleLabel;
@synthesize contentsLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureCell];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 10.0, 280.0, 30.0)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.contentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 40.0, 280.0, 42.0)];
    self.contentsLabel.font = [UIFont systemFontOfSize:14];
    self.contentsLabel.textColor = [UIColor darkGrayColor];
    self.contentsLabel.numberOfLines = 2;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentsLabel];
}

@end
