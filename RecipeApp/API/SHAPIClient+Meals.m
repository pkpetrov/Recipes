//
//  SHAPIClient+Meals.m
//  RecipeApp
//
//  Created by Petar on 8.07.18.
//  Copyright © 2018 Petar. All rights reserved.
//

#import "SHAPIClient+Meals.h"

@implementation SHAPIClient (Meals)
+(SHAPIClient *)getLatestMeals:(void (^)(SHAPIResponse *response))success failure:(void (^)(NSError *error))failure {
    
    SHAPIClient* client = [SHAPIClient POST:@"latest.php" params:nil success:success failure:failure];
    return client;
    
}
+(SHAPIClient *)getMealDetails:(NSString*)mealID success:(void (^)(SHAPIResponse *response))success failure:(void (^)(NSError *error))failure {
    
    NSString* path = [NSString stringWithFormat:@"lookup.php?i=%@",mealID];
    
    SHAPIClient* client = [SHAPIClient POST:path params:nil success:success failure:failure];
    return client;
    
}
+(SHAPIClient *)searchMealWithText:(NSString*)text success:(void (^)(SHAPIResponse *response))success failure:(void (^)(NSError *error))failure {
    
    NSString* path = [NSString stringWithFormat:@"search.php?s=%@",text];
    NSString * pathSpaced = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];

    SHAPIClient* client = [SHAPIClient POST:pathSpaced params:nil success:success failure:failure];
    return client;
    
}
@end
