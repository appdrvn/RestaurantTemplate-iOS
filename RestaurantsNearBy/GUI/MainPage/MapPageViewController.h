//
//  MapPageViewController.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "BaseViewController.h"
#import "RestaurantModel.h"

@interface MapPageViewController : BaseViewController

@property id delegate;

@end

@protocol MapPageViewControllerDelegate <NSObject>

- (void) MapPageViewControllerDelegateDidSelectedRestaurantModel:(RestaurantModel *)model;

@end