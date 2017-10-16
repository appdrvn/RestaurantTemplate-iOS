//
//  ListPageViewController.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import "RestaurantModel.h"

@interface ListPageViewController : BaseCollectionViewController

@property id delegate;

@end

@protocol ListPageViewControllerDelegate <NSObject>

- (void) ListPageViewControllerDelegateDidSelectedRestaurantModel:(RestaurantModel *)model;
- (void) ListPageViewControllerDelegateDidDraggingScroll;

@end