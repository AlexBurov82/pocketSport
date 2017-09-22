//
//  GenderDateOfbirthCell.m
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import "GenderDateOfbirthCell.h"
#import "UITextField+Style.h"

@implementation GenderDateOfbirthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.genderTextField shadowTextField];
    [self.dateOfBirthTextField shadowTextField];
    
    [self.genderTextField spaceTextField];
    [self.dateOfBirthTextField spaceTextField];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
