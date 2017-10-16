//
//  BaseViewController.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self changeNavigationBarColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - Change Navigation Bar Color
- (void) changeNavigationBarColor
{
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
        // iOS 7.0 or later
        self.navigationController.navigationBar.barTintColor = [UIColor appthemeColor];
        self.navigationController.navigationBar.translucent = NO;
    }
    else
    {
        // iOS 6.1 or earlier
        self.navigationController.navigationBar.tintColor = [UIColor appthemeColor];
    }
}

- (void) openNaviTo:(RestaurantModel *)restaurantModel
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Get Direction" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Google Map" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [GeneralHelper navigateToGoogleMapWithLatitude:restaurantModel.coordinate.latitude longitude:restaurantModel.coordinate.longitude];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Waze" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [GeneralHelper navigateToLatitude:restaurantModel.coordinate.latitude longitude:restaurantModel.coordinate.longitude];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}

@end
