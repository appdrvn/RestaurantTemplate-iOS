//
//  MenuLeftSideTableViewCell.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"

@interface MenuLeftSideTableViewCell : UITableViewCell

- (void) updateDisplay:(MenuModel *)model;

@end
