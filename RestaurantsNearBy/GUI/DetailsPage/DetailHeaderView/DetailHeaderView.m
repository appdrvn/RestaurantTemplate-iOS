//
//  DetailHeaderView.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "DetailHeaderView.h"
#import "AppConstants.h"
#import "LCBannerView.h"

@interface DetailHeaderView()<LCBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bannerBgView;
@property (nonatomic, strong) UIView *gradientBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerViewHeightConstraint;

@end

@implementation DetailHeaderView

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
    
    self.bannerBgView.backgroundColor = [UIColor whiteColor];
}

- (void) updateDisplay:(RestaurantModel *)model
{
    if ([model.imagesUrl count] > 0)
    {
        self.bannerViewHeightConstraint.constant = BANNER_VIEW_HEIGHT;
        
        LCBannerView *bannerView = [LCBannerView bannerViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, BANNER_VIEW_HEIGHT)
                                                            delegate:self
                                                           imageURLs:model.imagesUrl
                                                    placeholderImage:@"placeholder.png"
                                                       timerInterval:4.0f
                                       currentPageIndicatorTintColor:[UIColor clearColor]
                                              pageIndicatorTintColor:[UIColor clearColor]];
        bannerView.backgroundColor = [UIColor whiteColor];
        [self.bannerBgView addSubview:bannerView];
        
        // Add Shadow
        CGFloat height = 35;
        self.gradientBgView = [[UIView alloc] initWithFrame:CGRectMake(0, bannerView.frame.size.height - height, [UIScreen mainScreen].bounds.size.width, height)];
        self.gradientBgView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        [self.bannerBgView addSubview:self.gradientBgView];
        
        [self makeGradientBackground];
    }
}

#pragma mark - Make Layout Gradient Background Color
- (void) makeGradientBackground
{
    self.gradientBgView.backgroundColor = [UIColor clearColor];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.gradientBgView.frame.size.height);
    gradientLayer.startPoint = CGPointMake(0, 0.0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.locations = @[@(0.0), @(0.2), @(1.0)];
    gradientLayer.colors = @[(id)[UIColor colorWithWhite:1.0 alpha:0.0].CGColor,
                             (id)[UIColor colorWithWhite:1.0 alpha:0.4].CGColor,
                             (id)[UIColor colorWithWhite:1.0 alpha:0.9].CGColor];
    [self.gradientBgView.layer insertSublayer:gradientLayer atIndex:0];
}

#pragma mark - LCBannerView Delegate
- (void)bannerView:(LCBannerView *)bannerView didClickedImageIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(DetailHeaderViewDelegateDidSelectedAtIndex:)])
    {
        [self.delegate DetailHeaderViewDelegateDidSelectedAtIndex:(int)index];
    }
}

@end
