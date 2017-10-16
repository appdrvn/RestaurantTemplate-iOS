//
//  MWGridViewController.h
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
#import "MWPhotoBrowser.h"

@interface MWGridViewController : UICollectionViewController {}

@property (nonatomic, assign) MWPhotoBrowser *browser;
@property (nonatomic) BOOL selectionMode;
@property (nonatomic) CGPoint initialContentOffset;

- (void)adjustOffsetsAsRequired;

@end
