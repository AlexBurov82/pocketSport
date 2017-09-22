//
//  PersonInformationTVC.m
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import "PersonInformationTVC.h"
#import "PersonNameCell.h"
#import "PersonPhoneCell.h"
#import "EMailCell.h"
#import "GenderDateOfbirthCell.h"
#import "WeightGrowthCell.h"
#import "PersonSportsCell.h"
#import <SWRevealViewController.h>
#import "ServerManager.h"
#import "Authentication.h"

@interface PersonInformationTVC () <SWRevealViewControllerDelegate>

@property (strong, nonatomic) Authentication *auth;

@property (strong, nonatomic) NSString *userNameString;
@property (strong, nonatomic) NSString *userSurnameString;
@property (strong, nonatomic) NSString *usersPhoneString;
@property (strong, nonatomic) NSString *userEmailString;
@property (strong, nonatomic) NSString *usersurnameString;
@property (strong, nonatomic) NSString *userGenderString;
@property (strong, nonatomic) NSString *userDateOfBirthString;
@property (strong, nonatomic) NSString *userWeightString;
@property (strong, nonatomic) NSString *userGrowthString;

@property (strong, nonatomic) UITextField *selectedTextField;

@property (strong, nonatomic) NSIndexPath *selectedIndexPhth;


@end

@implementation PersonInformationTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.personInformationTV.backgroundColor = [UIColor clearColor];
    self.personInformationTV.opaque = NO;
    self.personInformationTV.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_dark"]];
    
    [self initTitle];
    
    [self actionMenuButton];
    
    [self styleButton:self.saveButton];
    
    [self outputTextField];
    
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTitle {
    
    self.navigationItem.title = @"Личная информация";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundImage:[UIImage imageNamed:@"logoNav"] forState:UIControlStateNormal];
    
    [button.layer setMasksToBounds:YES];
    
    button.frame = CGRectMake(0.0, 100.0, 84.41, 25.35);
    
    self.navigationItem.rightBarButtonItem.customView = button;
}

- (void)outputTextField {
    
    self.auth = [self unarchivingAuthentication];
    
    self.userNameString = [self formatSring:self.auth.clientName];
    self.userSurnameString = [self formatSring:self.auth.clientLastName];
    self.usersPhoneString = [NSString stringWithFormat:@"%@",self.auth.clientPhone];
    self.userEmailString = self.auth.clientEmail;
//    self.userGenderString;
//    self.userDateOfBirthString;
//    self.userWeightString;
//    self.userGrowthString;
}

