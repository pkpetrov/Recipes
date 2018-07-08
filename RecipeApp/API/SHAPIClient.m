//
//  SHAPIRequest.m
//  ShopO Circle
//
//  Created by Viktor Todorov on 3/6/17.
//  Copyright © 2017 ShopO. All rights reserved.
//

#import "SHAPIClient.h"
#import "NSDate+Server.h"
#import "SHAFJSONRequestSerializer.h"

@interface SHAPIClient()
@end

@implementation SHAPIClient

+ (BOOL)isCanceledError:(NSError*)error {
    return error.code == -999;
}
+ (SHAPIClient *)GET:(NSString*)path params:(NSDictionary*)params success:(void (^)(SHAPIResponse *response))success failure:(void (^)(NSError *error))failure{
    
    SHAPIClient *client = [SHAPIClient new];
    
    client.dataTask = [[self manager] GET:[self apiURLAppendWithPath:path]
                                                      parameters:params
                                                        progress:nil
                                                         success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
                                                             success([SHAPIResponse apiResponseWithTask:task andResponseObject:responseObject]);
                                                             
                                                         }
                                                         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                             if(![self isCanceledError:error]) {
                                                                 failure(error);
                                                             }
                                                         }];
    return client;
}
+ (SHAPIClient *)POST:(NSString*)path params:(NSDictionary*)params success:(void (^)(SHAPIResponse *response))success failure:(void (^)(NSError *error))failure{
    if (params == nil) {
        params = @{};
    }
    SHAPIClient *client = [SHAPIClient new];
    
    client.dataTask = [[self manager] POST:[self apiURLAppendWithPath:path]
                                                       parameters:params
                                                         progress:nil
                                                          success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
                                                              success([SHAPIResponse apiResponseWithTask:task andResponseObject:responseObject]);
                                                          }
                                                          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                              if(![self isCanceledError:error]) {
                                                                  failure(error);
                                                              }
                                                          }];
    return client;
    
}
+ (SHAPIClient *)DELETE:(NSString*)path params:(NSDictionary*)params success:(void (^)(SHAPIResponse *response))success failure:(void (^)(NSError *error))failure{
    
    SHAPIClient *client = [SHAPIClient new];
    
    client.dataTask = [[self manager] DELETE:[self apiURLAppendWithPath:path]
                                                         parameters:params
                                                            success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
                                                                success([SHAPIResponse apiResponseWithTask:task andResponseObject:responseObject]);
                                                            }
                                                            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                if(![self isCanceledError:error]) {
                                                                    failure(error);
                                                                }
                                                            }];
    return client;
    
}
+ (SHAPIClient *)PUT:(NSString*)path params:(NSDictionary*)params success:(void (^)(SHAPIResponse *response))success failure:(void (^)(NSError *error))failure{
    
    SHAPIClient *client = [SHAPIClient new];
    
    client.dataTask = [[self manager] PUT:[self apiURLAppendWithPath:path]
                                                      parameters:params
                                                         success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
                                                             success([SHAPIResponse apiResponseWithTask:task andResponseObject:responseObject]);
                                                         }
                                                         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                             if(![self isCanceledError:error]) {
                                                                 failure(error);
                                                             }
                                                         }];
    return client;
}
+ (SHAPIClient *)PUT:(NSString*)path data:(NSData*)data filename:(NSString*)filename params:(NSDictionary *)params success:(void (^)(SHAPIResponse *response))success failure:(void (^)(NSError *error))failure {
    
    SHAPIClient *client = [SHAPIClient new];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"PUT" URLString:[self apiURLAppendWithPath:path] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(filename && data){
            [formData appendPartWithFileData:data name:@"file" fileName:filename mimeType:@"image/jpg"];
        }
    } error:nil];
    
    AFURLSessionManager *manager = [self manager];
    
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          //[progressView setProgress:uploadProgress.fractionCompleted];
                          NSLog(@"Progress %f",uploadProgress.fractionCompleted);
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          failure(error);
                      } else {
                          success([SHAPIResponse apiResponseWithTask:uploadTask andResponseObject:responseObject]);
                      }
                  }];
    
    [uploadTask resume];
    
    client.dataTask = uploadTask;
    
    return client;
}
+ (AFHTTPSessionManager *)manager{
    
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });

    manager.requestSerializer = [[AFJSONRequestSerializer alloc] init];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:nil forHTTPHeaderField:@"X-Currency"];
    
    return manager;
}
+ (NSString *)apiURLAppendWithPath:(NSString*)path{
 
    NSString *url = [NSString stringWithFormat:@"%@%@",@"https://www.themealdb.com/api/json/v1/1/",path];
    return url;
}
- (void)cancel {
    if(self.dataTask){
        [self.dataTask cancel];
    }
}
+ (NSInteger)httpStatusCodeFromError:(NSError*)error{
    return [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
}

@end
