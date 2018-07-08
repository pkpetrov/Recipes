//
//  Meal.h
//  RecipeApp
//
//  Created by Petar on 8.07.18.
//  Copyright © 2018 Petar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ingredient.h"

@interface Meal : NSObject
@property (nonatomic, strong) NSString* mealID;
@property (nonatomic, strong) NSString* mealArea;
@property (nonatomic, strong) NSString* mealCategory;
@property (nonatomic, strong) NSString* mealInstructions;
@property (nonatomic, strong) NSString* mealName;
@property (nonatomic, strong) NSString* mealImageURL;
@property (nonatomic, strong) NSString* mealSourceURL;
@property (nonatomic, strong) NSString* mealYoutubeURL;
@property (nonatomic, strong) NSMutableArray* ingredients;
+(instancetype)initMealWithDict:(NSDictionary*)dict;
@end
