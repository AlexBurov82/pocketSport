//
//  AddressOfGymCell.h
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import <UIKit/UIKit.h>

@interface AddressOfGymCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameGymLabel;
@property (weak, nonatomic) IBOutlet UILabel *adderssGymLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailGymLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlGymLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneGymLabel;

@property (weak, nonatomic) IBOutlet UIImageView *gymImage;

@end
