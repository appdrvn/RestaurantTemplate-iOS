//
//  AboutUIModel.h
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AboutUIModel : NSObject

@property (nonatomic, strong) NSString *referenceName;
@property (nonatomic, strong) NSString *referenceAuthor;
@property (nonatomic, strong) NSString *referenceLink;
+ (id) AboutUIModelWithReferenceName:(NSString *)referenceName referenceLink:(NSString *)referenceLink referenceAuthor:(NSString *)referenceAuthor;

@end
