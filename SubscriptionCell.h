//
//  SubscriptionCell.h
//  pocketSport
//
//  Created by Александр on 27.01.17.
//
//

#import <UIKit/UIKit.h>

@interface SubscriptionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *shadowSecondView;

@property (weak, nonatomic) IBOutlet UILabel *nameGymLabel;
@property (weak, nonatomic) IBOutlet UILabel *adderssGymLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionGymLabel;
@property (weak, nonatomic) IBOutlet UILabel *datesLabel;


@end
