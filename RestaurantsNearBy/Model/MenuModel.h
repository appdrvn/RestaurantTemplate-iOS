//
//  MenuModel.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuModel : NSObject

@property (nonatomic, strong) NSString *thumbnailUrl;
@property (nonatomic) double price;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *ingredient;

@end
