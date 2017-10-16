//
//  MainPageViewController.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "MainPageViewController.h"
#import "MainPageContainerViewController.h"
//#import "DetailsPageViewController.h"
#import "DetailPageViewController.h"
#import "MapDetailPageViewController.h"
#import "MZFormSheetPresentationViewController.h"
#import "MZFormSheetPresentationViewControllerSegue.h"
#import "RestaurantModel.h"

#define UIBUTTON_TAG_LIST_VIEW 100001
#define UIBUTTON_TAG_MAP_VIEW 100002

@interface MainPageViewController ()<UITextFieldDelegate, MainPageContainerViewControllerDelegate, MapDetailPageViewControllerDelegate>

@property (nonatomic, weak) MainPageContainerViewController *containerViewController;
@property (weak, nonatomic) IBOutlet UIView *buttonsView;
@property (weak, nonatomic) IBOutlet UIButton *listViewButton;
@property (weak, nonatomic) IBOutlet UIButton *mapViewButton;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic) NSInteger clickedIndex;
@property (nonatomic, strong) RestaurantModel *selectedRestaurantModel;

@end

@implementation MainPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Inital Display
    self.searchTextField.placeholder = @"Search restaurant";
    [self buttonSelected:UIBUTTON_TAG_LIST_VIEW];
    
    // UIButtons - Set Shadow
    UIBezierPath *buttonShadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.buttonsView.frame.size.height)];
    self.buttonsView.layer.masksToBounds = NO;
    self.buttonsView.layer.shadowColor = [UIColor shadowColor].CGColor;
    self.buttonsView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.buttonsView.layer.shadowOpacity = 0.8f;
    self.buttonsView.layer.shadowPath = buttonShadowPath.CGPath;
    
    self.listViewButton.tag = UIBUTTON_TAG_LIST_VIEW;
    self.mapViewButton.tag = UIBUTTON_TAG_MAP_VIEW;
    
    // Search View - Set Corner Radius
    self.searchView.layer.cornerRadius = 5.0f;
    self.searchView.layer.masksToBounds = YES;
    self.searchView.backgroundColor = [UIColor whiteColor];

    // Search View - Set Shadow
    UIBezierPath *searchViewShadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, self.searchView.frame.size.height)];
    self.searchView.layer.masksToBounds = NO;
    self.searchView.layer.shadowColor = [UIColor shadowColor].CGColor;
    self.searchView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.searchView.layer.shadowOpacity = 0.8f;
    self.searchView.layer.shadowPath = searchViewShadowPath.CGPath;
    self.searchView.layer.shadowRadius = 5.0f;
    
    // UITextField Search
    self.searchTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedContainer"])
    {
        self.containerViewController = segue.destinationViewController;
        self.containerViewController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"gotoDetailPageViewController"])
    {
        DetailPageViewController *destinationVC = segue.destinationViewController;
        destinationVC.restaurantModel = self.selectedRestaurantModel; // Passing the Restaurant Object to DetailPageViewController
    }
}

#pragma mark - MainPageContainerViewControllerDelegate
- (void) MainPageContainerViewControllerDelegateDidSelectedRestaurantModel:(RestaurantModel *)model
{
    self.selectedRestaurantModel = [RestaurantModel new];
    self.selectedRestaurantModel = model;
    
    [self performSegueWithIdentifier:@"gotoDetailPageViewController" sender:self];
}

- (void) MainPageContainerViewControllerDelegateDidSelectedRestaurantModelFromMap:(RestaurantModel *)model
{
    // Open the Detail Card
    MapDetailPageViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MapDetailPageViewController"];
    vc.view.backgroundColor = [UIColor clearColor];
    vc.delegate = self;
    vc.restaurantModel = model;
    
    MZFormSheetPresentationViewController *formSheet = [[MZFormSheetPresentationViewController alloc] initWithContentViewController:vc];
    formSheet.presentationController.shouldCenterVertically = YES;
    formSheet.presentationController.shouldApplyBackgroundBlurEffect = NO;
    formSheet.presentationController.shouldDismissOnBackgroundViewTap = YES;
    formSheet.contentViewControllerTransitionStyle = MZFormSheetPresentationTransitionStyleBounce;
    formSheet.presentationController.movementActionWhenKeyboardAppears = MZFormSheetActionWhenKeyboardAppearsMoveToTop;
    formSheet.presentationController.contentViewSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height); // or pass in UILayoutFittingCompressedSize to size automatically with auto-layout
    
    [self presentViewController:formSheet animated:YES completion:^{
        [vc refreshView];
    }];
}

- (void) MainPageContainerViewControllerDelegateDidDraggingScroll
{
    [self.view endEditing:YES];
    self.searchTextField.text = @"";
}

#pragma mark - MapDetailPageViewControllerDelegate
- (void) MapDetailPageViewControllerDelegateDidClickViewMore:(RestaurantModel *)model
{
    self.selectedRestaurantModel = [RestaurantModel new];
    self.selectedRestaurantModel = model;
    
    [self performSegueWithIdentifier:@"gotoDetailPageViewController" sender:self];
}

#pragma mark - UIButtons Actions
- (IBAction)changeStylePressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (self.clickedIndex == button.tag)
        return;
    
    [self buttonSelected:button.tag];
    
    [self.containerViewController swapViewControllers];
}

- (IBAction)menuPressed:(id)sender
{
    [self performSegueWithIdentifier:@"gotoAboutPageViewController" sender:self];
}

#pragma mark - UITextField Delegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [textField resignFirstResponder];
    
    if ([textField.text length])
    {
        // You may call the Search feature with the keyword at here
    }
    
    return YES;
}

#pragma mark - 
- (void) buttonSelected:(NSInteger)tag
{
    self.searchTextField.text = @"";
    self.clickedIndex = tag;
    if (tag == UIBUTTON_TAG_LIST_VIEW)
    {
        self.searchView.hidden = NO;
        // List View Button - Selected
        [self.listViewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.listViewButton setBackgroundColor:[UIColor appthemeColor]];
        
        // Map View Button
        [self.mapViewButton setTitleColor:[UIColor colorWithRed:72.0f/255.0f green:69.0f/255.0f blue:71.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [self.mapViewButton setBackgroundColor:[UIColor whiteColor]];
    }
    else
    {
        self.searchView.hidden = YES;
        // List View Button
        [self.listViewButton setTitleColor:[UIColor colorWithRed:72.0f/255.0f green:69.0f/255.0f blue:71.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
        [self.listViewButton setBackgroundColor:[UIColor whiteColor]];
        
        // Map View Button - Selected
        [self.mapViewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.mapViewButton setBackgroundColor:[UIColor appthemeColor]];
    }
}

@end
