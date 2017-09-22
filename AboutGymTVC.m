//
//  AboutGymTVC.m
//  pocketSport
//
//  Created by Александр on 24.01.17.
//
//

#import "AboutGymTVC.h"
#import "AddressOfGymCell.h"
#import "AboutGymCell.h"
#import "PositionOfGymCell.h"
#import "PhotoGalleryCell.h"
#import <GoogleMaps/GoogleMaps.h>
#import "WebVC.h"
#import <MessageUI/MessageUI.h>

@interface AboutGymTVC () <GMSMapViewDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) NSArray *namesGymArray;
@property (strong, nonatomic) NSArray *addressesGymArray;
@property (strong, nonatomic) NSArray *descriptionsGymArray;
@property (strong, nonatomic) NSArray *emailsGymArray;
@property (strong, nonatomic) NSArray *urlsGymArray;
@property (strong, nonatomic) NSArray *phonesGymArray;
@property (strong, nonatomic) NSArray *positionsGymArray;
@property (strong, nonatomic) NSArray *photosGymArray;
@property (strong, nonatomic) NSArray *photosGalleryArray;
@property (strong, nonatomic) NSString *stringURL;
@property (strong, nonatomic) NSString *stringEmail;
@property (strong, nonatomic) NSString *stringPhone;
@property (strong, nonatomic) NSString *stringLat;
@property (strong, nonatomic) NSString *stringLon;

@end

@implementation AboutGymTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_dark"]];
    
    [self outputAboutGyms];
    
    self.photosGalleryArray = [NSArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)outputAboutGyms {
    
    self.namesGymArray = [NSArray arrayWithObjects:
                          @"Батутный центр LevelUp",
                          @"Cкалодром Top Drive",
                          @"Бассейн \"В Казармах\"", nil];
    
    self.addressesGymArray = [NSArray arrayWithObjects:
                              @"г. Ярославль, ул. Свободы, д.46/3 (территория Казарм)",
                              @"г. Ярославль, ул. Свободы, 91 (вход со двора ул. Рыбинская, фитнес-клуб \"5 звезд\")",
                              @"г. Ярославль, ул. Свободы, д.46/2 (территория Вознесенских Казарм)", nil];
    
    self.descriptionsGymArray = [NSArray arrayWithObjects:
                                 @"Прыжки на батуте дарят удивительное чувство бодрости, прилива сил и энергии. Это происходит потому, что во время прыжков в кровь активно выделяются адреналин и эндорфины, точно так же как и при занятиях экстремальными и небезопасными видами спорта.\n Именно поэтому батут чрезвычайно полезен людям, находящимся в стрессовых состояниях и депрессии.",
                                 @"Сегодня скалолазание становится все более популярным и приобретает новых поклонников, превращаясь из небольшого «кружка по интересам» в достаточно массовый вид активного отдыха.\n Скалолазание — это не просто вид фитнеса, выгоды от занятий которым не ограничиваются приобретением стальной хватки и пластичности, — это образ жизни. И, судя по большому разнообразию видов и стилей лазания, каждый сможет подобрать что-то индивидуально для себя.",
                                 @"Предлагаем посетить наш бассейн для свободного плавания длиной 25 метров на 3 дорожки. Он идеален для занятий акваэробикой и плаванием.\n Бассейн организован мужской и женскими раздевалками, имеет душевые и туалеты, а так же индивидуальные шкафчики для хранения вещей.", nil];
    self.emailsGymArray = [NSArray arrayWithObjects:
                           @"levelup76@yandex.ru",
                           @"983999@mail.ru",
                           @"yarbassein@yandex.ru", nil];
    self.urlsGymArray = [NSArray arrayWithObjects:
                           @"levelup76.ru",
                           @"topdrive76.ru",
                           @"vkazarmah.ru", nil];
    self.phonesGymArray = [NSArray arrayWithObjects:
                           @"+7 (4852) 33-72-00",
                           @"+7 (915) 973-31-76",
                           @"+7 (4852) 73-99-74", nil];
    
    self.positionsGymArray = [NSArray arrayWithObjects:
                              @"57.627252,39.869766",
                              @"57.625555,39.850129",
                              @"57.627252,39.869766", nil];
    self.photosGymArray = [NSArray arrayWithObjects:
                           @"levelup",
                           @"drive",
                           @"pool", nil];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            if ([self.photosGalleryArray count] > 0) {
                return 1;
            } else {
                return 0;
            }
            break;
            
        default:
            break;
    }
    
    return 4;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *idAddressOfGymCell = @"AddressOfGymCell";
    static NSString *idAboutGymCell = @"AboutGymCell";
    static NSString *idPositionOfGymCell = @"PositionOfGymCell";
    static NSString *idPhotoGalleryCell = @"PhotoGalleryCell";
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                AddressOfGymCell *cell = [tableView dequeueReusableCellWithIdentifier:idAddressOfGymCell];
                if (!cell) {
                    cell = [[AddressOfGymCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idAddressOfGymCell];
                }
                
                cell.nameGymLabel.text = [self.namesGymArray objectAtIndex:self.selectedIndexPhthGym.row];
                cell.adderssGymLabel.text = [self.addressesGymArray objectAtIndex:self.selectedIndexPhthGym.row];
                
                self.stringURL = [self.urlsGymArray objectAtIndex:self.selectedIndexPhthGym.row];
                cell.urlGymLabel.text = self.stringURL;
                
                self.stringEmail = [self.emailsGymArray objectAtIndex:self.selectedIndexPhthGym.row];
                cell.emailGymLabel.text = self.stringEmail;
                
                self.stringPhone = [self.phonesGymArray objectAtIndex:self.selectedIndexPhthGym.row];
                
                cell.phoneGymLabel.text = self.stringPhone;
                
                cell.gymImage.image = [UIImage imageNamed:[self.photosGymArray objectAtIndex:self.selectedIndexPhthGym.row]];
                
                [self tapGestureForAddress:cell.adderssGymLabel];
                
                [self tapGestureForURL:cell.urlGymLabel];
                
                [self tapGestureForEmail:cell.emailGymLabel];
                
                [self tapGestureForPhone:cell.phoneGymLabel];
                
                cell.backgroundColor = [UIColor clearColor];
                
                return cell;
            }
                break;
                
            case 1:
            {
                AboutGymCell *cell = [tableView dequeueReusableCellWithIdentifier:idAboutGymCell];
                if (!cell) {
                    cell = [[AboutGymCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idAboutGymCell];
                }
                
                cell.descriptionGymLabel.text = [self.descriptionsGymArray objectAtIndex:self.selectedIndexPhthGym.row];
                
                cell.backgroundColor = [UIColor clearColor];
                
                return cell;
            }
                break;
                
            case 2:
            {
                PositionOfGymCell *cell = [tableView dequeueReusableCellWithIdentifier:idPositionOfGymCell];
                if (!cell) {
                    cell = [[PositionOfGymCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idPositionOfGymCell];
                }
                
                [self initMapView:cell.mapView forLocation:[self.positionsGymArray objectAtIndex:self.selectedIndexPhthGym.row]];
                
                cell.backgroundColor = [UIColor clearColor];
                
                return cell;
            }
                break;
                
            default:
                break;
        }
    } else {
        PhotoGalleryCell *cell = [tableView dequeueReusableCellWithIdentifier:idPhotoGalleryCell];
        if (!cell) {
            cell = [[PhotoGalleryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idPhotoGalleryCell];
        }
        
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    }

    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}


