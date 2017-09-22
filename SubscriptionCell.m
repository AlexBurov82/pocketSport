//
//  SubscriptionCell.m
//  pocketSport
//
//  Created by Александр on 27.01.17.
//
//

#import "SubscriptionCell.h"

@implementation SubscriptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.shadowView.layer.masksToBounds = NO;
    self.shadowView.layer.shadowOffset = CGSizeMake(-1.0f,2.0f);
    self.shadowView.layer.shadowRadius = 0.5f;
    self.shadowView.layer.shadowOpacity = 0.6f;
    self.shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    
    self.shadowSecondView.layer.masksToBounds = NO;
    self.shadowSecondView.layer.shadowOffset = CGSizeMake(1.0f,2.0f);
    self.shadowSecondView.layer.shadowRadius = 0.5f;
    self.shadowSecondView.layer.shadowOpacity = 0.6f;
    self.shadowSecondView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
