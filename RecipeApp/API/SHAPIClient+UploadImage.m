//
//  SHAPIClient+UploadImage.m
//  ShopO Circle
//
//  Created by Azarnikov Vadim on 3/20/17.
//  Copyright © 2017 ShopO. All rights reserved.
//

#import "SHAPIClient+UploadImage.h"
#import <AFNetworking/AFNetworking.h>

@implementation SHAPIClient (UploadImage)

+(SHAPIClient *)uploadImageData:(NSData*)imageData filename:(NSString *)filename successHandler:(void (^)(NSString *url))success failure:(void (^)(NSError *error))failure{
    SHAPIClient *client = [SHAPIClient new];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[self apiURLAppendWithPath:@"image_store"] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(imageData && filename){
            [formData appendPartWithFileData:imageData name:@"file" fileName:filename mimeType:@"image/jpeg"];
        }
    } error:nil];
    
    AFURLSessionManager *manager = [SHAPIClient manager];
    
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
                          if([responseObject isKindOfClass:[NSDictionary class]]){
                              if(responseObject[@"url"]&&[responseObject[@"url"] isKindOfClass:[NSString class]]){
                                  success(responseObject[@"url"]);
                              }else{
                                  failure(nil);
                              }
                          }else{
                              failure(nil);
                          }
                      }
                  }];
    
    [uploadTask resume];
    
    client.dataTask = uploadTask;
    
    return client;
}

@end
/*
 
 + (SHAPIClient *)PUT:(NSString*)path data:(NSData*)data filename:(NSString*)filename params:(NSDictionary *)params success:(void (^)(SHAPIResponse *response))success failure:(void (^)(NSError *error))failure {
 
 SHAPIClient *client = [SHAPIClient new];
 
 NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"PUT" URLString:[self apiURLAppendWithPath:path] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
 if(filename && data){
 [formData appendPartWithFileData:data name:@"file" fileName:filename mimeType:@"image/jpg"];
 }
 } error:nil];
 
 AFURLSessionManager *manager = [self manager];
 
 NSString *token = [[SHUserToken sharedInstance] authorizedUser].token;
 [request setValue:token forHTTPHeaderField:@"Authorization"];
 
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
 */
