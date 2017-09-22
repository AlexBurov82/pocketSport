//
//  ScheduleOfGymTVC.m
//  pocketSport
//
//  Created by Александр on 25.01.17.
//
//

#import "ScheduleOfGymTVC.h"
#import "ScheduleDateCell.h"
#import "OccupationOfGymCell.h"
#import "CalendarCVCell.h"
#import "ServerManager.h"
#import "Activity.h"
#import "UIView+UITableViewCell.h"

@interface ScheduleOfGymTVC ()

@property (strong, nonatomic) NSArray *days;

@property (strong, nonatomic) NSIndexPath *checkedIndexPath;

@property (strong, nonatomic) NSArray *schedule;

@property (strong, nonatomic) NSDate *dateToday;

@end

@implementation ScheduleOfGymTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_dark"]];
    
    self.days = [self calendarForGym];
    
    NSInteger row = [self indexRowForDate:self.dateToday inArray:self.days];
    
    self.checkedIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
    if (self.selectedIndexPhthGym.row == 0) {
        [self getScheduleForDate:[NSDate date]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)calendarForGym {
    
    NSMutableArray *tempDatesArray = [NSMutableArray array];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *date = [NSDate date];
    
    self.dateToday = date;
    
    for (int i = -7; i <= 7; i++) {
        
        NSDateComponents *components = [[NSDateComponents alloc] init];
        
        [components setDay:i];
        
        NSDate *dateNew = [calendar dateByAddingComponents:components toDate:date options:0];
        
        [tempDatesArray addObject:dateNew];
    }
    
    NSArray *datesArray = [NSArray arrayWithArray:tempDatesArray];
    
    return datesArray;
}

- (NSString*)dateFormatToDay:(NSDate*)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"dd"];
    
    return [formatter stringFromDate:date];
}

- (NSString*)dateFormatToMonth:(NSDate*)date {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"MMM"];
    
    return [formatter stringFromDate:date];
}

- (BOOL)compareDate:(NSDate *)date1 andDate:(NSDate *)date2 {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    if ([[dateFormat stringFromDate:date1] isEqualToString:[dateFormat stringFromDate:date2]]) {
    
        return YES;
    } else {
        return NO;
    }
}

