//
//  BaseTableViewController.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomPullToRefresh.h"

@interface BaseTableViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate, CustomPullToRefreshDelegate>

@property (nonatomic, weak) IBOutlet UITableView *currentTableView;

@property (nonatomic) int currentPage;
@property (nonatomic) BOOL isLoadingMore;
@property (nonatomic) BOOL isRefreshing;
@property (nonatomic) BOOL canLoadMore;
@property (nonatomic, strong) CustomPullToRefresh * pullToRefresh;
@property (nonatomic) BOOL shouldShowNoDataImageViewAndLabel;
@property (nonatomic, assign) int extraSkipCount;
@property (nonatomic, strong) UIActivityIndicatorView *activityViewBot;
@property (nonatomic, strong) UILabel *loadMoreLabel;

- (void)triggerManualRefresh;
- (void)doneLoading;
- (void)loadData;


@end
