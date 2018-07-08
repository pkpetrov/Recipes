//
//  SHAFJSONRequestSerializer.m
//  ShopO Circle
//
//  Created by Viktor Todorov on 27.03.18.
//  Copyright © 2018 ShopO. All rights reserved.
//

#import "SHAFJSONRequestSerializer.h"

@implementation SHAFJSONRequestSerializer
-(NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request withParameters:(id)parameters error:(NSError *__autoreleasing  _Nullable *)error {
    
    NSURLRequest* requestt = [super requestBySerializingRequest:request withParameters:parameters error:error];
    
    if(requestt.HTTPBody) {
        NSData* jsonData = requestt.HTTPBody;
        NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if(jsonString) {
            NSString* fixedString = [jsonString stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
            NSMutableURLRequest* mutableRequest = requestt.mutableCopy;
            mutableRequest.HTTPBody = [fixedString dataUsingEncoding:NSUTF8StringEncoding];
            requestt = mutableRequest;
        }
    }
    return requestt;
}
@end
