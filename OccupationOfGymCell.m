//
//  OccupationOfGymCell.m
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import "OccupationOfGymCell.h"
#import "UIView+Shadow.h"

@implementation OccupationOfGymCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.shadowView shadowViewLeft];
    [self.shadowSecondView shadowViewRight];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
