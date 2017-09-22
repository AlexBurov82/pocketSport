//
//  MainInputTelephoneCell.m
//  pocketSport
//
//  Created by Александр on 23.01.17.
//
//

#import "MainInputTelephoneCell.h"
#import "UITextField+Style.h"

@implementation MainInputTelephoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.phoneTextField shadowTextFieldStyle1];
    
    [self.phoneTextField spaceTextField];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
