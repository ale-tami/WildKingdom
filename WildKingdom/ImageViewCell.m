//
//  imageViewCell.m
//  WildKingdom
//
//  Created by Alejandro Tami on 08/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ImageViewCell.h"



@implementation ImageViewCell

- (id) init
{
    self = [super init];

    return self;
}

- (void) loadImageFromURL: (NSString*) urlString;
{
    
    NSURL *url = nil;
    NSURLRequest *request = nil;
    
    url = [NSURL URLWithString:urlString];
    request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        self.idPhoto =  [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"photo_id"];

        self.imageView.image = [UIImage imageWithData:data];
        [self setNeedsLayout];
    }];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//    
//        NSData *imageData = [NSData dataWithContentsOfURL:url];
//        UIImage *image = [UIImage imageWithData:imageData];
//      //  dispatch_async(dispatch_get_main_queue(), ^{
//            
//            self.imageView.image = image;
//            
//       // });
//    });
}

@end
