//
//  RestaurantModel.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoordinateModel.h"
#import "AddressModel.h"

@interface RestaurantModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *imagesUrl;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic) NSInteger reviewsCount;
@property (nonatomic) NSInteger rating; // Cannot more than 5
@property (nonatomic, strong) AddressModel *address;
@property (nonatomic, strong) NSArray *menus; // Menu Model
@property (nonatomic) BOOL isLike;
@property (nonatomic, strong) NSString *detailsHtml;
@property (nonatomic, strong) CoordinateModel *coordinate;

@end
