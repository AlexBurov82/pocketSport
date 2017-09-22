//
//  ABServerManager.m
//  Erpico
//
//  Created by Александр on 29.07.16.
//  Copyright © 2016 Alex Bukharov. All rights reserved.
//

#import "ServerManager.h"
#import <AFNetworking.h>
#import "AccessToken.h"
#import "Authentication.h"
#import "Activity.h"
#import "Record.h"


@interface ServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@property (strong, nonatomic) AccessToken *accessToken;
@property (copy, nonatomic) ABLoginCompletionBlock completionBlock;


@end

@implementation ServerManager


static NSString *urlString = @"http://levelup76.ru";

static NSString *urlPaymentGateway = @"https://pay.erpico.ru";

+ (ServerManager *)shareManager {
    
    static ServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc] init];
    });
    return manager;
}


- (id)initWithCompletionBlock:(ABLoginCompletionBlock)completionBlock {
    
    self = [super init];
    
    if (self) {
        
        self.completionBlock = completionBlock;
    }
    return self;
}


- (void)requestCode:(NSString *)phoneNumber
                    onSuccess:(void(^)(NSInteger result))success
                    onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSString *url = [NSString stringWithFormat:@"http://levelup76.ru/auth/getcode?phone=%@", phoneNumber];
    
    NSString* webStringURL = [url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    [manager GET:webStringURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        NSInteger result = [[responseObject objectForKey:@"result"]integerValue];
        
        if (success) {
            success(result);
        }

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if (failure) {
            failure(error, operation.taskIdentifier);
            
        }
    }];
}

- (void)verifyCode:(NSString *)code forPhoneNumber:(NSString *)phoneNumber
          onSuccess:(void(^)(AccessToken *accessToken))success
          onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    self.accessToken = [[AccessToken alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"http://levelup76.ru/auth/login?phone=%@&code=%@", phoneNumber, code];
    
    NSString* webStringURL = [url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:webStringURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        self.accessToken.token = [responseObject objectForKey:@"token"];
        
        if (success) {
            success(self.accessToken);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if (failure) {
            failure(error, operation.taskIdentifier);
        }
    }];
}

- (void)authenticate:(AccessToken *)accessToken
         onSuccess:(void(^)(Authentication *auth))success
         onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDictionary *params = @{@"token" : accessToken.token};
    
    NSString *url = [NSString stringWithFormat:@"http://levelup76.ru/auth/info"];
    
    NSString* webStringURL = [url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:webStringURL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        
        
        Authentication *auth = [[Authentication alloc] initWithServerResponse:responseObject];
        
//        NSInteger errorCode = [[responseObject objectForKey:@"error"] integerValue];
//        
//        NSArray *authArray = [NSArray arrayWithObjects:auth, @(errorCode), nil];
//        
        if (success) {
            success(auth);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);

        
        if (failure) {
            failure(error, operation.taskIdentifier);
            
        }
    }];
}

- (void)updateUsrOfData:(Authentication *)auth
           onSuccess:(void(^)(NSInteger result))success
           onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDictionary *params = @{@"token" : [self unarchivingToken],
                             @"name" : auth.clientName,
                             @"last_name" : auth.clientLastName,
                             @"phone" : auth.clientPhone,
                             @"email" : auth.clientEmail};
    
    NSString *url = [NSString stringWithFormat:@"http://levelup76.ru/auth/update"];
    
    NSString* webStringURL = [url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:webStringURL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        NSInteger result = [[responseObject objectForKey:@"result"]integerValue];

        if (success) {
            success(result);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if (failure) {
            failure(error, operation.taskIdentifier);
            
        }
    }];
}

#pragma mark - get Schedule

- (void)getScheduleForDate:(NSDate *)date
              onSuccess:(void(^)(NSArray *schedule))success
              onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-DD"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    NSString *url = [NSString stringWithFormat:@"http://levelup76.ru/getSchedule/%@", dateString];
    
    NSString* webStringURL = [url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:webStringURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        NSDictionary *activities = [responseObject objectForKey:dateString];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        NSArray *keys = [[activities allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            if ([obj1 intValue]==[obj2 intValue])
                return NSOrderedSame;
            
            else if ([obj1 intValue]<[obj2 intValue])
                return NSOrderedAscending;
            else
                return NSOrderedDescending;
            
        }];
        
        for (NSString *key in keys) {
            
            NSDictionary *tempDic = [activities objectForKey:key];
            
            if (tempDic) {
                Activity *activity = [[Activity alloc] initWithServerResponse:tempDic];
                
                [tempArray addObject:activity];
            }
        }
        
        NSArray *schedule = [NSArray arrayWithArray:tempArray];

        if (success) {
            success(schedule);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        if (failure) {
            failure(error, operation.taskIdentifier);
            
        }
    }];
}

#pragma mark - get Schedule Records

- (void)getScheduleRecordsOnSuccess:(void(^)(NSArray *records))success
                          onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    
    NSString *url = [NSString stringWithFormat:@"http://levelup76.ru/scheduler/records/"];
    
    NSDictionary *params = @{@"token" : [self unarchivingToken]};
    
    NSString* webStringURL = [url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:webStringURL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        NSArray *recordsArray = [responseObject objectForKey:@"records"];

        NSMutableArray *tempArray = [NSMutableArray array];

        for (int i = 0; i < [recordsArray count]; i++) {
            
            Record *activity = [[Record alloc] initWithServerResponse:recordsArray[i]];
            
            [tempArray addObject:activity];
        }
        
        NSArray *records = [NSArray arrayWithArray:tempArray];
        
        if (success) {
            success(records);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        if (failure) {
            failure(error, operation.taskIdentifier);
            
        }
    }];
}

#pragma mark - Logout

- (void)logoutOnSuccess:(void(^)(NSInteger result))success
                          onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    
    NSString *url = [NSString stringWithFormat:@"http://levelup76.ru/auth/logout"];
    
    NSDictionary *params = @{@"token" : [self unarchivingToken]};
    
    NSString* webStringURL = [url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:webStringURL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        if (failure) {
            failure(error, operation.taskIdentifier);
            
        }
    }];
}

#pragma mark - NSCoding

- (NSString *)unarchivingToken {
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *token = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return token;
}

#pragma mark - get get availability Schedule Records

- (void)getAvailabilityForActivityId:(NSInteger)activityId atDate:(NSDate *)date
                              onSuccess:(void(^)(NSArray *records))success
                              onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-DD"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    NSString *url = [NSString stringWithFormat:@"http://levelup76.ru/scheduler/getavailabilty/?activity_id=%ld&date=%@/", (long)activityId, dateString];
    
    NSDictionary *params = @{@"token" : [self unarchivingToken]};
    
    NSString* webStringURL = [url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:webStringURL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
//        NSArray *recordsArray = [responseObject objectForKey:@"records"];
//        
        NSMutableArray *tempArray = [NSMutableArray array];
//
//        for (int i = 0; i < [recordsArray count]; i++) {
//            
//            Record *activity = [[Record alloc] initWithServerResponse:recordsArray[i]];
//            
//            [tempArray addObject:activity];
//        }
        
        NSArray *records = [NSArray arrayWithArray:tempArray];
        
        if (success) {
            success(records);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        if (failure) {
            failure(error, operation.taskIdentifier);
            
        }
    }];
}



@end
