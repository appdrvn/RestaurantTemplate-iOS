//
//  BaseViewController.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import "GeneralHelper.h"
#import "RestaurantModel.h"

@interface BaseViewController : UIViewController

- (void) openNaviTo:(RestaurantModel *)restaurantModel;

@end
