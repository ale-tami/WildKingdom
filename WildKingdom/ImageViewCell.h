//
//  imageViewCell.h
//  WildKingdom
//
//  Created by Alejandro Tami on 08/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ImageViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property NSString * idPhoto;

- (void) loadImageFromURL: (NSString*) urlString;

@end
