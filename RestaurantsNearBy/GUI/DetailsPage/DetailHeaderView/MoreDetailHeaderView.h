//
//  MoreDetailHeaderView.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantModel.h"

@interface MoreDetailHeaderView : UIView

@property id delegate;
@property (strong, nonatomic) IBOutlet UIView *view;
- (void) updateDisplay:(RestaurantModel *)model;

@end

@protocol MoreDetailHeaderViewDelegate <NSObject>

- (void) MoreDetailHeaderViewDelegateUpdateHeight:(CGFloat)height;

@end