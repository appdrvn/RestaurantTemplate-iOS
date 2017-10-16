//
//  AboutHeaderView.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutHeaderView : UIView

@property id delegate;
@property (strong, nonatomic) IBOutlet UIView *view;
- (void) updateDisplay:(NSString *)content;

@end

@protocol AboutHeaderViewDelegate <NSObject>

- (void) AboutHeaderViewDelegateDidClickOnFacebookButton;
- (void) AboutHeaderViewDelegateDidClickOnMailButton;
- (void) AboutHeaderViewDelegateDidClickOnWebsiteButton;

@end