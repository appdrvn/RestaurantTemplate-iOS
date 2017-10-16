//
//  MoreDetailPageViewController.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "MoreDetailPageViewController.h"
#import "MoreDetailHeaderView.h"
#import "MoreDetailAddressTableViewCell.h"
#import "AddressModel.h"

@interface MoreDetailPageViewController ()<UITableViewDataSource, UITableViewDelegate, MoreDetailHeaderViewDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITableView *moreDetailTableView;
@property (nonatomic, strong) MoreDetailHeaderView *moreDetailHeaderView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableDictionary *offscreenCells;

@end

@implementation MoreDetailPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = [NSMutableArray new];
    [self.dataArray addObject:[AddressModel getFullAddress:self.restaurantModel.address]];
    
    [self addHeaderView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - Add Header View
- (void) addHeaderView
{
    self.moreDetailHeaderView = nil;
    self.moreDetailHeaderView = [[MoreDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 320.0f)];
    self.moreDetailHeaderView.backgroundColor = [UIColor clearColor];
    self.moreDetailHeaderView.view.backgroundColor = [UIColor clearColor];
    self.moreDetailHeaderView.delegate = self;
    [self.moreDetailHeaderView updateDisplay:self.restaurantModel];
    [self.moreDetailHeaderView setNeedsLayout];
    [self.moreDetailHeaderView layoutIfNeeded];
    [self.moreDetailHeaderView layoutSubviews];
    
    CGRect headerFrame = self.moreDetailHeaderView.frame;
    headerFrame.size.height = [self.moreDetailHeaderView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    self.moreDetailHeaderView.frame = headerFrame;
    
    self.moreDetailTableView.tableHeaderView = self.moreDetailHeaderView;
}

#pragma mark - MoreDetailHeaderViewDelegate
- (void) MoreDetailHeaderViewDelegateUpdateHeight:(CGFloat)height
{
    CGRect headerFrame = self.moreDetailHeaderView.frame;
    headerFrame.size.height = height;
    self.moreDetailHeaderView.frame = headerFrame;
    
    self.moreDetailTableView.tableHeaderView = self.moreDetailHeaderView;
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = NSStringFromClass([MoreDetailAddressTableViewCell class]);
    
    MoreDetailAddressTableViewCell *cell = [self.offscreenCells objectForKey:reuseIdentifier];
    if(cell == nil)
    {
        cell = (MoreDetailAddressTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    [cell updateDisplay:self.dataArray[indexPath.row]];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGFloat height = 0.0;
    height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    height += 1;
    
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreDetailAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MoreDetailAddressTableViewCell class])];
    cell.backgroundColor = [UIColor clearColor];
    [cell updateDisplay:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.offscreenCells setObject:cell forKey:@"MoreDetailAddressTableViewCell"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self openNaviTo:self.restaurantModel];
}

#pragma mark - UIButtons Actions
- (IBAction)backPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)getDirectionPressed:(id)sender
{
    [self openNaviTo:self.restaurantModel];
}


@end
