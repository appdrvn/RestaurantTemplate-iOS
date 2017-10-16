//
//  MenuLeftSideTableViewCell.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "MenuLeftSideTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AppConstants.h"

@interface MenuLeftSideTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *ingredientLabel;

@end

@implementation MenuLeftSideTableViewCell

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.thumbnailImageView.layer.cornerRadius = 10.0f;
    self.thumbnailImageView.layer.masksToBounds = YES;
    
    self.itemNameLabel.backgroundColor = [UIColor clearColor];
    self.priceLabel.backgroundColor = [UIColor clearColor];
    self.ingredientLabel.backgroundColor = [UIColor clearColor];
    
    self.priceLabel.textColor = [UIColor appthemeColor];
}

- (void) updateDisplay:(MenuModel *)model
{
    [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.thumbnailUrl]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    self.itemNameLabel.text = [NSString stringWithFormat:@"%@", model.title];
    self.priceLabel.text = [NSString stringWithFormat:@"$ %.2f", model.price];
    self.ingredientLabel.text = [NSString stringWithFormat:@"%@", model.ingredient];
}

@end
