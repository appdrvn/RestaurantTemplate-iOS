# Introduction
Restaurant Directory App Template is based on a restaurant directory app. The app consists of list view, and also map view. List view display the restaurant list in grid format, while map view has the concept of showing the restaurants in an area based on the center of the map. Other than the list and map view, this template consists of details page as well, displaying the restaurant details, and also the menu that are available in this restaurant.

The main objective of this template is to assist startups to buy their mobile application faster and easier. 

# Tools and Libraries used

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
