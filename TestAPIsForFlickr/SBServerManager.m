//
//  SBServerManager.m
//  TestAPIsForFlickr
//
//  Created by Admin on 02.12.14.
//  Copyright (c) 2014 Sergii Borodin. All rights reserved.
//

#import "SBServerManager.h"
#import "AFNetworking.h"

@interface SBServerManager ()

@property (strong, nonatomic) AFHTTPRequestOperationManager* RequestOperationManager;

@property (nonatomic, strong) OFFlickrAPIContext *context;

@end

@implementation SBServerManager

+ (SBServerManager *) sharedManeger {
    
    static SBServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SBServerManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSURL* url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/"];
        
        self.RequestOperationManager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:url];
        
        self.context = [[OFFlickrAPIContext alloc] initWithAPIKey:@"b7feaac025b0fe2495172aaee44a6660" sharedSecret:@"505abe25cfb0ff13"];
        
        self.request = [[OFFlickrAPIRequest alloc] initWithAPIContext:self.context];
        [self.request setDelegate:self];
        
        [self.request callAPIMethodWithGET:@"flickr.interestingness.getList" arguments:[NSDictionary dictionaryWithObjectsAndKeys:   @"url_n",  @"extras",
                                            @(20),     @"per_page",
                                            @(1),      @"page", nil]];
            }
    return self;
}

#pragma mark - <OFFlickrAPIRequestDelegate>

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest
 didCompleteWithResponse:(NSDictionary *)inResponseDictionary
{
    
    NSMutableArray* photoArray = [NSMutableArray array];
    
    for (int i = 0; i < 20; i++) {
        NSDictionary *photoDict = [[inResponseDictionary valueForKeyPath:@"photos.photo"] objectAtIndex:i];
        NSURL *photoURL = [self.context photoSourceURLFromDictionary:photoDict size:OFFlickrSmallSize320];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL:photoURL];
        UIImage* image = [UIImage imageWithData: imageData];
        self.image = image;
        [photoArray addObject:image];
        
    }
    self.photoArray = photoArray;
    NSLog(@"%@", photoArray);
    
   }

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError
{
    
}
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest
    imageUploadSentBytes:(NSUInteger)inSentBytes
              totalBytes:(NSUInteger)inTotalBytes
{
    
}

@end

