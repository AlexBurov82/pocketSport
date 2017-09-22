//
//  Record.m
//  pocketSport
//
//  Created by Александр on 30.01.17.
//
//

#import "Record.h"

@implementation Record

- (id)initWithServerResponse:(NSDictionary *)responseObject {
    
    self = [super initWithServerResponse:responseObject];
    if (self) {
        
//        self.startTime = [responseObject objectForKey:@"starttime"];
//        
//        self.endTime = [responseObject objectForKey:@"endtime"];
//        
//        self.activityId = [[responseObject objectForKey:@"id"]integerValue];
//        
//        self.activityName = [responseObject objectForKey:@"activityname"];
//        
//        self.maxCount = [[responseObject objectForKey:@"maxcount"]integerValue];
//        
//        self.registeredCount = [[responseObject objectForKey:@"registered_count"]integerValue];
//        self.activityDate = [responseObject objectForKey:@"activitydate"];
    }
    
    return self;
}

@end
