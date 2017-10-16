//
//  LandingPageViewController.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "LandingPageViewController.h"
#import "AppDelegate.h"

@interface LandingPageViewController ()

@property (weak, nonatomic) IBOutlet UIView *gradientBgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *discoverNowButton;

@end

@implementation LandingPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self makeGradientBackground];
    
    // Set Title
    self.titleLabel.text = @"RESTAURANTS TEMPLATE";
    
    // Set Discover Now Button
    [self.discoverNowButton setTitle:@"DISCOVER NOW" forState:UIControlStateNormal];
    [self.discoverNowButton setBackgroundColor:[UIColor appthemeColor]];
    self.discoverNowButton.layer.cornerRadius = self.discoverNowButton.frame.size.height/2;
    self.discoverNowButton.layer.masksToBounds = YES;
    
    // UIButtons - Set Shadow
    UIBezierPath *buttonShadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.discoverNowButton.frame.size.width, self.discoverNowButton.frame.size.height)];
    self.discoverNowButton.layer.masksToBounds = NO;
    self.discoverNowButton.layer.shadowColor = [UIColor shadowColor].CGColor;
    self.discoverNowButton.layer.shadowOffset = CGSizeMake(0.0f, 0.5f);
    self.discoverNowButton.layer.shadowOpacity = 0.3f;
    self.discoverNowButton.layer.shadowPath = buttonShadowPath.CGPath;
    self.discoverNowButton.layer.shadowRadius = self.discoverNowButton.frame.size.height/2;
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIButtons Actions
- (IBAction)discoverNowPressed:(id)sender
{
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [UIView transitionWithView:appDelegate.window duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void)
     {
         BOOL oldState = [UIView areAnimationsEnabled];
         [UIView setAnimationsEnabled:NO];
         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
         UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"MainPageView"];
         [appDelegate.window addSubview:navigationController.view];
         [appDelegate.window setRootViewController:navigationController];
         [appDelegate.window makeKeyAndVisible];
         
         [UIView setAnimationsEnabled:oldState];
         
     }completion:nil];
}

#pragma mark - Make Layout Gradient Background Color
- (void) makeGradientBackground
{
    self.gradientBgView.backgroundColor = [UIColor clearColor];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.gradientBgView.frame.size.height);
    gradientLayer.startPoint = CGPointMake(0 ,0.0);
    gradientLayer.endPoint = CGPointMake(0 ,1.0);
    gradientLayer.locations = @[@(0.0), @(0.2), @(1.0)];
    gradientLayer.colors = @[(id)[UIColor colorWithWhite:1.0 alpha:0.0].CGColor,
                             (id)[UIColor colorWithWhite:1.0 alpha:0.5].CGColor,
                             (id)[UIColor colorWithWhite:1.0 alpha:0.9].CGColor];
    [self.gradientBgView.layer insertSublayer:gradientLayer atIndex:0];
}

@end
