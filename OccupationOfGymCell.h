//
//  OccupationOfGymCell.h
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import <UIKit/UIKit.h>

@interface OccupationOfGymCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *shadowSecondView;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPeopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusActivityLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusRecordsLabel;


@end
