//
//  GeneralHelper.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "GeneralHelper.h"

@implementation GeneralHelper

#pragma mark - Suffix Number
// Numbering detection
+ (NSString *)suffixNumber:(NSNumber *)number
{
    if (!number)
        return @"";
    
    long long num = [number longLongValue];
    
    int s = ( (num < 0) ? -1 : (num > 0) ? 1 : 0 );
    NSString* sign = (s == -1 ? @"-" : @"" );
    
    num = llabs(num);
    
    if (num < 1000)
        return [NSString stringWithFormat:@"%@%lld",sign,num];
    
    int exp = (int) (log10l(num) / 3.f); //log10l(1000));
    
    NSArray* units = @[@"K",@"M",@"G",@"T",@"P",@"E"];
    
    return [NSString stringWithFormat:@"%@%.1f%@",sign, (num / pow(1000, exp)), [units objectAtIndex:(exp-1)]];
}

#pragma mark - Open to Waze with passing destination coordinate
+ (void) navigateToLatitude:(double)latitude longitude:(double)longitude
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"waze://"]])
    {
        // Waze is installed. Launch Waze and start navigation
        NSString *urlStr = [NSString stringWithFormat:@"waze://?ll=%f,%f&navigate=yes", latitude, longitude];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }
    else
    {
        // Waze is not installed. Launch AppStore to install Waze app
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/id323229106"]];
    }
}

#pragma mark - Open to Google Map with passing destination coordinate
+ (void) navigateToGoogleMapWithLatitude:(double)latitude longitude:(double)longitude
{
    NSString *urlStr = [NSString stringWithFormat:@"http://maps.google.com/?daddr=%f,%f", latitude, longitude ];

    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:[NSURL URLWithString:urlStr]];
}

#pragma mark - Open Safari
+ (void) openBrowserInUrl:(NSString *)urlString
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

#pragma mark - Show Alert Message
+ (void)showAlertMsg:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

@end
