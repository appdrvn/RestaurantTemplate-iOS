//
//  ListCollectionViewCell.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantModel.h"

@interface ListCollectionViewCell : UICollectionViewCell

- (void) updateDisplay:(RestaurantModel *)model;

@end
