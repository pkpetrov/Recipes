//
//  MealCell.m
//  RecipeApp
//
//  Created by Petar on 8.07.18.
//  Copyright © 2018 Petar. All rights reserved.
//

#import "MealCell.h"

@implementation MealCell
-(void)prepareForReuse {
    self.mealImageView.image = nil;
}
@end
