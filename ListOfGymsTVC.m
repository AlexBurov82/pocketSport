//
//  ListOfGymsTVC.m
//  pocketSport
//
//  Created by Александр on 24.01.17.
//
//

#import "ListOfGymsTVC.h"
#import "GymCell.h"
#import <SWRevealViewController.h>
#import "CardOfGymVC.h"
#import "UIView+UITableViewCell.h"

@interface ListOfGymsTVC () <SWRevealViewControllerDelegate>

@property (strong, nonatomic) NSArray *namesGymArray;
@property (strong, nonatomic) NSArray *addressesGymArray;

@property (strong, nonatomic) NSArray *descriptionsGymArray;
@property (strong, nonatomic) NSArray *urlsGymArray;
@property (strong, nonatomic) NSArray *phonesGymArray;
@property (strong, nonatomic) NSArray *photosGymArray;

@end

@implementation ListOfGymsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_dark"]];
    
    [self initTitle];
    
    [self actionMenuButton];
    
    [self outputAboutGyms];
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
                                 @"Прыжки на батуте дарят удивительное чувство бодрости, прилива сил и энергии.",
                                 @"Сегодня скалолазание становится все более популярным и приобретает новых поклонников, превращаясь из небольшого «кружка по интересам» в достаточно массовый вид активного отдыха.",
                                 @"Предлагаем посетить наш бассейн для свободного плавания длиной 25 метров на 3 дорожки. Он идеален для занятий акваэробикой и плаванием.", nil];
    
    self.urlsGymArray = [NSArray arrayWithObjects:
                         @"levelup76.ru",
                         @"topdrive76.ru",
                         @"vkazarmah.ru", nil];
    self.phonesGymArray = [NSArray arrayWithObjects:
                           @"+7 (4852) 33-72-00",
                           @"+7 (915) 973-31-76",
                           @"+7 (4852) 73-99-74", nil];
    
    self.photosGymArray = [NSArray arrayWithObjects:
                           @"levelup",
                           @"drive",
                           @"pool", nil];
    
}


- (void)initTitle {
    
    self.navigationItem.title = @"Поиск зала";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundImage:[UIImage imageNamed:@"logoNav"] forState:UIControlStateNormal];
    
    [button.layer setMasksToBounds:YES];
    
    button.frame = CGRectMake(0.0, 100.0, 84.41, 25.35);
    
    self.navigationItem.rightBarButtonItem.customView = button;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.namesGymArray count];;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *idGymCell= @"GymCell";
    
    GymCell *cell = [tableView dequeueReusableCellWithIdentifier:idGymCell];
    if (!cell) {
        cell = [[GymCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idGymCell];
    }
    
    cell.nameGymLabel.text = [self.namesGymArray objectAtIndex:indexPath.row];
    cell.adderssGymLabel.text = [self.addressesGymArray objectAtIndex:indexPath.row];
    cell.descriptionGymLabel.text = [self.descriptionsGymArray objectAtIndex:indexPath.row];
    cell.urlGymLabel.text = [self.urlsGymArray objectAtIndex:indexPath.row];
    cell.phoneGymLabel.text = [self.phonesGymArray objectAtIndex:indexPath.row];
    cell.gymImage.image = [UIImage imageNamed:[self.photosGymArray objectAtIndex:indexPath.row]];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    CardOfGymVC *cardOfGymVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CardOfGymVC"];
//    
//    cardOfGymVC.selectedIndexPhthGym = indexPath;
//    
//    NSLog(@"indexPath.row - %ld", (long)indexPath.row);
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    CardOfGymVC *cardOfGymVC = (CardOfGymVC *)segue.destinationViewController;
    
    if ([[segue identifier] isEqualToString:@"showCardOfGym"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        cardOfGymVC.selectedIndexPhthGym = indexPath;
    }
}

@end
