# Introduction
Restaurant Directory App Template is based on a restaurant directory app. The app consists of list view, and also map view. List view display the restaurant list in grid format, while map view has the concept of showing the restaurants in an area based on the center of the map. Other than the list and map view, this template consists of details page as well, displaying the restaurant details, and also the menu that are available in this restaurant.

The main objective of this template is to assist startups to buy their mobile application faster and easier. 

# Tools and Libraries used
Name | Description | URL
---- | ----------- | --
LCBannerView | LCBannerView is a library which used to display the images with automatic scrolling animation. | https://github.com/iTofu/LCBannerView
MBProgressHUD | MBProgressHUB is a library which is a very simple and nice loading indicator. | https://github.com/jdg/MBProgressHUD
MSPullToRefreshController | MSPullToRefreshController is a library which use for calling the data with the pull to refresh indicator effect. | https://github.com/bogardon/MSPullToRefreshController
MWPhotoBrowser | MWPhotoBrowser is a library which display images and able to zoom in/out. | https://github.com/mwaterfall/MWPhotoBrowser
DACircularProgress | DACircularProgress is a loading indicator library and use in MWPhotoBrowser library. | https://github.com/danielamitay/DACircularProgress
MZFormSheetPresentationController | MZFormSheetPresentationController provides an alternative to the native iOS UIModalPresentationFormSheet and also styling pop up effect. | https://github.com/m1entus/MZFormSheetPresentationController
SDWebImage | SDWebImage is a library which loading the image and also providing the cache. | https://github.com/rs/SDWebImage
TPFloatRatingView | TPFloatingRatingView is a library which display the star rating with the star icons. | https://github.com/glenyi/TPFloatRatingView
Icons8 | Icons8 is a website which provides images resources for icons. | https://icons8.com/
Android Asset Studio | Android Asset Studio is a website which provides image resources for icons, it also allow users to change the color of the icons, as well as controlling its size and padding. | https://romannurik.github.io/AndroidAssetStudio/icons-generic.html

# How to start
1. This project has implemented the GoogleMap SDK with cocoapod installed. If your Mac does not install Ruby and CocoaPods, please refer to Installation section. 
2. This project should be opening from the .xcworkspace file after installing the cocoapod.
3. This template comes with dummy data in it, if the app need to connect to Web API, then modify (void)loadData methods to integrate Web API library.
4. All list is accepting the NSArray/NSMutableArray and also added the method for appending data for the following pages from this method (void)finishLoadingDataFromCms:(NSArray *)results.
5. Data binding from Web API result to Model object is not included, you have to implement your own data binding.

# Installation
## CocoaPods
1. CocoaPods is build with Ruby and is installable with the default Ruby available on OS X. Default Ruby is recommended.
2. If your Mac do not install Ruby and CocoaPods yet, please refer to here https://cocoapods.org/ or https://guides.cocoapods.org/using/getting-started.html#getting-started. From the link, there have latest document to guide how to install the Ruby and CocoaPods.

## Implementation of GoogleMap SDK
1. You may use CocoaPods to install GoogleMaps SDK:
    1. Create a podfile
    1. And open by TextEdit and paste this
    ```
    platform :ios, ‘9.0’
    target 'RestaurantsNearBy' do
    pod 'GoogleMaps'
    end
    ```
    1. Open Terminal and run pod install from the project directory.

# What is inside
## Model Classes
### RestaurantModel.h
This model class is for the restaurant. It is the main object in this template.

### MenuModel.h
This model class is for the menu of the Restaurant object.

### AddressModel.h
This model class is for the address of the Restaurant object.

### CoordinateModel.h 
This model class is for the coordinate of the Restaurant object.

## Core Classes
### AppConstants.h
This class used to define some important **GLOBAL CONSTANT** for the others classes needed which are:
1. `DEFAULT_TAKE`
    1. This used for pagination feature while pulling the number of data from Web API.
2. `BANNER_VIEW_HEIGHT`
    1. This is the ratio of all the banners image to fit all the devices with different resolution sizes.
3. `appthemeColor`
4. `shadowColor`

### GeneralHelper.h & .m
This class used to define some GLOBAL methods which able to call by the other classes which are:
1. ```+(NSString *)suffixNumber:(NSNumber *)number```
    1. This method used to format the number, e.g. 1000 to 1k, 1500 to 1.5k
2. ```+(void) navigateToLatitude:(double)latitude longitude:(double)longitude```
    1. This method used to open Waze with passing certain coordinate.
3. ```+(void) navigateToGoogleMapWithLatitude:(double)latitude longitude:(double)longitude;```
    1. This method used to open GoogleMap with passing the certain coordainate.
4. ```+(void) openBrowserInUrl:(NSString *)urlString;```
    1. This method contains the default opening Safari browser with the url
5. ```+(void)showAlertMsg:(NSString *)msg;```
    1. This method contains the ```UIAlertView``` to display the alert message.

### BaseViewController.h & .m
This is the superclass for all the ```UIViewController``` classes to inherit. And also able to create some methods are calling by the certain ```UIViewController```.

### BaseTableViewController.h & .m
This is the superclass of all the UIViewController classes which contain ```UITableView``` and integrated the Pull To Refresh and Load More features.

### BaseCollectionViewController.h & .m
This is the superclass of all the UIViewController classes which contain ```UICollectionView``` and integrated the Pull To Refresh and Load More features.

## ViewController Classes
There are some important ViewController classes which used to integrate with Web API:
### ListPageViewController.h & .m
First of all, remove all the dummy data from ```-(void)loadData``` method before integrating Web API. While integrating Web API, remember to pass ```DEFAULT_TAKE``` to pull the number of data. If want to get nearby restaurant data, you may pass the current location to the API and do the filtering by the API.

### MapPageViewController.h & .m
First of all, remove all the dummy data before integrating Web API. Currently this class has integrated the ```CLLocationManager``` to get current location and displaying in GoogleMap. 
At the same time, you should integrate Web API into ```-(void) loadDataWithLatitude:(double)latitude longitude:(double)longitude``` with the coordinate to pull the data.

### DetailPageViewController.h & .m
First of all, you have to remove all the dummy data before integrating Web API. The data displaying in 2 different parts which are ```UITableViewHeaderView``` and ```UITableViewCell```. You should integrate Web API into ```-(void)loadData``` with ```DEFAULT_TAKE``` to pull the number of data. You may set the TableHeaderView while pulling to refresh,  self.currentPage will reset back to 1. 

# Useful Links
1. Appdrvn official website - http://www.appdrvn.com/ 
2. Appdrvn official facebook page - https://www.facebook.com/Appdrvn/ 
3. Appdrvn email address - hello@appdrvn.com 


