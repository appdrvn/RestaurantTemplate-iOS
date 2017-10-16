//
//  MoreDetailAddressTableViewCell.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "MoreDetailAddressTableViewCell.h"

@interface MoreDetailAddressTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation MoreDetailAddressTableViewCell

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.addressLabel.backgroundColor = [UIColor clearColor];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.addressLabel.preferredMaxLayoutWidth = screenRect.size.width - 15 - 53;
}

- (void) updateDisplay:(NSString *)address
{
    self.addressLabel.text = [NSString stringWithFormat:@"%@", address];
}

@end