- (NSInteger)indexRowForDate:(NSDate *)date inArray:(NSArray *)array {
    
    NSInteger indexRow = 0;
    
    for (int i = 0; i < [array count]; i++) {
        if ([self compareDate:date andDate:array[i]]) {
            indexRow = i;
        }
    }
    return indexRow;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else {
        return [self.schedule count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *idScheduleDateCell = @"ScheduleDateCell";
    static NSString *idOccupationOfGymCell = @"OccupationOfGymCell";
    
    if (indexPath.section == 0) {
        ScheduleDateCell *cell = [tableView dequeueReusableCellWithIdentifier:idScheduleDateCell];
        if (!cell) {
            cell = [[ScheduleDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idScheduleDateCell];
        }
        
        [cell.calendarCV scrollToItemAtIndexPath:self.checkedIndexPath
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:YES];
        
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    } else {
        OccupationOfGymCell *cell = [tableView dequeueReusableCellWithIdentifier:idOccupationOfGymCell];
        if (!cell) {
            cell = [[OccupationOfGymCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idOccupationOfGymCell];
        }
        
        Activity *activity = self.schedule[indexPath.row];
        
        NSString *startTime = @"";
        
        if (activity.startTime) {
            startTime = activity.startTime;
        }
        
        NSString *endTime = @"";
        
        if (activity.endTime) {
            endTime = [NSString stringWithFormat:@"-%@", activity.endTime];
        }
        
        cell.startTimeLabel.text = [NSString stringWithFormat:@"%@%@", startTime, endTime];
        
        cell.activityNameLabel.text = activity.activityName;
        
        NSString *maxCountSring = [NSString stringWithFormat:@"%ld", (long)activity.registeredCount];
        
        NSString *freeCountSring = [NSString stringWithFormat:@"%ld", (long)(activity.maxCount - activity.registeredCount)];
        
        NSString *numberOfPeopleString = [NSString stringWithFormat:@"Записано: %@ человек. Свободно: %@.", maxCountSring, freeCountSring];

        cell.numberOfPeopleLabel.attributedText = [self setColorForText:numberOfPeopleString];
        
        cell.statusRecordsLabel.text = @"";

        NSDate *dateStart = [self formatDateFromSring:activity.startTime andDay:activity.activityDate];
        
        NSDate *dateFinish = [self formatDateFromSring:activity.endTime andDay:activity.activityDate];
        
        NSInteger statusActivity = [self checkStatusOfActivityForDateStart:dateStart andDateFinish:dateFinish];
        
        [self styleOfTextLabel:cell.statusActivityLabel forStatusOfActivity:statusActivity];
        
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.days count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *idCalendarCVCell = @"CalendarCVCell";
    
    CalendarCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:idCalendarCVCell forIndexPath:indexPath];
    
    NSDate *date = self.days[indexPath.row];
    
    if ([self compareDate:date andDate:[NSDate date]]) {
        
        UIColor *redColor = [UIColor colorWithRed:211/255.0 green:87/255.0 blue:21/255.0 alpha:1.0];
        
        [cell.dayLabel setTextColor:redColor];
        
        [cell.monthLabel setTextColor:redColor];
        
    } else {
        
        UIColor *whiteColor = [UIColor whiteColor];
        
        [cell.dayLabel setTextColor:whiteColor];
        
        [cell.monthLabel setTextColor:whiteColor];
    }
    
    cell.dayLabel.text = [self dateFormatToDay:date];
    
    cell.monthLabel.text = [[self dateFormatToMonth:date]  uppercaseString];
    
    if ([self.checkedIndexPath isEqual:indexPath]) {
        
        cell.checked = YES;
    } else {
        cell.checked = NO;
    }
    
    return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    
    self.dateToday = self.days[indexPath.item];
    
    [self getScheduleForDate:self.dateToday];
    
    if (self.checkedIndexPath) {
        CalendarCVCell* uncheckCell = (CalendarCVCell*)[collectionView cellForItemAtIndexPath:self.checkedIndexPath];
        
        uncheckCell.checked = NO;
    }
    
    CalendarCVCell* cell = (CalendarCVCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    if ([self.checkedIndexPath isEqual:indexPath]) {
        
        cell.checked = NO;
        
    }  else {
        
        self.checkedIndexPath = indexPath;
        
        cell.checked = YES;
    }
}

- (void)getScheduleForDate:(NSDate *)date {
    
    [[ServerManager shareManager]getScheduleForDate:date onSuccess:^(NSArray *schedule) {
        self.schedule = [NSArray arrayWithArray:schedule];
        
        [self.tableView reloadData];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"error = %@, code = %ld", [error localizedDescription], (long)statusCode);
    }];
}

- (void)getAvailabilityForActivityId:(NSInteger)activityId atDate:(NSDate *)date {

    [[ServerManager shareManager]getAvailabilityForActivityId:activityId atDate:date onSuccess:^(NSArray *records) {
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"error = %@, code = %ld", [error localizedDescription], (long)statusCode);
    }];
}

-(NSMutableAttributedString *)setColorForText:(NSString*)text {
    
    NSMutableAttributedString *mutAttString = [[NSMutableAttributedString alloc] initWithString:text];

    NSRange range1 = NSMakeRange(9, 3);
    NSRange range2 = NSMakeRange([text length]-3, 2);
    
    UIColor *redColor = [UIColor colorWithRed:211/255.0 green:87/255.0 blue:21/255.0 alpha:1.0];
    
    UIColor *greenColor = [UIColor colorWithRed:98/255.0 green:194/255.0 blue:129/255.0 alpha:1.0];
    
    [mutAttString addAttribute:NSForegroundColorAttributeName
                         value:redColor
                         range:range1];
    
    [mutAttString addAttribute:NSForegroundColorAttributeName
                         value:greenColor
                         range:range2];
    
    return mutAttString;
}

- (NSDate *)formatDateFromSring:(NSString *)timeString andDay:(NSString *)dayString {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    if (dayString != nil && timeString != nil) {
        NSArray *day = [dayString componentsSeparatedByString:@"-"];
        NSArray *time = [timeString componentsSeparatedByString:@":"];
        
        if ([day count] == 3 && [time count] == 2) {
            [components setYear:[day[0]integerValue]];
            [components setMonth:[day[1]integerValue]];
            [components setDay:[day[2]integerValue]];
            [components setHour:[time[0]integerValue]];
            [components setMinute:[time[1]integerValue]];
        }
    }

    NSDate *date = [calendar dateFromComponents:components];

    return date;
}

- (NSInteger)checkStatusOfActivityForDateStart:(NSDate *)dateStart andDateFinish:(NSDate *)dateFinish {
    
    NSInteger statusOfActivity;
    
    NSDate *dateNow = [NSDate date];
    
    if ([dateNow timeIntervalSinceReferenceDate] < [dateStart timeIntervalSinceReferenceDate]) {
        statusOfActivity = 0;
    } else if ([dateStart timeIntervalSinceReferenceDate] < [dateNow timeIntervalSinceReferenceDate] &&
               [dateNow timeIntervalSinceReferenceDate] < [dateFinish timeIntervalSinceReferenceDate]) {
        statusOfActivity = 1;
    } else if ([dateNow timeIntervalSinceReferenceDate] > [dateFinish timeIntervalSinceReferenceDate]) {
        statusOfActivity = 2;
    } else {
        statusOfActivity = 3;
    }
    
    return statusOfActivity;
}

- (void)styleOfTextLabel:(UILabel *)label forStatusOfActivity:(NSInteger)stauts {
    
    if (stauts == 0) {
        label.textColor = [UIColor colorWithRed:217/255.0 green:159/255.0 blue:3/255.0 alpha:1.0];
        
        label.backgroundColor = [UIColor colorWithRed:217/255.0 green:159/255.0 blue:3/255.0 alpha:0.3];
        
        label.text = @" Занятие не началось  ";
        
    } else if (stauts == 1) {
        label.textColor = [UIColor colorWithRed:98/255.0 green:194/255.0 blue:129/255.0 alpha:1.0];
        
        label.backgroundColor = [UIColor colorWithRed:98/255.0 green:194/255.0 blue:129/255.0 alpha:0.3];
        label.text = @" Идет занятие  ";
        
    } else if (stauts == 2) {
        label.textColor = [UIColor colorWithRed:120/255.0 green:186/255.0 blue:196/255.0 alpha:1.0];
        
        label.backgroundColor = [UIColor colorWithRed:120/255.0 green:186/255.0 blue:196/255.0 alpha:0.3];
        label.text = @" Занятие окончено  ";
    } else {
        
        label.textColor = [UIColor clearColor];
        
        label.backgroundColor = [UIColor clearColor];
        label.text = @"";
    }
    
        
}




- (IBAction)recordAction:(UIButton *)sender {
    
    OccupationOfGymCell* cell = (OccupationOfGymCell*)[sender superCell];
    
    NSIndexPath* indexPath = [self.tableView  indexPathForCell:cell];
    
    Activity *activity = self.schedule[indexPath.row];
    
    [self getAvailabilityForActivityId:activity.activityId atDate:self.dateToday];
}

@end
