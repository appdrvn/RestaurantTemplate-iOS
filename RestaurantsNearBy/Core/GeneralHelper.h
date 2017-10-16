//
//  GeneralHelper.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//
 
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GeneralHelper : NSObject

#pragma mark - Suffix Number
+ (NSString *)suffixNumber:(NSNumber *)number;

#pragma mark - Open to Waze with passing destination coordinate
+ (void) navigateToLatitude:(double)latitude longitude:(double)longitude;

#pragma mark - Open to Google Map with passing destination coordinate
+ (void) navigateToGoogleMapWithLatitude:(double)latitude longitude:(double)longitude;

#pragma mark - Open Safari
+ (void) openBrowserInUrl:(NSString *)urlString;

#pragma mark - Show Alert Message
+ (void)showAlertMsg:(NSString *)msg;

@end
