//
//  CardOfGymVC.h
//  pocketSport
//
//  Created by Александр on 24.01.17.
//
//

#import <UIKit/UIKit.h>

@interface CardOfGymVC : UIViewController

@property (weak, nonatomic) IBOutlet UIView *aboutGymContainer;
@property (weak, nonatomic) IBOutlet UIView *scheduleOfGymContainer;
@property (weak, nonatomic) IBOutlet UIView *servicesOfGymContainer;

@property (weak, nonatomic) IBOutlet UIButton *aboutGymButton;
@property (weak, nonatomic) IBOutlet UIButton *scheduleOfGymButton;
@property (weak, nonatomic) IBOutlet UIButton *servicesOfGymButton;

@property (strong, nonatomic) NSIndexPath *selectedIndexPhthGym;
@property (weak, nonatomic) IBOutlet UIView *backgroundButtonView;


- (IBAction)aboutGymAction:(UIButton *)sender;
- (IBAction)scheduleOfGymAction:(UIButton *)sender;
- (IBAction)servicesOfGymAction:(UIButton *)sender;

@end
