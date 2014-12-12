//
//  SBServerManager.h
//  TestAPIsForFlickr
//
//  Created by Admin on 02.12.14.
//  Copyright (c) 2014 Sergii Borodin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectiveFlickr.h"

@interface SBServerManager : NSObject <OFFlickrAPIRequestDelegate>

@property (nonatomic, strong) OFFlickrAPIRequest *request;
@property (strong, nonatomic) UIImage* image;
@property (strong, nonatomic) NSMutableArray* photoArray;

+ (SBServerManager *) sharedManeger;

//- (void) getPhotoWithOffset:(NSInteger) offset
//                    countPage:(NSInteger) countPage
//                    onSuccess:(void(^)(NSArray* friends)) success
//                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;


@end
