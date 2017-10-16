//
//  DetailPageViewController.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "DetailPageViewController.h"
#import "DetailHeaderView.h"
#import "MenuLeftSideTableViewCell.h"
#import "DetailSectionTableViewCell.h"
#import "MenuModel.h"
#import "MWPhotoBrowser.h"
#import "MoreDetailPageViewController.h"

@interface DetailPageViewController ()<DetailSectionTableViewCellDelegate, DetailHeaderViewDelegate, MWPhotoBrowserDelegate>

@property (nonatomic, strong) DetailHeaderView *detailHeaderView;
@property (nonatomic, strong) NSArray *menuArray;
@property (strong, nonatomic) NSMutableArray *imageViewerArray; // MWPhotoBrowser

@end

@implementation DetailPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self triggerManualRefresh];
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

#pragma mark - Add Header View
- (void) addHeaderView
{
    self.detailHeaderView = nil;
    self.detailHeaderView = [[DetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, BANNER_VIEW_HEIGHT)];
    self.detailHeaderView.delegate = self;
    self.detailHeaderView.backgroundColor = [UIColor clearColor];
    self.detailHeaderView.view.backgroundColor = [UIColor clearColor];
    [self.detailHeaderView updateDisplay:self.restaurantModel];
    self.currentTableView.tableHeaderView = self.detailHeaderView;
}

#pragma mark - UITableView Delegate
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 111.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DetailSectionTableViewCell *sectionHeader = [[DetailSectionTableViewCell alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 55)];
    sectionHeader.backgroundColor = [UIColor whiteColor];
    sectionHeader.delegate = self;
    [sectionHeader updateDisplay:self.restaurantModel];
    
    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuLeftSideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MenuLeftSideTableViewCell class])];
    
    if (indexPath.row%2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MenuRightSideTableViewCell"];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    [cell updateDisplay:self.menuArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - DetailSectionTableViewCellDelegate
- (void) DetailSectionTableViewCellDelegateDidClickOnBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) DetailSectionTableViewCellDelegateDidClickOnInfoButton
{
    [self performSegueWithIdentifier:@"gotoMoreDetailPageViewController" sender:self];
}

#pragma mark - DetailHeaderViewDelegate
- (void) DetailHeaderViewDelegateDidSelectedAtIndex:(NSInteger)index
{
    // Open Image Viewer
    self.imageViewerArray = [NSMutableArray new];
    
    for (int i=0; i<[self.restaurantModel.imagesUrl count]; i++)
    {
        MWPhoto *p = [MWPhoto photoWithURL:[NSURL URLWithString:self.restaurantModel.imagesUrl[i]]];
        [self.imageViewerArray addObject:p];
    }
    [self performPhotoSelectionAction:index];
}

#pragma mark - MWPhotoBrowserDelegate
- (void)performPhotoSelectionAction:(NSInteger)initialIndex
{
    MWPhotoBrowser * browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    [browser setCurrentPhotoIndex:initialIndex];
    browser.displayActionButton = YES;
    browser.zoomSmallPhotos = YES;
    
    UINavigationController * nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return [self.imageViewerArray count];
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < [self.imageViewerArray count])
        return [self.imageViewerArray objectAtIndex:index];
    
    return nil;
}

#pragma mark - Segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gotoMoreDetailPageViewController"])
    {
        MoreDetailPageViewController *destinationVC = segue.destinationViewController;
        destinationVC.restaurantModel = self.restaurantModel; // Passing the Restaurant Object to MoreDetailPageViewController
    }
}

