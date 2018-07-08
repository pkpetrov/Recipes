//
//  MealCell.h
//  RecipeApp
//
//  Created by Petar on 8.07.18.
//  Copyright © 2018 Petar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MealCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet UIImageView* mealImageView;
@property (nonatomic, strong) IBOutlet UILabel* mealNameLabel;
@end
