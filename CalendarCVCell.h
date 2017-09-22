//
//  CalendarCVCell.h
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import <UIKit/UIKit.h>

@interface CalendarCVCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

@property (assign, nonatomic) BOOL checked;

@property (strong, nonatomic) UIView *viewLine;

@end
