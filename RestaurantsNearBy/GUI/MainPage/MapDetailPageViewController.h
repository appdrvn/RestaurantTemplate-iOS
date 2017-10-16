//
//  MapDetailPageViewController.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "BaseViewController.h"
#import "RestaurantModel.h"

@interface MapDetailPageViewController : BaseViewController

@property id delegate;
@property (nonatomic, strong) RestaurantModel *restaurantModel;
- (void) refreshView;

@end

@protocol MapDetailPageViewControllerDelegate <NSObject>

- (void) MapDetailPageViewControllerDelegateDidClickViewMore:(RestaurantModel *)model;

@end