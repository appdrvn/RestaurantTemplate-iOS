//
//  MainPageContainerViewController.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "MainPageContainerViewController.h"
#import "ListPageViewController.h"
#import "MapPageViewController.h"

#define SegueIdentifierFirst @"ListViewSegue"
#define SegueIdentifierSecond @"mapViewSegue"

@interface MainPageContainerViewController ()<ListPageViewControllerDelegate, MapPageViewControllerDelegate>

@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (nonatomic, strong) ListPageViewController *listPageViewController;
@property (nonatomic, strong) MapPageViewController *mapPageViewController;
@property (assign, nonatomic) BOOL transitionInProgress;

@end

@implementation MainPageContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Instead of creating new VCs on each seque we want to hang on to existing
    // instances if we have it. Remove the second condition of the following
    // two if statements to get new VC instances instead.
    if ([segue.identifier isEqualToString:SegueIdentifierFirst])
    {
        self.listPageViewController = segue.destinationViewController;
        self.listPageViewController.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:SegueIdentifierSecond])
    {
        self.mapPageViewController = segue.destinationViewController;
        self.mapPageViewController.delegate = self;
    }
    
    // If we're going to the first view controller.
    if ([segue.identifier isEqualToString:SegueIdentifierFirst])
    {
        // If this is not the first time we're loading this.
        if (self.childViewControllers.count > 0)
        {
            [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.listPageViewController];
        }
        else
        {
            // If this is the very first time we're loading this we need to do
            // an initial load and not a swap.
            [self addChildViewController:segue.destinationViewController];
            UIView* destView = ((UIViewController *)segue.destinationViewController).view;
            destView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            [self.view addSubview:destView];
            [segue.destinationViewController didMoveToParentViewController:self];
        }
    }
    // By definition the second view controller will always be swapped with the
    // first one.
    else if ([segue.identifier isEqualToString:SegueIdentifierSecond])
    {
        [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.mapPageViewController];
    }
}

- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
        self.transitionInProgress = NO;
    }];
}

- (void)swapViewControllers
{
    if (self.transitionInProgress)
    {
        return;
    }
    
    if ([self.currentSegueIdentifier isEqualToString:SegueIdentifierSecond])
    {
    }
    
    self.transitionInProgress = YES;
    self.currentSegueIdentifier = ([self.currentSegueIdentifier isEqualToString:SegueIdentifierFirst]) ? SegueIdentifierSecond : SegueIdentifierFirst;
    
    
    if (([self.currentSegueIdentifier isEqualToString:SegueIdentifierFirst]) && self.listPageViewController)
    {
        [self swapFromViewController:self.mapPageViewController toViewController:self.listPageViewController];
        return;
    }
    
    if (([self.currentSegueIdentifier isEqualToString:SegueIdentifierSecond]) && self.mapPageViewController)
    {
        [self swapFromViewController:self.listPageViewController toViewController:self.mapPageViewController];
        return;
    }
    
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

#pragma mark - ListPageViewControllerDelegate
- (void) ListPageViewControllerDelegateDidSelectedRestaurantModel:(RestaurantModel *)model
{
    if ([self.delegate respondsToSelector:@selector(MainPageContainerViewControllerDelegateDidSelectedRestaurantModel:)])
    {
        [self.delegate MainPageContainerViewControllerDelegateDidSelectedRestaurantModel:model];
    }
}

- (void) ListPageViewControllerDelegateDidDraggingScroll
{
    if ([self.delegate respondsToSelector:@selector(MainPageContainerViewControllerDelegateDidDraggingScroll)])
    {
        [self.delegate MainPageContainerViewControllerDelegateDidDraggingScroll];
    }
    
}

#pragma mark - MapPageViewControllerDelegate
- (void) MapPageViewControllerDelegateDidSelectedRestaurantModel:(RestaurantModel *)model
{
    if ([self.delegate respondsToSelector:@selector(MainPageContainerViewControllerDelegateDidSelectedRestaurantModelFromMap:)])
    {
        [self.delegate MainPageContainerViewControllerDelegateDidSelectedRestaurantModelFromMap:model];
    }
}

#pragma mark - 
- (void) loadData
{
    self.currentSegueIdentifier = SegueIdentifierFirst;
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

@end
