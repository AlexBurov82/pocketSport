//
//  EMailCell.m
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import "EMailCell.h"
#import "UITextField+Style.h"

@implementation EMailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.eMailTextField shadowTextField];
    
    [self.eMailTextField spaceTextField];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
