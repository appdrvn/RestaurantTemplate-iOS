//
//  MainPageContainerViewController.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "BaseViewController.h"
#import "RestaurantModel.h"

@interface MainPageContainerViewController : BaseViewController

@property id delegate;
- (void)swapViewControllers;

@end

@protocol MainPageContainerViewControllerDelegate <NSObject>

- (void) MainPageContainerViewControllerDelegateDidSelectedRestaurantModel:(RestaurantModel *)model;
- (void) MainPageContainerViewControllerDelegateDidSelectedRestaurantModelFromMap:(RestaurantModel *)model;
- (void) MainPageContainerViewControllerDelegateDidDraggingScroll;
@end