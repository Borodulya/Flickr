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

@property (strong, nonatomic) NSDictionary* picturesArray;
@property (strong, nonatomic) SBServerManager* manager;

@end

@implementation SBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.picturesArray = [NSDictionary dictionary];
    
    [self getPicturesFromServer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void) getPicturesFromServer {
    SBServerManager* manager = [[SBServerManager alloc] init];
    
    [self.tableView reloadData];
    self.manager = manager;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* idetifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:idetifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetifier];
        
        //cell.textLabel.text = @"textLabel";
        
        cell.imageView.image = self.manager.image;
        
    }
    
    return cell;
}

@end
