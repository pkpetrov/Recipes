//
//  SHAPIRequest.h
//  ShopO Circle
//
//  Created by Viktor Todorov on 3/6/17.
//  Copyright © 2017 ShopO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHAPIResponse.h"
#import <AFNetworking/AFNetworking.h>

#define SAFETY_PARAM(obj) \
(!obj)?[NSNull null]:ob

@interface SHAPIClient : NSObject

+ (SHAPIClient *)GET:(NSString*)path params:(NSDictionary*)params success:(void (^)(SHAPIResponse *response))success failure:(void (^)(NSError *error))failure;
+ (SHAPIClient *)POST:(NSString*)path params:(NSDictionary*)params success:(void (^)(SHAPIResponse *response))success failure:(void (^)(NSError *error))failure;
+ (SHAPIClient *)DELETE:(NSString*)path params:(NSDictionary*)params success:(void (^)(SHAPIResponse *response))success failure:(void (^)(NSError *error))failure;
+ (SHAPIClient *)PUT:(NSString*)path params:(NSDictionary*)params success:(void (^)(SHAPIResponse *response))success failure:(void (^)(NSError *error))failure;
+ (SHAPIClient *)PUT:(NSString*)path data:(NSData*)data filename:(NSString*)filename params:(NSDictionary *)params success:(void (^)(SHAPIResponse *response))success failure:(void (^)(NSError *error))failure;

- (void)cancel;

+ (AFHTTPSessionManager *)manager;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

+ (NSInteger)httpStatusCodeFromError:(NSError*)error;
+ (NSString *)apiURLAppendWithPath:(NSString*)path;
@end
