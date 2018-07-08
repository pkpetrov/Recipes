//
//  SHAPIClient+UploadImage.h
//  ShopO Circle
//
//  Created by Azarnikov Vadim on 3/20/17.
//  Copyright © 2017 ShopO. All rights reserved.
//

#import "SHAPIClient.h"

@interface SHAPIClient (UploadImage)

+(SHAPIClient *)uploadImageData:(NSData*)imageData filename:(NSString *)filename successHandler:(void (^)(NSString *url))success failure:(void (^)(NSError *error))failure;
@end
