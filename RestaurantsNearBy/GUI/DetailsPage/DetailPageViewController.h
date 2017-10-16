//
//  DetailPageViewController.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "BaseTableViewController.h"
#import "RestaurantModel.h"

@interface DetailPageViewController : BaseTableViewController

@property (nonatomic, strong) RestaurantModel *restaurantModel;

@end
