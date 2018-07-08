//
//  ViewController.m
//  RecipeApp
//
//  Created by Petar on 8.07.18.
//  Copyright © 2018 Petar. All rights reserved.
//

#import "HomeViewController.h"
#import "SHAPIClient+Meals.h"
#import <UIImageView+AFNetworking.h>
#import "Meal.h"
#import "MealCell.h"
#import "Ingredient.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [SHAPIClient getLatestMeals:^(SHAPIResponse *response) {
        self.meals = [NSMutableArray new];
        
        [response.body[@"meals"] enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Meal* myNewMeal = [Meal initMealWithDict:obj];
            [self.meals addObject:myNewMeal];
            
        }];
        
        //Reload data
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(self.isSearching) {
        return self.searchedMeals.count;
    }
    else {
        return self.meals.count;
    }
}

//default size for all devices

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    float width = self.collectionView.frame.size.width / 2 - 5;
    
    return CGSizeMake(width, width+20);
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MealCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"MealCell" forIndexPath:indexPath];
    
    Meal* currentMeal;
    if(self.isSearching) {
        currentMeal = self.searchedMeals[indexPath.row];
    }
    else {
        currentMeal = self.meals[indexPath.row];
    }
    
    [cell.mealImageView setImageWithURL:[NSURL URLWithString:currentMeal.mealImageURL]];
    cell.mealNameLabel.text = currentMeal.mealName;
    
    
    return cell;
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if(searchText.length > 0) {
        self.isSearching = YES;
    }
    else {
        self.isSearching = NO;
    }
    
    [SHAPIClient searchMealWithText:searchText success:^(SHAPIResponse *response) {
        self.searchedMeals = [NSMutableArray new];
        
        [response.body[@"meals"] enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Meal* myNewMeal = [Meal initMealWithDict:obj];
            [self.searchedMeals addObject:myNewMeal];
            
        }];
        
        //Reload data
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
@end
