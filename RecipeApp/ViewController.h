//
//  ViewController.h
//  RecipeApp
//
//  Created by Petar on 8.07.18.
//  Copyright © 2018 Petar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView* collectionView;
@property (nonatomic, strong) IBOutlet UISearchBar* searchBar;
@property (nonatomic, strong) NSMutableArray* meals;
@property (nonatomic, strong) NSMutableArray* searchedMeals;
@property (nonatomic) BOOL isSearching;
@end

