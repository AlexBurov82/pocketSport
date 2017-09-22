//
//  UITextField+Style.m
//  pocketSport
//
//  Created by Александр on 11.02.17.
//
//

#import "UITextField+Style.h"

@implementation UITextField (Style)

- (void)spaceTextField {
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)shadowTextField {
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0.0f,1.0f);
    self.layer.shadowRadius = 0.0f;
    self.layer.shadowOpacity = 1.0f;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
}

- (void)shadowTextFieldStyle1 {
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = NO;
    [self.layer setShadowOffset:CGSizeMake(3, 3)];
    [self.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.layer setShadowOpacity:0.8];
}

@end
