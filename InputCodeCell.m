//
//  InputCodeCell.m
//  pocketSport
//
//  Created by Александр on 23.01.17.
//
//

#import "InputCodeCell.h"

@implementation InputCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self styleTextField:self.codeTextField];
    
//    [self shadowTextField:self.codeTextField];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)styleTextField:(UITextField *)textField {
    textField.layer.cornerRadius = 2;
    textField.layer.masksToBounds = NO;
    [textField.layer setShadowOffset:CGSizeMake(3, 3)];
    [textField.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [textField.layer setShadowOpacity:0.8];
}

- (void)shadowTextField:(UITextField *)textField {
    textField.layer.masksToBounds = NO;
    textField.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
    textField.layer.shadowRadius = 0.0f;
    textField.layer.shadowOpacity = 1.0f;
    textField.layer.shadowColor = [UIColor lightGrayColor].CGColor;
}


@end
