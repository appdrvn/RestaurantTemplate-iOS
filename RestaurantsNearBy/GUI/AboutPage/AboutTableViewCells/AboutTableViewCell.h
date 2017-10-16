//
//  AboutTableViewCell.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutUIModel.h"

@interface AboutTableViewCell : UITableViewCell

- (void) updateDisplay:(AboutUIModel *)model;

@end