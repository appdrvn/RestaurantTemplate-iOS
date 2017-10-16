//
//  MWGridCell.h
//  MWPhotoBrowser
//
//  Created by Michael Waterfall on 08/10/2013.
//
//
#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>
#import <UIKit/UIKit.h>
#import "MWPhoto.h"
#import "MWGridViewController.h"

@interface MWGridCell : UICollectionViewCell {}

@property (nonatomic, weak) MWGridViewController *gridController;
@property (nonatomic) NSUInteger index;
@property (nonatomic) id <MWPhoto> photo;
@property (nonatomic) BOOL selectionMode;
@property (nonatomic) BOOL isSelected;

- (void)displayImage;

@end
