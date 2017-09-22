//
//  CalendarCVCell.m
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import "CalendarCVCell.h"

@implementation CalendarCVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.viewLine = [[UIView alloc] init];
    
}

- (void)setChecked:(BOOL)checked {
    
    _checked = checked;
    
    if(checked) {
        
        [self.viewLine setFrame:CGRectMake((self.monthLabel.frame.size.width - self.monthLabel.bounds.size.width)/2, self.monthLabel.frame.size.height, self.monthLabel.bounds.size.width, 2)];
        
        [self.viewLine setBackgroundColor:[UIColor colorWithRed:211/255.0 green:87/255.0 blue:21/255.0 alpha:1.0]];
        
        [self.monthLabel addSubview:self.viewLine];
        
    } else {
        
        [self.viewLine setFrame:CGRectMake((self.viewLine.frame.size.width - self.monthLabel.bounds.size.width)/2, self.monthLabel.frame.size.height, self.monthLabel.bounds.size.width, 2)];
        
        [self.viewLine setBackgroundColor:[UIColor clearColor]];
        
        [self.monthLabel addSubview:self.viewLine];
    }
}


//- (void)viewLineSelectedLabel:(UILabel *)label  andViewLine:(UIView *)viewLine {
//    
//    [viewLine setFrame:CGRectMake((label.frame.size.width - label.titleLabel.bounds.size.width)/2, label.frame.size.height-5, label.titleLabel.bounds.size.width, 2)];
//    
//    [viewLine setBackgroundColor:[UIColor colorWithRed:211/255.0 green:87/255.0 blue:21/255.0 alpha:1.0]];
//    
//    [label addSubview:viewLine];
//}
//
//- (void)viewLineSelectedLabel:(UILabel *)label  andViewLine:(UIView *)viewLine {
//    
//    [viewLine setFrame:CGRectMake((viewLine.frame.size.width - viewLine.titleLabel.bounds.size.width)/2, viewLine.frame.size.height-5, viewLine.titleLabel.bounds.size.width, 2)];
//    
//    [viewLine setBackgroundColor:[UIColor clearColor]];
//    
//    [sender addSubview:viewLine];
//}

@end


