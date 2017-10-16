//
//  AddressModel.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

@property (nonatomic, strong) NSString *lineOne;
@property (nonatomic, strong) NSString *lineTwo;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *postCode;

+ (NSString *)getFullAddress:(AddressModel *)model;

@end
