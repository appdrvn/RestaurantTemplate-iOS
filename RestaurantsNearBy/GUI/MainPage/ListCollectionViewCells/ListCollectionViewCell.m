//
//  ListCollectionViewCell.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "ListCollectionViewCell.h"
#import "TPFloatRatingView.h"
#import "UIImageView+WebCache.h"
#import "GeneralHelper.h"

@interface ListCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet TPFloatRatingView *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *reviewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation ListCollectionViewCell

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.thumbnailImageView.layer.cornerRadius = 10.0f;
    self.thumbnailImageView.layer.masksToBounds = YES;
    
    self.reviewsLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.distanceLabel.backgroundColor = [UIColor clearColor];
}

- (void) updateDisplay:(RestaurantModel *)model
{
    NSString *thumbnailUrl = @"";
    if ([model.imagesUrl count] > 0)
    {
        thumbnailUrl = [model.imagesUrl objectAtIndex:0];
    }
    [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", thumbnailUrl]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]]; // You may put image placeholder here
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@", model.name];
    self.distanceLabel.text = [NSString stringWithFormat:@"%@", model.distance];
    
    // Rating View
    self.ratingView.emptySelectedImage = [UIImage imageNamed:@"unfavourite_icon.png"];
    self.ratingView.fullSelectedImage = [UIImage imageNamed:@"favourite_icon.png"];
    self.ratingView.contentMode = UIViewContentModeScaleAspectFit;
    self.ratingView.maxRating = 5;
    self.ratingView.minRating = 1;
    self.ratingView.rating = model.rating;
    self.ratingView.editable = NO;
    self.ratingView.halfRatings = NO;
    self.ratingView.floatRatings = NO;
    self.ratingView.backgroundColor = [UIColor clearColor];
    
    // Reviews Count
    self.reviewsLabel.text = [NSString stringWithFormat:@"(%@)", [GeneralHelper suffixNumber:[NSNumber numberWithInteger:model.reviewsCount]]];
}

@end
