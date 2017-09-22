//
//  CardOfGymVC.m
//  pocketSport
//
//  Created by Александр on 24.01.17.
//
//

#import "CardOfGymVC.h"
#import "AboutGymTVC.h"
#import "ScheduleOfGymTVC.h"

@interface CardOfGymVC ()

@property (strong, nonatomic) UIView *viewLine1;
@property (strong, nonatomic) UIView *viewLine2;
@property (strong, nonatomic) UIView *viewLine3;

@end

@implementation CardOfGymVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitle];
    
    self.viewLine1 = [[UIView alloc]init];
    self.viewLine2 = [[UIView alloc]init];
    self.viewLine3 = [[UIView alloc]init];
    
    [UIView animateWithDuration:0.0 animations:^{
        self.aboutGymContainer.alpha = 1;
        self.scheduleOfGymContainer.alpha = 0;
        self.servicesOfGymContainer.alpha = 0;
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self viewLineSelectedButton:self.aboutGymButton andViewLine:self.viewLine1];
    [self viewLineDeselectedButton:self.scheduleOfGymButton andViewLine:self.viewLine2];
    [self viewLineDeselectedButton:self.servicesOfGymButton andViewLine:self.viewLine3];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTitle {
    
    self.navigationItem.title = @"Карточка зала";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundImage:[UIImage imageNamed:@"logoNav"] forState:UIControlStateNormal];
    
    [button.layer setMasksToBounds:YES];
    
    button.frame = CGRectMake(0.0, 100.0, 84.41, 25.35);
    
    self.navigationItem.rightBarButtonItem.customView = button;
}

- (void)segmentControlAction:(UIButton *)sender {
    
    if (sender.tag == 1) {
        [UIView animateWithDuration:0.0 animations:^{
            self.aboutGymContainer.alpha = 1;
            self.scheduleOfGymContainer.alpha = 0;
            self.servicesOfGymContainer.alpha = 0;
            
            [self viewLineSelectedButton:self.aboutGymButton andViewLine:self.viewLine1];
            [self viewLineDeselectedButton:self.scheduleOfGymButton andViewLine:self.viewLine2];
            [self viewLineDeselectedButton:self.servicesOfGymButton andViewLine:self.viewLine3];
        }];
    } else if (sender.tag == 2) {
        [UIView animateWithDuration:0.0 animations:^{
            self.aboutGymContainer.alpha = 0;
            self.scheduleOfGymContainer.alpha = 1;
            self.servicesOfGymContainer.alpha = 0;
            
            [self viewLineDeselectedButton:self.aboutGymButton andViewLine:self.viewLine1];
            [self viewLineSelectedButton:self.scheduleOfGymButton andViewLine:self.viewLine2];
            [self viewLineDeselectedButton:self.servicesOfGymButton andViewLine:self.viewLine3];
        }];
    } else if (sender.tag == 3) {
        [UIView animateWithDuration:0.0 animations:^{
            self.aboutGymContainer.alpha = 0;
            self.scheduleOfGymContainer.alpha = 0;
            self.servicesOfGymContainer.alpha = 1;
            
            [self viewLineDeselectedButton:self.aboutGymButton andViewLine:self.viewLine1];
            [self viewLineDeselectedButton:self.scheduleOfGymButton andViewLine:self.viewLine2];
            [self viewLineSelectedButton:self.servicesOfGymButton andViewLine:self.viewLine3];
        }];
    }
}

- (IBAction)aboutGymAction:(UIButton *)sender {
    
    [self segmentControlAction:sender];
}

- (IBAction)scheduleOfGymAction:(UIButton *)sender {
    
    [self segmentControlAction:sender];
}

- (IBAction)servicesOfGymAction:(UIButton *)sender {
    
    [self segmentControlAction:sender];
}

- (void)viewLineSelectedButton:(UIButton *)sender  andViewLine:(UIView *)viewLine {
    
    [viewLine setFrame:CGRectMake((sender.frame.size.width - sender.titleLabel.bounds.size.width)/2, sender.frame.size.height-5, sender.titleLabel.bounds.size.width, 2)];
    
    [viewLine setBackgroundColor:[UIColor colorWithRed:211/255.0 green:87/255.0 blue:21/255.0 alpha:1.0]];
    
    [sender addSubview:viewLine];
}

- (void)viewLineDeselectedButton:(UIButton *)sender  andViewLine:(UIView *)viewLine {
    
    [viewLine setFrame:CGRectMake((sender.frame.size.width - sender.titleLabel.bounds.size.width)/2, sender.frame.size.height-5, sender.titleLabel.bounds.size.width, 2)];
    
    [viewLine setBackgroundColor:[UIColor clearColor]];
    
    [sender addSubview:viewLine];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    AboutGymTVC *aboutGymTVC = (AboutGymTVC *)segue.destinationViewController;
    
    ScheduleOfGymTVC *scheduleOfGymTVC = (ScheduleOfGymTVC *)segue.destinationViewController;
    
    if ([[segue identifier] isEqualToString:@"showAboutGym"]) {
        
        aboutGymTVC.selectedIndexPhthGym = self.selectedIndexPhthGym;
    }
    
    if ([[segue identifier] isEqualToString:@"showScheduleOfGym"]) {
        
        scheduleOfGymTVC.selectedIndexPhthGym = self.selectedIndexPhthGym;
    }

}


@end
