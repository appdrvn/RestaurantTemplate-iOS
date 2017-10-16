//
//  AboutUIModel.m
//  RestaurantsNearBy
//
//  Created by KY Tang on 9/27/17.
//  Copyright © 2017 AppDrvn PLT. All rights reserved.
//

#import "AboutUIModel.h"

@implementation AboutUIModel

+ (id) AboutUIModelWithReferenceName:(NSString *)referenceName referenceLink:(NSString *)referenceLink referenceAuthor:(NSString *)referenceAuthor
{
    AboutUIModel *model = [AboutUIModel new];
    model.referenceName = referenceName;
    model.referenceLink = referenceLink;
    model.referenceAuthor = referenceAuthor;
    
    return model;
}

@end
