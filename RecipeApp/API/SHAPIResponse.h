//
//  SHAPIResponse.h
//  ShopO Circle
//
//  Created by Viktor Todorov on 3/6/17.
//  Copyright © 2017 ShopO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHAPIResponse : NSObject
@property (nonatomic) NSInteger code;
@property (nonatomic) id body;
+(instancetype) apiResponseWithTask:(NSURLSessionDataTask *) task andResponseObject: (id) responseObject;
@end
