//
//  ListPageViewController.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "ListPageViewController.h"
#import "ListCollectionViewCell.h"
#import "MenuModel.h"

@interface ListPageViewController ()

@property (nonatomic, strong) UILabel *dataNoFoundLabel;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ListPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self triggerManualRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionView Delegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
    if ([self.dataArray count] != 0)
    {
        if (kind == UICollectionElementKindSectionFooter)
        {
            UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
            reusableview.backgroundColor = [UIColor clearColor];
            
            [self.activityViewBot removeFromSuperview];
            self.activityViewBot = [[UIActivityIndicatorView alloc] init];
            self.activityViewBot.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2-50, 50/2 - 5 , 12, 12);
            self.activityViewBot.color = [UIColor blackColor];
            [reusableview addSubview:self.activityViewBot];
            [self.activityViewBot startAnimating];
            
            [self.loadMoreLabel removeFromSuperview];
            self.loadMoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.activityViewBot.frame.origin.x+self.activityViewBot.frame.size.width+15, self.activityViewBot.frame.origin.y+(self.activityViewBot.frame.size.height/4), [[UIScreen mainScreen] bounds].size.width, 44)];
            self.loadMoreLabel.backgroundColor = [UIColor clearColor];
            self.loadMoreLabel.text = [NSString stringWithFormat:@"Load More"];
            self.loadMoreLabel.textColor = [UIColor blackColor];
            self.loadMoreLabel.font = [UIFont systemFontOfSize:11.0f];
            self.loadMoreLabel.textAlignment = NSTextAlignmentCenter;
            [reusableview addSubview:self.loadMoreLabel];
            [self.loadMoreLabel sizeToFit];
            self.loadMoreLabel.frame = CGRectMake(self.activityViewBot.frame.origin.x+self.activityViewBot.frame.size.width+15, self.activityViewBot.frame.origin.y+(self.activityViewBot.frame.size.height/2)-(self.loadMoreLabel.frame.size.height/2), self.loadMoreLabel.frame.size.width, self.loadMoreLabel.frame.size.height);
            
            return reusableview;
        }
    }
    
    return reusableview;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    [cell updateDisplay:[self.dataArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(ListPageViewControllerDelegateDidSelectedRestaurantModel:)])
    {
        [self.delegate ListPageViewControllerDelegateDidSelectedRestaurantModel:self.dataArray[indexPath.row]];
    }
}

- (CGSize)fillSizeArray:(int)index
{
    CGFloat padding = 15;
    
    float width = ([[UIScreen mainScreen] bounds].size.width - (padding * 3)) / 2;
    float height = width + 86;
    
    return CGSizeMake(width, height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self fillSizeArray:(int)indexPath.row];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(ListPageViewControllerDelegateDidDraggingScroll)])
    {
        [self.delegate ListPageViewControllerDelegateDidDraggingScroll];
    }
}

