//
//  GymCell.m
//  pocketSport
//
//  Created by Александр on 24.01.17.
//
//

#import "GymCell.h"
#import "UIView+Shadow.h"

@implementation GymCell

- (void)awakeFromNib {
    [super awakeFromNib];
    

    [self.shadowView shadowViewLeft];
    [self.shadowSecondView shadowViewRight];

    self.gymImage.layer.cornerRadius = self.gymImage.frame.size.height/2;
    self.gymImage.layer.masksToBounds = YES;
//    self.gymImage.layer.borderWidth = 1.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
