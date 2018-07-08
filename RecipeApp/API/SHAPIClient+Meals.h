//
//  SHAPIClient+Meals.h
//  RecipeApp
//
//  Created by Petar on 8.07.18.
//  Copyright © 2018 Petar. All rights reserved.
//

#import "SHAPIClient.h"

@interface SHAPIClient (Meals)
+(SHAPIClient *)getLatestMeals:(void (^)(SHAPIResponse *response))success failure:(void (^)(NSError *error))failure;
+(SHAPIClient *)getMealDetails:(NSString*)mealID success:(void (^)(SHAPIResponse *response))success failure:(void (^)(NSError *error))failure;
@end
