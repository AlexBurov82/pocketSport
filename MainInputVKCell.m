//
//  MainInputVKCell.m
//  pocketSport
//
//  Created by Александр on 23.01.17.
//
//

#import "MainInputVKCell.h"

@implementation MainInputVKCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self styleButton:self.inputVCButton];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)styleButton:(UIButton *)button {
    button.layer.cornerRadius = 2;
    
    [button.layer setShadowOffset:CGSizeMake(3, 3)];
    [button.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [button.layer setShadowOpacity:0.8];
}

@end
