//
//  MoreDetailHeaderView.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "MoreDetailHeaderView.h"

@interface MoreDetailHeaderView()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWebViewHeightConstraint;

@end

@implementation MoreDetailHeaderView

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

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.contentWebView.backgroundColor = [UIColor clearColor];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.nameLabel.preferredMaxLayoutWidth = screenRect.size.width - 15 - 15;
}

- (void) updateDisplay:(RestaurantModel *)model
{
    self.nameLabel.text = [NSString stringWithFormat:@"%@", model.name];
    
    self.contentWebView.userInteractionEnabled = NO;
    self.contentWebView.backgroundColor = [UIColor clearColor];
    self.contentWebView.delegate = self;
    
    NSString *htmlString = [NSString stringWithFormat:@"<html><body>%@</body></html>", model.detailsHtml];
    [self.contentWebView loadHTMLString:htmlString baseURL:nil];
}

#pragma mark - UIWebView Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // Disable user selection
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';document.body.style.margin='0';document.body.style.padding = '0';"];
    
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    self.contentWebViewHeightConstraint.constant = [result floatValue];
    if ([self.delegate respondsToSelector:@selector(MoreDetailHeaderViewDelegateUpdateHeight:)])
    {
        [self.delegate MoreDetailHeaderViewDelegateUpdateHeight:[result floatValue] + 55 + self.nameLabel.frame.size.height];
    }
}

@end
