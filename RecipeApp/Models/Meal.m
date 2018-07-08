//
//  Meal.m
//  RecipeApp
//
//  Created by Petar on 8.07.18.
//  Copyright © 2018 Petar. All rights reserved.
//

#import "Meal.h"

@implementation Meal
+(instancetype)initMealWithDict:(NSDictionary*)dict {
    if(!dict) {
        return nil;
    }
    
    Meal* currentMeal = [Meal new];
    
    if(dict[@"idMeal"]) {
        currentMeal.mealID = dict[@"idMeal"];
    }
    if(dict[@"strArea"]) {
        currentMeal.mealArea = dict[@"strArea"];
    }
    if(dict[@"strCategory"]) {
        currentMeal.mealCategory = dict[@"strCategory"];
    }
    if(dict[@"strInstructions"]) {
        currentMeal.mealInstructions = dict[@"strInstructions"];
    }
    if(dict[@"strMeal"]) {
        currentMeal.mealName = dict[@"strMeal"];
    }
    if(dict[@"strMealThumb"]) {
        currentMeal.mealImageURL = dict[@"strMealThumb"];
    }
    if(dict[@"strSource"]) {
        currentMeal.mealSourceURL = dict[@"strSource"];
    }
    if(dict[@"strYoutube"]) {
        currentMeal.mealYoutubeURL = dict[@"strYoutube"];
    }
    
    if(dict[@"strIngredient1"]) {
        currentMeal.ingredients = [NSMutableArray new];
        for (int i = 1; i <= 20; i++) {
            NSString* keyPathIngredient = [NSString stringWithFormat:@"strIngredient%i",i];
            NSString* keyPathMeasure = [NSString stringWithFormat:@"strMeasure%i",i];
            Ingredient* currentIngredient = [Ingredient new];
            
            if(dict[keyPathIngredient] && [dict[keyPathIngredient] isKindOfClass:[NSString class]] && [dict[keyPathIngredient] length] > 0) {
                currentIngredient.name = dict[keyPathIngredient];
            }
            
            if(dict[keyPathMeasure] && [dict[keyPathMeasure] isKindOfClass:[NSString class]] && [dict[keyPathMeasure] length] > 0) {
                currentIngredient.measure = dict[keyPathMeasure];
            }
            
            
            if(currentIngredient.name.length > 0) {
                [currentMeal.ingredients addObject:currentIngredient];
            }
            
        }
    }
    
    return currentMeal;
}
@end
