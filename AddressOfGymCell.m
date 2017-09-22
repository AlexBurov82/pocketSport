//
//  AddressOfGymCell.m
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import "AddressOfGymCell.h"

@implementation AddressOfGymCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.gymImage.layer.cornerRadius = self.gymImage.frame.size.height/2;
    self.gymImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