#pragma mark - Private
- (void) loadData
{
    // Remove the dummy data before putting the API method
    // You must put the API calling method at here
    
    // Create Dummy Data
    RestaurantModel *restaurant1 = [RestaurantModel new];
    restaurant1.name = @"Restaurant 1";
    restaurant1.distance = @"150m";
    restaurant1.detailsHtml = @"";
    restaurant1.rating = 5;
    restaurant1.reviewsCount = 1500;
    restaurant1.coordinate = [CoordinateModel new];
    restaurant1.coordinate.latitude = 3.073237;
    restaurant1.coordinate.longitude = 101.606500;
    restaurant1.imagesUrl = [NSArray arrayWithObjects:@"https://images.unsplash.com/photo-1467739792465-ac5d3aca7614?dpr=1&auto=compress,format&fit=crop&w=1050&h=&q=80&cs=tinysrgb&crop=", @"https://images.unsplash.com/photo-1414235077428-338989a2e8c0?dpr=1&auto=compress,format&fit=crop&w=1050&h=&q=80&cs=tinysrgb&crop=", nil];
    restaurant1.menus = [NSArray new];
    restaurant1.detailsHtml = @"<p>A range of full-service restaurants and lifestyle hubs, offering gastronomic adventures like never before!<br>Description<br>A range of full-service restaurants and lifestyle hubs, offering gastronomic adventures like never before!<br><br>Modern Italian Gastronomia with Mediterranean touches!<br><br>Heavenly Desserts? Handcrafted Beverages? Seductive Cocktails?<br><br>We have it all sizzling under our branch in Subang Jaya</p>";
    restaurant1.address = [AddressModel new];
    restaurant1.address.lineOne = @"Sunway Pyramid Shopping Mall";
    restaurant1.address.lineTwo = @"Jalan PJS 11/15 ";
    restaurant1.address.city = @"Bandar Sunway, Petaling Jaya ";
    restaurant1.address.state = @"Selangor";
    restaurant1.address.country = @"Malaysia";
    restaurant1.address.postCode = @"47500";
    
    RestaurantModel *restaurant2 = [RestaurantModel new];
    restaurant2.name = @"Restaurant 2";
    restaurant2.distance = @"250m";
    restaurant2.detailsHtml = @"";
    restaurant2.menus = [NSArray new];
    restaurant2.rating = 5;
    restaurant2.reviewsCount = 878;
    restaurant2.coordinate = [CoordinateModel new];
    restaurant2.coordinate.latitude = 3.077961;
    restaurant2.coordinate.longitude = 101.611028;
    restaurant2.imagesUrl = [NSArray arrayWithObjects:@"https://images.unsplash.com/photo-1484659619207-9165d119dafe?dpr=1&auto=compress,format&fit=crop&w=1050&h=&q=80&cs=tinysrgb&crop=", @"https://images.unsplash.com/photo-1421622548261-c45bfe178854?dpr=1&auto=compress,format&fit=crop&w=1049&h=&q=80&cs=tinysrgb&crop=", nil];
    restaurant2.address = [AddressModel new];
    restaurant2.address.lineOne = @"6, Jalan PJS 8/13, Bandar Sunway";
    restaurant2.address.lineTwo = @"";
    restaurant2.address.city = @"Bandar Sunway, Petaling Jaya ";
    restaurant2.address.state = @"Selangor";
    restaurant2.address.country = @"Malaysia";
    restaurant2.address.postCode = @"46150";
    
    RestaurantModel *restaurant3 = [RestaurantModel new];
    restaurant3.name = @"Restaurant 3";
    restaurant3.distance = @"750m";
    restaurant3.detailsHtml = @"";
    restaurant3.menus = [NSArray new];
    restaurant3.rating = 4;
    restaurant3.reviewsCount = 200;
    restaurant3.coordinate = [CoordinateModel new];
    restaurant3.coordinate.latitude = 3.075859;
    restaurant3.coordinate.longitude = 101.588532;
    restaurant3.imagesUrl = [NSArray arrayWithObjects:@"https://images.unsplash.com/photo-1504416285472-eccf03dd31eb?dpr=1&auto=compress,format&fit=crop&w=1052&h=&q=80&cs=tinysrgb&crop=", nil];
    restaurant3.address = [AddressModel new];
    restaurant3.address.lineOne = @"61, Jalan SS 15/4b, Ss 15";
    restaurant3.address.lineTwo = @"";
    restaurant3.address.city = @"Subang Jaya ";
    restaurant3.address.state = @"Selangor";
    restaurant3.address.country = @"Malaysia";
    restaurant3.address.postCode = @"46300";
    
    RestaurantModel *restaurant4 = [RestaurantModel new];
    restaurant4.name = @"Restaurant 4";
    restaurant4.distance = @"750m";
    restaurant4.detailsHtml = @"";
    restaurant4.menus = [NSArray new];
    restaurant4.rating = 5;
    restaurant4.reviewsCount = 198;
    restaurant4.coordinate = [CoordinateModel new];
    restaurant4.coordinate.latitude = 3.076163;
    restaurant4.coordinate.longitude = 101.589704;
    restaurant4.imagesUrl = [NSArray arrayWithObjects:@"https://images.unsplash.com/photo-1482068417235-8f51fac7fc30?dpr=1&auto=compress,format&fit=crop&w=1960&h=&q=80&cs=tinysrgb&crop=", nil];
    restaurant4.address = [AddressModel new];
    restaurant4.address.lineOne = @"49, Jalan SS 15/4, Ss 15";
    restaurant4.address.lineTwo = @"";
    restaurant4.address.city = @"Subang Jaya ";
    restaurant4.address.state = @"Selangor";
    restaurant4.address.country = @"Malaysia";
    restaurant4.address.postCode = @"47500";
    
    RestaurantModel *restaurant5 = [RestaurantModel new];
    restaurant5.name = @"Restaurant 5";
    restaurant5.distance = @"2km";
    restaurant5.detailsHtml = @"";
    restaurant5.menus = [NSArray new];
    restaurant5.rating = 3;
    restaurant5.reviewsCount = 500;
    restaurant5.coordinate = [CoordinateModel new];
    restaurant5.coordinate.latitude = 3.045417;
    restaurant5.coordinate.longitude = 101.618450;
    restaurant5.imagesUrl = [NSArray arrayWithObjects:@"https://images.unsplash.com/photo-1480455454781-1af590be2a58?dpr=1&auto=compress,format&fit=crop&w=1050&h=&q=80&cs=tinysrgb&crop=", nil];
    restaurant5.address = [AddressModel new];
    restaurant5.address.lineOne = @"Ioi Mall, 23, Lebuhraya Damansara - Puchong";
    restaurant5.address.lineTwo = @"Jalan PJS 11/15 ";
    restaurant5.address.city = @"Bandar Puchong Jaya";
    restaurant5.address.state = @"Puchong, Selangor";
    restaurant5.address.country = @"Malaysia";
    restaurant5.address.postCode = @"47100";
    
    RestaurantModel *restaurant6 = [RestaurantModel new];
    restaurant6.name = @"Restaurant 6";
    restaurant6.distance = @"2.1km";
    restaurant6.detailsHtml = @"";
    restaurant6.menus = [NSArray new];
    restaurant6.rating = 3;
    restaurant6.reviewsCount = 260;
    restaurant6.coordinate = [CoordinateModel new];
    restaurant6.coordinate.latitude = 3.031626;
    restaurant6.coordinate.longitude = 101.616174;
    restaurant6.imagesUrl = [NSArray arrayWithObjects:@"https://images.unsplash.com/photo-1503365268595-ee3947b49b1b?dpr=1&auto=compress,format&fit=crop&w=1050&h=&q=80&cs=tinysrgb&crop=", nil];
    restaurant6.address = [AddressModel new];
    restaurant6.address.lineOne = @"Level G, Block H, Setia Walk";
    restaurant6.address.lineTwo = @"Persiaran Wawasan";
    restaurant6.address.city = @"Bandar Puchong Jaya";
    restaurant6.address.state = @"Puchong, Selangor";
    restaurant6.address.country = @"Malaysia";
    restaurant6.address.postCode = @"47160";
    
    RestaurantModel *restaurant7 = [RestaurantModel new];
    restaurant7.name = @"Restaurant 7";
    restaurant7.distance = @"5.4km";
    restaurant7.detailsHtml = @"";
    restaurant7.menus = [NSArray new];
    restaurant7.rating = 3;
    restaurant7.reviewsCount = 160;
    restaurant7.coordinate = [CoordinateModel new];
    restaurant7.coordinate.latitude = 3.106745;
    restaurant7.coordinate.longitude = 101.595327;
    restaurant7.imagesUrl = [NSArray arrayWithObjects:@"https://images.unsplash.com/photo-1505250785451-1c2f86d0ed70?dpr=1&auto=compress,format&fit=crop&w=634&h=&q=80&cs=tinysrgb&crop=", nil];
    restaurant7.address = [AddressModel new];
    restaurant7.address.lineOne = @"SS7";
    restaurant7.address.lineTwo = @"";
    restaurant7.address.city = @"Petaling Jaya";
    restaurant7.address.state = @"Selangor";
    restaurant7.address.country = @"Malaysia";
    restaurant7.address.postCode = @"47301";
    
    RestaurantModel *restaurant8 = [RestaurantModel new];
    restaurant8.name = @"Restaurant 8";
    restaurant8.distance = @"6km";
    restaurant8.detailsHtml = @"";
    restaurant8.menus = [NSArray new];
    restaurant8.rating = 0;
    restaurant8.reviewsCount = 0;
    restaurant8.coordinate = [CoordinateModel new];
    restaurant8.coordinate.latitude = 3.113703;
    restaurant8.coordinate.longitude = 101.593233;
    restaurant8.imagesUrl = [NSArray arrayWithObjects:@"https://images.unsplash.com/photo-1491616599759-2f0134c97da8?dpr=1&auto=compress,format&fit=crop&w=1050&h=&q=80&cs=tinysrgb&crop=", nil];
    restaurant8.address = [AddressModel new];
    restaurant8.address.lineOne = @"Jalan Emas 2";
    restaurant8.address.lineTwo = @"Taman Megah Emas";
    restaurant8.address.city = @"Petaling Jaya ";
    restaurant8.address.state = @"Selangor";
    restaurant8.address.country = @"Malaysia";
    restaurant8.address.postCode = @"47301";
    
    NSMutableArray *temp = [NSMutableArray new];
    [temp addObjectsFromArray:@[restaurant1, restaurant2, restaurant3, restaurant4, restaurant5, restaurant6, restaurant7, restaurant8]];
    
    // This method used to check for Load More
    [self finishLoadingDataFromCms:[NSArray arrayWithArray:temp]];
}

