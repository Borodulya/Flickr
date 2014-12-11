//
//  SBViewController.m
//  TestAPIsForFlickr
//
//  Created by Admin on 02.12.14.
//  Copyright (c) 2014 Sergii Borodin. All rights reserved.
//

#import "SBViewController.h"
#import "SBServerManager.h"
#import "ObjectiveFlickr.h"

@interface SBViewController ()

@property (strong, nonatomic) NSMutableArray* picturesArray;

@end

@implementation SBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.picturesArray = [NSMutableArray array];
    
    [self getPicturesFromServer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - API

- (void) getPicturesFromServer {
    
    SBServerManager *manager = [SBServerManager sharedManeger];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.picturesArray count] + 1;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* idetifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:idetifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetifier];
        
        cell.textLabel.text = @"Sekfsthfyyv";
    }
    
    return cell;
}


@end