#pragma mark - Private
- (void) loadData
{
    // Remove the dummy data before putting the API method
    // You must put the API calling method at here
    
    // Create Dummy Data
    MenuModel *menu1 = [MenuModel new];
    menu1.thumbnailUrl = @"https://scontent.fkul8-1.fna.fbcdn.net/v/t1.0-9/22140954_10214051566224888_3922784389363383255_n.jpg?oh=66da99e342785d7661d28f10f553a9d0&oe=5A47429D";
    menu1.title = @"Chicken Tandoori";
    menu1.price = 8.50;
    menu1.ingredient = @"Chicken, salt, lemon juice, plain yogurt, minced garlic, grated fresh ginger root, garam masala, cayenne pepper, food coloring, chopped cilantro, lemon wedges.";
    
    MenuModel *menu2 = [MenuModel new];
    menu2.thumbnailUrl = @"https://scontent.fkul8-1.fna.fbcdn.net/v/t1.0-9/22141046_10214051566304890_2746123532696678173_n.jpg?oh=a087b0575d7edfed266ecedaa0a920ee&oe=5A85F69D";
    menu2.title = @"Chicken Burger";
    menu2.price = 16.80;
    menu2.ingredient = @"Skinless chicken breast, fine fresh bread crumbs, grated sweet onion, cayenne pepper, coarse grained salt, black pepper, olive oil.";
    
    MenuModel *menu3 = [MenuModel new];
    menu3.thumbnailUrl = @"https://scontent.fkul8-1.fna.fbcdn.net/v/t1.0-9/22050039_10214051566704900_4625782079820955747_n.jpg?oh=18abb5f5bb9a2c63a97d89fb338d997f&oe=5A7C4190";
    menu3.title = @"Smoked Duck Spaghetti";
    menu3.price = 25.60;
    menu3.ingredient = @"Thin spaghetti, olive oil, minced garlic, smoked duck meat, freshly ground black pepper.";
    
    MenuModel *menu4 = [MenuModel new];
    menu4.thumbnailUrl = @"https://scontent.fkul8-1.fna.fbcdn.net/v/t1.0-9/22046579_10214051566824903_8683044660595592863_n.jpg?oh=dd9ddee1ccd26daaabfe07c6713c092a&oe=5A3B749F";
    menu4.title = @"Venison ribs";
    menu4.price = 50.90;
    menu4.ingredient = @"Potatoes, bbq sauce, fresh lemon, venison ribs, salt, mint herbs.";
    
    MenuModel *menu5 = [MenuModel new];
    menu5.thumbnailUrl = @"https://scontent.fkul8-1.fna.fbcdn.net/v/t1.0-9/22050161_10214051567224913_4065432666330905352_n.jpg?oh=8ddb532e82bc99fc6352a10ba2b4abee&oe=5A4E2A98";
    menu5.title = @"Chicken Chop";
    menu5.price = 16.90;
    menu5.ingredient = @"Potato fries, potato, boneless chicken drumstick, bbq sauce.";
    
    MenuModel *menu6 = [MenuModel new];
    menu6.thumbnailUrl = @"https://scontent.fkul8-1.fna.fbcdn.net/v/t1.0-9/22046722_10214051567784927_3411723435492621118_n.jpg?oh=a05775a3f05b4265dddbbe7faf199726&oe=5A515267";
    menu6.title = @"Chee cheong fun";
    menu6.price = 5.60;
    menu6.ingredient = @"Rice flour, corn starch, salt, cooking oil, finely chopped spring onion, water, soy sauce, sugar, sesame oil, fried shallots crisp, white sesame seeds.";
    
    MenuModel *menu7 = [MenuModel new];
    menu7.thumbnailUrl = @"https://scontent.fkul8-1.fna.fbcdn.net/v/t1.0-9/22089126_10214051567744926_1648953764446038653_n.jpg?oh=2edfe48c6c3dfc26ad893fda27a11302&oe=5A80EF45";
    menu7.title = @"Cantonese fried yee mee";
    menu7.price = 8.90;
    menu7.ingredient = @"Oil, chopped cloves garlic, sliced fish, cornflour, water, sliced squid, prawn, sliced chye sim, salt, egg, yee mee.";
    
    MenuModel *menu8 = [MenuModel new];
    menu8.thumbnailUrl = @"https://scontent.fkul8-1.fna.fbcdn.net/v/t1.0-9/22195714_10214051567584922_5916568298855404400_n.jpg?oh=b5a696e7efcc429db4099dee4cecf3e8&oe=5A49396E";
    menu8.title = @"Kam heong lala(clam) rice";
    menu8.price = 10.90;
    menu8.ingredient = @"Clams, olive oild, minced dried prawns, garlic, ginger, curry leaves, dark soya sauce, oyster sauce, chopped chili padi.";
    
    // Set the TableHeaderView while currentPage is 1
    if (self.currentPage == 1)
    {
        [self addHeaderView];
    }
    
    // This method used to check for Load More
    [self finishLoadingDataFromCms:[NSArray arrayWithObjects:menu1, menu2, menu3, menu4, menu5, menu6, menu7, menu8, nil]];
}

- (void)finishLoadingDataFromCms:(NSArray *)results
{
    int limit = DEFAULT_TAKE;
    
    if ([results count] == 0)
    {
        self.canLoadMore = false;
        self.shouldShowNoDataImageViewAndLabel = YES;
        [self doneLoading];
        return;
    }
    else if([results count] == limit)
    {
        self.currentPage++;
        self.canLoadMore = true;
    }
    else
    {
        self.canLoadMore = false;
    }
    
    if (self.isLoadingMore)
    {
        NSMutableArray * temp = [[NSMutableArray alloc] initWithArray:self.menuArray];
        [temp addObjectsFromArray:results];
        self.menuArray = [NSArray arrayWithArray:temp];
    }
    else
    {
        self.menuArray = results;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self doneLoading];
        
        // You may do the empty data checking at here
    });
}

@end