- (void)finishLoadingDataFromCms:(NSArray *)results
{
    int limit = DEFAULT_TAKE;
    
    if ([results count] == 0)
    {
        self.canLoadMore = false;
        self.shouldShowNoDataImageViewAndLabel = YES;
        [self doneLoading];
        [self checkEmpty];
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
        NSMutableArray * temp = [[NSMutableArray alloc] initWithArray:self.dataArray];
        [temp addObjectsFromArray:results];
        self.dataArray = [NSArray arrayWithArray:temp];
    }
    else
    {
        self.dataArray = results;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self doneLoading];
        [self checkEmpty];
    });
}

#pragma mark -
- (void) checkEmpty
{
    // You may create your own Empty View while no data pulling from API
    
    [self.dataNoFoundLabel removeFromSuperview];
    if ([self.dataArray count] == 0)
    {
        self.dataNoFoundLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, [UIScreen mainScreen].bounds.size.height/2, [UIScreen mainScreen].bounds.size.width-30, 30)];
        self.dataNoFoundLabel.text = [NSString stringWithFormat:@"%@", @"No data"];
        self.dataNoFoundLabel.backgroundColor = [UIColor clearColor];
        self.dataNoFoundLabel.font = [UIFont systemFontOfSize:15.0f];
        self.dataNoFoundLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.dataNoFoundLabel];
    }
}

@end
