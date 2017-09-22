//
//  Activity.m
//  pocketSport
//
//  Created by Александр on 29.01.17.
//
//

#import "Activity.h"

@implementation Activity


- (id)initWithServerResponse:(NSDictionary *)responseObject {
    
    self = [super initWithServerResponse:responseObject];
    if (self) {
        
        BOOL startTime = [[responseObject objectForKey:@"starttime"]boolValue];
        
        if (startTime != 0) {
            self.startTime = [responseObject objectForKey:@"starttime"];
        }
        
        BOOL endTime = [[responseObject objectForKey:@"endtime"]boolValue];;
        
        if (endTime != 0) {
            self.endTime = [responseObject objectForKey:@"endtime"];
        }
        
        id activityId = [responseObject objectForKey:@"activity_id"];
        
        if (![activityId isKindOfClass:[NSNull class]]) {
            self.activityId = [[responseObject objectForKey:@"activity_id"]integerValue];
        }
        
        id activityName = [responseObject objectForKey:@"activityname"];
        
        if (![activityName isKindOfClass:[NSNull class]]) {
            self.activityName = [responseObject objectForKey:@"activityname"];
        }
        
        self.maxCount = [[responseObject objectForKey:@"maxcount"]integerValue];
        
        id registeredCount = [responseObject objectForKey:@"registered_count"];
        
        if (![registeredCount isKindOfClass:[NSNull class]]) {
            self.registeredCount = [[responseObject objectForKey:@"registered_count"]integerValue];
        }
        
        self.activityDate = [responseObject objectForKey:@"activitydate"];
    }
    
    return self;
}


@end
