//
//  PersonNameCell.h
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import <UIKit/UIKit.h>

@interface PersonNameCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *surnameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *userPhotoView;

@end
