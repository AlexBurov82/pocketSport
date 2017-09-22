//
//  GymCell.h
//  pocketSport
//
//  Created by Александр on 24.01.17.
//
//

#import <UIKit/UIKit.h>

@interface GymCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *shadowSecondView;

@property (weak, nonatomic) IBOutlet UILabel *nameGymLabel;
@property (weak, nonatomic) IBOutlet UILabel *adderssGymLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlGymLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneGymLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionGymLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gymImage;

@end
