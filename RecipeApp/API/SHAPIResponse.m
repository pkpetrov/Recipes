//
//  SHAPIResponse.m
//  ShopO Circle
//
//  Created by Viktor Todorov on 3/6/17.
//  Copyright © 2017 ShopO. All rights reserved.
//

#import "SHAPIResponse.h"

@implementation SHAPIResponse
+(instancetype) apiResponseWithTask:(NSURLSessionDataTask *) task andResponseObject: (id) responseObject{
    
    SHAPIResponse *response = [[SHAPIResponse alloc] init];
    
    if([task.response isKindOfClass:[NSHTTPURLResponse class]]){
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)task.response;
        response.code = httpResponse.statusCode;
    }else{
        response.code = -1;
    }
    
    if(!responseObject){
        response.body = nil;
        return response;
    }
    
    if([responseObject isKindOfClass:[NSDictionary class]]) {
        response.body = responseObject;
    }else if([responseObject isKindOfClass:[NSArray class]]){
        response.body = responseObject;
    } else {
        NSError *error;
        response.body = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        if(error){
            response.body = nil;
        }
    }
    
    return response;
}

@end
