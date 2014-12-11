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
@property (nonatomic, strong) OFFlickrAPIRequest *request;
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
        
        [self.request callAPIMethodWithGET:@"flickr.interestingness.getList" arguments:[NSDictionary dictionaryWithObjectsAndKeys:@"b7feaac025b0fe2495172aaee44a6660", @"api_key",
                                            @"description",@"extras",
                                            @(10),     @"per_page",
                                            @(1),      @"page", nil]];
            }
    return self;
}

//- (void) getPhotoWithOffset:(NSInteger) offset
//                        countPage:(NSInteger) countPage
//                    onSuccess:(void(^)(NSArray* photoDict)) success
//                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
//
//   NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
//                               @"b7feaac025b0fe2495172aaee44a6660", @"api_key",
//                               //@"YYYY-MM-DD", @"date",
//                               @"description",      @"extras",
//                               @(10),     @"per_page",
//                               @(1),      @"page",
//                            nil];
//    
//    [self.RequestOperationManager
//    GET:@"flickr.interestingness.getList"
//     parameters:params
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSLog(@"JSON: %@", responseObject);
//         NSMutableArray* flickrPhotos = [responseObject objectForKey:@"photos"];
//         
//                  if (success) {
//             success(flickrPhotos);
//         }
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         NSLog(@"Error: %@", error);
//         if (failure) {
//             failure(error, operation.response.statusCode);
//         }
//     }];
//    }

#pragma mark - <OFFlickrAPIRequestDelegate>

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest
 didCompleteWithResponse:(NSDictionary *)inResponseDictionary
{
    NSDictionary *photoDict = [[inResponseDictionary valueForKeyPath:@"photos.photo"] objectAtIndex:0];
	
	NSURL *photoURL = [self.context photoSourceURLFromDictionary:photoDict size:OFFlickrLargeSize];
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL:photoURL];
    UIImage* image = [UIImage imageWithData: imageData];
    
    
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

