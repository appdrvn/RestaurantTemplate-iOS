//
//  DetailSectionTableViewCell.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "DetailSectionTableViewCell.h"
#import "TPFloatRatingView.h"

@interface DetailSectionTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet TPFloatRatingView *ratingView;

@end

@implementation DetailSectionTableViewCell

- (id)initWithFrame:(CGRect)rect
{
    if (self = [super initWithFrame:rect])
    {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        [self addSubview:self.view];
        
        [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view":self.view}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view":self.view}]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.addressLabel.backgroundColor = [UIColor clearColor];
}

- (void) updateDisplay:(RestaurantModel *)model
{
    self.nameLabel.text = [NSString stringWithFormat:@"%@", model.name];
    self.addressLabel.text = [NSString stringWithFormat:@"%@", [AddressModel getFullAddress:model.address]];
    
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
}

#pragma mark - UIButtons Action
- (IBAction)backButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(DetailSectionTableViewCellDelegateDidClickOnBackButton)])
    {
        [self.delegate DetailSectionTableViewCellDelegateDidClickOnBackButton];
    }
}

- (IBAction)infoPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(DetailSectionTableViewCellDelegateDidClickOnInfoButton)])
    {
        [self.delegate DetailSectionTableViewCellDelegateDidClickOnInfoButton];
    }
}
@end
