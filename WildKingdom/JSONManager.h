//
//  JSONManager.h
//  MeetUpClient
//
//  Created by Alejandro Tami on 04/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol JSONManagerDelegate

- (void) responseWithJSON:(NSDictionary *) json;

@optional
- (void) responseWithGeoLocation:(CLLocationCoordinate2D) coordinates;

@end

@interface JSONManager : NSObject

@property id <JSONManagerDelegate> delegate;

+ (instancetype) getInstance;

- (void) makeRequestWithCriteria:(NSString*)criteria;
- (void) makeGeoRequestForPhoto:(NSString *)photoID;


@end
