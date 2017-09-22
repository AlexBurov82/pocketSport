//
//  ABServerManager.h
//  Erpico
//
//  Created by Александр on 29.07.16.
//  Copyright © 2016 Alex Bukharov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AccessToken;
@class Authentication;


typedef void(^ABLoginCompletionBlock)(AccessToken *token);

@interface ServerManager : NSObject

+ (ServerManager *)shareManager;

- (id)initWithCompletionBlock:(ABLoginCompletionBlock)completionBlock;


- (void)requestCode:(NSString *)phoneNumber
          onSuccess:(void(^)(NSInteger result))success
          onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void)verifyCode:(NSString *)code forPhoneNumber:(NSString *)phoneNumber
         onSuccess:(void(^)(AccessToken *accessToken))success
         onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void)authenticate:(AccessToken *)token
           onSuccess:(void(^)(Authentication *auth))success
           onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void)updateUsrOfData:(Authentication *)auth
              onSuccess:(void(^)(NSInteger result))success
              onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void)getScheduleForDate:(NSDate *)date
                 onSuccess:(void(^)(NSArray *schedule))success
                 onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void)getScheduleRecordsOnSuccess:(void(^)(NSArray *records))success
                          onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void)logoutOnSuccess:(void(^)(NSInteger result))success
              onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void)getAvailabilityForActivityId:(NSInteger)activityId atDate:(NSDate *)date
                              onSuccess:(void(^)(NSArray *records))success
                              onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;




@end
