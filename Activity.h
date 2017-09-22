//
//  Activity.h
//  pocketSport
//
//  Created by Александр on 29.01.17.
//
//

#import "ServerObject.h"

@interface Activity : ServerObject


@property (strong, nonatomic) NSString *startTime;
@property (strong, nonatomic) NSString *endTime;
@property (assign, nonatomic) NSInteger activityId;
@property (strong, nonatomic) NSString *activityName;
@property (assign, nonatomic) NSInteger maxCount;
@property (assign, nonatomic) NSInteger registeredCount;
@property (strong, nonatomic) NSString *activityDate;

- (id)initWithServerResponse:(NSDictionary *)responseObject;

@end


