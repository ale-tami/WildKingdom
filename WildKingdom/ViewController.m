//
//  ViewController.m
//  WildKingdom
//
//  Created by Alejandro Tami on 08/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ViewController.h"
#import "JSONManager.h"
#import "ImageViewCell.h"
#import "MapViewController.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, JSONManagerDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property NSArray *photosArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [JSONManager getInstance].delegate = self;
    
    
    NSString *criteria = nil;
    
    
    
    switch ([self.tabBarController selectedIndex]) {
        case 0:
            criteria = @"lion";
            break;
        case 1:
            criteria = @"bear";
            break;
        case 2:
            criteria = @"tiger";
            break;
        default:
            break;
    }
    
    self.collectionView.pagingEnabled = YES;
    
    [[JSONManager getInstance] makeRequestWithCriteria:criteria];
    
}



- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

    
    if (toInterfaceOrientation == UIDeviceOrientationLandscapeRight|| toInterfaceOrientation == UIDeviceOrientationLandscapeLeft ){
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(240, 240);
        self.collectionView.showsHorizontalScrollIndicator = YES;
        self.collectionView.showsVerticalScrollIndicator = NO;
               
        
    } else {
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake(120, 120);
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator = YES;

        
    }
    
    [self.collectionView setCollectionViewLayout: flowLayout];
    
}

#pragma mark JSON manager delegate
- (void) responseWithJSON:(NSDictionary *) json
{
    self.photosArray = [[json objectForKey:@"photos"] objectForKey:@"photo"];
    
    [self.collectionView reloadData];
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    ImageViewCell *cell = (ImageViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
//    [self performSegueWithIdentifier:@"segue" sender:cell];
    
//    [UIView transitionWithView:cell
//                      duration:0.2
//                       options:UIViewAnimationOptionTransitionFlipFromRight
//                    animations:^{
//                        [cell setFrame:collectionView.bounds];
//                        cell.transform = CGAffineTransformMakeRotation(0.0);
//                    }
//                    completion:^(BOOL finished) {}];
}

#pragma mark datasource collection

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photosArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageViewCell *cell = nil;
    
    if (!cell) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    }

    
    NSDictionary *dictImage = [self.photosArray objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:@"placeholder"];
    
    NSString *imageURLString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg",
                                dictImage[@"farm"],
                                dictImage[@"server"],
                                dictImage[@"id"],
                                dictImage[@"secret"]];
    

   [cell loadImageFromURL:imageURLString];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(ImageViewCell*)sender
{
    ((MapViewController*)segue.destinationViewController).photoID = sender.idPhoto;
}

@end
