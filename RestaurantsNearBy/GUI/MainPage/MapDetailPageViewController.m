//
//  MapDetailPageViewController.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "MapDetailPageViewController.h"
#import "TPFloatRatingView.h"
#import "UIImageView+WebCache.h"

@interface MapDetailPageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *addressButton;
@property (weak, nonatomic) IBOutlet TPFloatRatingView *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *totalReviewsLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewMoreButton;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (nonatomic, strong) UIView *gradientBgView;

@end

@implementation MapDetailPageViewController

- (void) layoutSetup
{
    [self.addressButton setBackgroundColor:[UIColor clearColor]];
    
    self.restaurantNameLabel.backgroundColor = [UIColor clearColor];
    self.ratingView.backgroundColor = [UIColor clearColor];
    self.totalReviewsLabel.backgroundColor = [UIColor clearColor];
    self.distanceLabel.backgroundColor = [UIColor clearColor];
    self.detailView.backgroundColor = [UIColor whiteColor];
    self.detailView.layer.cornerRadius = 10.0f;
    self.detailView.layer.masksToBounds = YES;
    
    self.viewMoreButton.layer.cornerRadius = self.viewMoreButton.frame.size.height/2;
    self.viewMoreButton.layer.masksToBounds = YES;
    
    // UIButtons - Set Shadow
    UIBezierPath *buttonShadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.viewMoreButton.frame.size.width, self.viewMoreButton.frame.size.height)];
    self.viewMoreButton.layer.masksToBounds = NO;
    self.viewMoreButton.layer.shadowColor = [UIColor shadowColor].CGColor;
    self.viewMoreButton.layer.shadowOffset = CGSizeMake(0.0f, 0.5f);
    self.viewMoreButton.layer.shadowOpacity = 0.3f;
    self.viewMoreButton.layer.shadowPath = buttonShadowPath.CGPath;
    self.viewMoreButton.layer.shadowRadius = self.viewMoreButton.frame.size.height/2;
    
    // Add Shadow
    CGFloat height = 35;
    self.gradientBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.thumbnailImageView.frame.size.height - height, [UIScreen mainScreen].bounds.size.width, height)];
    self.gradientBgView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    [self.thumbnailImageView addSubview:self.gradientBgView];
    [self makeGradientBackground];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    [self layoutSetup];
}

- (void) refreshView
{
    NSString *thumbnailUrl = @"";
    if ([self.restaurantModel.imagesUrl count] > 0)
    {
        thumbnailUrl = [self.restaurantModel.imagesUrl objectAtIndex:0];
    }
    [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", thumbnailUrl]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]]; // You may put image placeholder here
    
    self.restaurantNameLabel.text = [NSString stringWithFormat:@"%@", self.restaurantModel.name];
    self.distanceLabel.text = [NSString stringWithFormat:@"%@", self.restaurantModel.distance];
    
    NSMutableAttributedString* addressString = [[NSMutableAttributedString alloc] initWithString:[AddressModel getFullAddress:self.restaurantModel.address]];
    
    // workaround for bug in UIButton - first char needs to be underlined for some reason!
    [addressString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,1}];
    [addressString addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithRed:6.0f/255.0f green:69.0f/255.0f blue:173.0f/255.0f alpha:1.0] range:NSMakeRange(0, 1)];
    
    [addressString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0, [addressString length]}];
    
    [self.addressButton setAttributedTitle:addressString forState:UIControlStateNormal];
    self.addressButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    // Rating View
    self.ratingView.emptySelectedImage = [UIImage imageNamed:@"unfavourite_icon.png"];
    self.ratingView.fullSelectedImage = [UIImage imageNamed:@"favourite_icon.png"];
    self.ratingView.contentMode = UIViewContentModeScaleAspectFit;
    self.ratingView.maxRating = 5;
    self.ratingView.minRating = 1;
    self.ratingView.rating = self.restaurantModel.rating;
    self.ratingView.editable = NO;
    self.ratingView.halfRatings = NO;
    self.ratingView.floatRatings = NO;
    self.ratingView.backgroundColor = [UIColor clearColor];
    
    // Reviews Count
    self.totalReviewsLabel.text = [NSString stringWithFormat:@"%@ Review(s)", [GeneralHelper suffixNumber:[NSNumber numberWithInteger:self.restaurantModel.reviewsCount]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIButtons Actions
- (IBAction)viewMorePressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(MapDetailPageViewControllerDelegateDidClickViewMore:)])
        {
            [self.delegate MapDetailPageViewControllerDelegateDidClickViewMore:self.restaurantModel];
        }
    }];
}

- (IBAction)dismissPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addressPressed:(id)sender
{
    [self openNaviTo:self.restaurantModel];
}

@end
