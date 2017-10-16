//
//  DetailSectionTableViewCell.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantModel.h"

@interface DetailSectionTableViewCell : UIView

@property id delegate;
@property (strong, nonatomic) IBOutlet UIView *view;
- (void) updateDisplay:(RestaurantModel *)model;

@end

@protocol DetailSectionTableViewCellDelegate <NSObject>

- (void) DetailSectionTableViewCellDelegateDidClickOnBackButton;
- (void) DetailSectionTableViewCellDelegateDidClickOnInfoButton;

@end