- (NSString *)formatSring:(NSString *)string {
    
    NSMutableString *formatString = [NSMutableString stringWithFormat:@"%@", string];
    
    [formatString replaceCharactersInRange:NSMakeRange(0, 1) withString:[formatString substringToIndex:1].capitalizedString];
    
    NSString *newString = [NSMutableString stringWithFormat:@"%@", formatString];
    
    return newString;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSInteger tag = textField.tag;
    
    if (tag == 1) {
        self.userNameString = textField.text;
    }
    if (tag == 2) {
        self.userSurnameString = textField.text;
    }
    if (tag == 3) {
        self.usersPhoneString = textField.text;
    }
    if (tag == 4) {
        self.userEmailString = textField.text;
    }
    if (tag == 5) {
        self.userGenderString = textField.text;
    }
    if (tag == 6) {
        self.userDateOfBirthString = textField.text;
    }
    if (tag == 7) {
        self.userWeightString = textField.text;
    }
    if (tag == 8) {
        self.userGrowthString = textField.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSInteger nextTag = textField.tag + 1;
    
    UIResponder* nextResponder = [self.personInformationTV viewWithTag:nextTag];
    
    if (nextResponder) {
        
        [textField resignFirstResponder];
        
    } else {
        
        [textField resignFirstResponder];
    }
    
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    self.selectedTextField = textField;
    self.selectedIndexPhth = [self textFieldIndexPath:textField];
    
    return YES;
}




#pragma mark - SWRevealViewController

- (void)actionMenuButton {
    
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if (revealViewController) {
        [self.menuButton setTarget:self.revealViewController];
        [self.menuButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
        revealViewController.delegate = self;
    }
}

#pragma mark - SWRevealViewControllerDelegate Protocol

- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position {
    
    if (self.selectedTextField) {
        [self.selectedTextField resignFirstResponder];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *idPersonNameCell = @"PersonNameCell";
    static NSString *idPersonPhoneCell = @"PersonPhoneCell";
    static NSString *idEMailCell = @"EMailCell";
    static NSString *idGenderDateOfbirthCell = @"GenderDateOfbirthCell";
    static NSString *idWeightGrowthCell = @"WeightGrowthCell";
    static NSString *idPersonSportsCell = @"PersonSportsCell";
    
    switch (indexPath.row) {
        case 0:
        {
            PersonNameCell *cell = [tableView dequeueReusableCellWithIdentifier:idPersonNameCell];
            if (!cell) {
                cell = [[PersonNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idPersonNameCell];
            }
            
            cell.nameTextField.text = self.userNameString;
            cell.surnameTextField.text = self.userSurnameString;
            
            return cell;
        }
            break;
            
        case 1:
        {
            PersonPhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:idPersonPhoneCell];
            if (!cell) {
                cell = [[PersonPhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idPersonPhoneCell];
            }
            
            cell.phoneTextField.text = self.usersPhoneString;
            
            return cell;
        }
            break;
            
        case 2:
        {
            EMailCell *cell = [tableView dequeueReusableCellWithIdentifier:idEMailCell];
            if (!cell) {
                cell = [[EMailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idEMailCell];
            }
            
            cell.eMailTextField.text = self.userEmailString;
            
            return cell;
        }
            break;
            
        case 3:
        {
            GenderDateOfbirthCell *cell = [tableView dequeueReusableCellWithIdentifier:idGenderDateOfbirthCell];
            if (!cell) {
                cell = [[GenderDateOfbirthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idGenderDateOfbirthCell];
            }
            
            cell.genderTextField.text = self.userGenderString;
            
            cell.dateOfBirthTextField.text = self.userDateOfBirthString;
            
            return cell;
        }
            break;
            
        case 4:
        {
            WeightGrowthCell *cell = [tableView dequeueReusableCellWithIdentifier:idWeightGrowthCell];
            if (!cell) {
                cell = [[WeightGrowthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idWeightGrowthCell];
            }
            
            cell.weightTextField.text = self.userWeightString;
            
            cell.growthTextField.text = self.userGrowthString;
            
            return cell;
        }
            break;
            
        case 5:
        {
            PersonSportsCell *cell = [tableView dequeueReusableCellWithIdentifier:idPersonSportsCell];
            if (!cell) {
                cell = [[PersonSportsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idPersonSportsCell];
            }
            
            return cell;
        }
            break;
            
            
        default:
            break;
    
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

- (void)styleButton:(UIButton *)button {
    button.layer.cornerRadius = 2;
}

- (void)updateUsrOfData:(Authentication *)auth {
    
    [[ServerManager shareManager]updateUsrOfData:auth onSuccess:^(NSInteger result) {

        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"error = %@, code = %ld", [error localizedDescription], (long)statusCode);
    }];

}

#pragma mark - NSCoding

- (void)archivingAuthentication:(Authentication *)auth {
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:auth];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"auth"];
}

- (Authentication *)unarchivingAuthentication {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"auth"];
    Authentication *auth = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return auth;
}

- (IBAction)saveAction:(UIButton *)sender {
    
    self.auth.clientName = self.userNameString;
    self.auth.clientLastName = self.userSurnameString;
    self.auth.clientPhone = [NSNumber numberWithInteger:[self.usersPhoneString integerValue]];
    self.auth.clientEmail = self.userEmailString;
    
    [self updateUsrOfData:self.auth];
}


- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.personInformationTV.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    self.personInformationTV.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height), 0.0);
        
        self.personInformationTV.contentInset = contentInsets;
        self.personInformationTV.scrollIndicatorInsets = contentInsets;
        
        if (self.selectedIndexPhth) {
            [self.personInformationTV scrollToRowAtIndexPath:self.selectedIndexPhth atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        
    } else {
        
        CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        
        UIEdgeInsets contentInsets;
        
        if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
            contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height), 0.0);
            self.personInformationTV.contentInset = contentInsets;
            self.personInformationTV.scrollIndicatorInsets = contentInsets;
            
            if (self.selectedIndexPhth) {
                [self.personInformationTV scrollToRowAtIndexPath:self.selectedIndexPhth atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        }
    }
}


- (NSIndexPath *)textFieldIndexPath:(UITextField *)textField {
    
    CGPoint origin = textField.frame.origin;
    CGPoint point = [textField.superview convertPoint:origin toView:self.personInformationTV];
    
    NSIndexPath * indexPath = [self.personInformationTV indexPathForRowAtPoint:point];
    
    return indexPath;
}


@end
