//
//  AddressModel.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

+ (NSString *)getFullAddress:(AddressModel *)model
{
    NSString *fullAddress = @"";
    
    // Address Line 1
    if ([model.lineOne length] != 0 && ![model.lineOne isEqualToString:@"(null)"])
    {
        fullAddress = [NSString stringWithFormat:@"%@", model.lineOne];
    }
    // Address Line 2 (Opitonal)
    if ([model.lineTwo length] != 0 && ![model.lineTwo isEqualToString:@"(null)"])
    {
        fullAddress = [NSString stringWithFormat:@"%@, %@", fullAddress, model.lineTwo];
    }
    // City (Opitonal)
    if ([model.city length] != 0 && ![model.city isEqualToString:@"(null)"])
    {
        fullAddress = [NSString stringWithFormat:@"%@, %@", fullAddress, model.city];
    }
    // State (Opitonal)
    if ([model.state length] != 0 && ![model.state isEqualToString:@"(null)"])
    {
        fullAddress = [NSString stringWithFormat:@"%@, %@", fullAddress, model.state];
    }
    // Postal Code (Opitonal)
    if ([model.postCode length] != 0 && ![model.postCode isEqualToString:@"(null)"])
    {
        fullAddress = [NSString stringWithFormat:@"%@, %@", fullAddress, model.postCode];
    }
    // Country
    if ([model.country length] != 0 && ![model.country isEqualToString:@"(null)"])
    {
        fullAddress = [NSString stringWithFormat:@"%@, %@", fullAddress, model.country];
    }
    
    return fullAddress;
}

@end