- (void)initMapView:(GMSMapView *)mapView forLocation:(NSString *)location {
    
    NSArray *locationArray = [location componentsSeparatedByString:@","];
    
    double lat = [[locationArray firstObject]doubleValue];
    
    double lon = [[locationArray lastObject]doubleValue];
    
    self.stringLat = [locationArray firstObject];
    self.stringLon = [locationArray lastObject];
    
    mapView.myLocationEnabled = NO;
    
    mapView.mapType = kGMSTypeNormal;
    
    mapView.delegate = self;
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat,lon);
    
    mapView.camera = [GMSCameraPosition cameraWithTarget:coordinate zoom:16];
    
    CLLocationCoordinate2D geolocation = CLLocationCoordinate2DMake(lat,lon);
    
    GMSMarker *marker = [GMSMarker markerWithPosition:geolocation];
    
//    marker.icon = [UIImage imageNamed:@"pinHome"];
    
    marker.map = mapView;
}


- (void)tapGestureForAddress:(UILabel *)label {
    
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnAddress:)];
    [label addGestureRecognizer:tapGesture];
}

- (void)didTapOnAddress:(UITapGestureRecognizer *)tapGesture {
    
    NSString *stringURL = [NSString stringWithFormat:@"https://www.google.com.tr/maps/@%@,%@,15z?hl=ru&authuser=0", self.stringLat, self.stringLon];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringURL]];
}

- (void)tapGestureForURL:(UILabel *)label {
    
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnURL:)];
    [label addGestureRecognizer:tapGesture];
}

- (void)didTapOnURL:(UITapGestureRecognizer *)tapGesture {
    
    [self performSegueWithIdentifier:@"showWebVC" sender:self];
}

- (void)tapGestureForEmail:(UILabel *)label {
    
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnEmail:)];
    [label addGestureRecognizer:tapGesture];
}

- (void)didTapOnEmail:(UITapGestureRecognizer *)tapGesture {
    
    [self sendMail:self.stringEmail];
}

- (void)tapGestureForPhone:(UILabel *)label {
    
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnPhone:)];
    [label addGestureRecognizer:tapGesture];
}

- (void)didTapOnPhone:(UITapGestureRecognizer *)tapGesture {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [self formatNumber:[self formatString:self.stringPhone]]]]];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    WebVC *webVC = (WebVC *)segue.destinationViewController;
    
    if ([[segue identifier] isEqualToString:@"showWebVC"]) {
        
        webVC.stringURL = self.stringURL;
    }
}

- (NSString *)formatString:(NSString *)string {
    
    NSString *string1 = [string stringByReplacingOccurrencesOfString:@"+" withString:@""];
    NSString *string2 = [string1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *string3 = [string2 stringByReplacingOccurrencesOfString:@"(" withString:@""];
    NSString *string4 = [string3 stringByReplacingOccurrencesOfString:@")" withString:@""];
    NSString *string5 = [string4 stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return string5;
}

- (NSString *)formatNumber:(NSString *)mobileNumber {
    
    NSString *tenDigitNumber = mobileNumber;
    tenDigitNumber = [tenDigitNumber
                      stringByReplacingOccurrencesOfString:@"(\\d{4})(\\d{3})(\\d{4})"
                      withString:@"$1-$2-$3"
                      options:NSRegularExpressionSearch
                      range:NSMakeRange(0, [tenDigitNumber length])];
    NSLog(@"%@", tenDigitNumber);
    
    return tenDigitNumber;
}

- (void)sendMail:(NSString *)mail {
    
    if (![MFMailComposeViewController canSendMail]) {
        
        [self showAlertControllerMail];
        return;
    } else {
        NSString *emailTitle = @"";
        NSString *messageBody = @"";
        NSArray *toRecipents = [NSArray arrayWithObject:mail];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        [self presentViewController:mc animated:YES completion:NULL];
    }
}
//feetdback
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)showAlertControllerMail {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:@"Почтовые службы не доступны."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                   ;
                               }];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
