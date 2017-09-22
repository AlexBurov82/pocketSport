//
//  PersonPhoneCell.m
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import "PersonPhoneCell.h"
#import "UITextField+Style.h"

@implementation PersonPhoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.phoneTextField shadowTextField];
    [self.phoneTextField spaceTextField];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
