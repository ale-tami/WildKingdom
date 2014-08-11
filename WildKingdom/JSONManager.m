//
//  JSONManager.m
//  MeetUpClient
//
//  Created by Alejandro Tami on 04/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "JSONManager.h"

#define urlFlikr "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=e4328c52b402045accf3ad8d66c81b52&format=json&nojsoncallback=1&per_page=10&tags="

@implementation JSONManager

static JSONManager *jsonManager = nil;


+ (instancetype) getInstance
{
    if (jsonManager) {
        return jsonManager;
    } else {
        return jsonManager = [JSONManager new];
    }
}


// 97a3c9363a4a20b9 secret

- (void)makeRequestWithCriteria:(NSString *)criteria
{
    // to be refactored, make it generic
    __block NSDictionary * responseJSON = [[NSDictionary alloc] init];
    
    if (!criteria) {
        criteria = @"none";
    }
    
    NSString *completeURL = [[NSString stringWithFormat:@urlFlikr] stringByAppendingString:criteria];
    
    NSString *stringURL = completeURL;
    
    NSURL *url = [NSURL URLWithString:stringURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        [self.delegate responseWithJSON:responseJSON];
      
    
    }];
    
}

- (void)makeGeoRequestForPhoto:(NSString *)criteria
{
    // to be refactored, make it generic
    __block NSDictionary * responseJSON = [[NSDictionary alloc] init];
    
    if (!criteria) {
        criteria = @"none";
    }
    
    NSString *completeURL = [[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=e4328c52b402045accf3ad8d66c81b52&photo_id="] stringByAppendingString:criteria];
    
    NSString *stringURL = completeURL;
    
    NSURL *url = [NSURL URLWithString:stringURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake([[responseJSON objectForKey:@"longitude"] doubleValue], [[responseJSON objectForKey:@"latitude"] doubleValue]);
        
        [self.delegate responseWithGeoLocation:location];
        
        
    }];
    
}

- (void) responseWithJSON:(NSDictionary *) json
{
    
}



- (void) responseWithGeoLocation:(CLLocationCoordinate2D) coordinates
{
    
}


@end
