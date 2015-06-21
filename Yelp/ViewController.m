//
//  ViewController.m
//  Yelp
//
//  Created by Saker Lin on 2015/6/20.
//  Copyright (c) 2015年 Saker Lin. All rights reserved.
//

#import "ViewController.h"
#import "YelpClient.h"
#import "Business.h"
#import "BusinessCell.h"
#import "FiltersViewController.h"
NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) YelpClient *client;
@property(atomic, strong) NSArray *businesses;
- (void)fetchBusinessWithQuery:(NSString *)query params:(NSDictionary *)params;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey
                                           consumerSecret:kYelpConsumerSecret
                                              accessToken:kYelpToken
                                             accessSecret:kYelpTokenSecret];
    
    [self fetchBusinessWithQuery:@"Restaurants" params:nil];
   
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // cell registration
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
    // cell auto height.
    self.tableView.estimatedRowHeight = 86;
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    // set navigation bar buttons
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filters"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(onFiltersButton)];;
    
}
#pragma mark - Table View Data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    cell.business = self.businesses[(NSUInteger) indexPath.row];
    return cell;
}
#pragma mark - Filters View Controller delegate methods

- (void)filtersViewController:(FiltersViewController *)filtersViewController
             didChangeFilters:(NSDictionary *)filters {
    [self fetchBusinessWithQuery:@"Restaurants" params:filters];
    
    NSLog(@"Fire a new network event: %@", filters);
    
}
#pragma mark - Private methods
- (void)fetchBusinessWithQuery:(NSString *)query params:(NSDictionary *)params{
    [self.client searchWithTerm: query
                         params:params
                        success:^(AFHTTPRequestOperation *operation, id response) {
        // NSLog(@"response: %@", response);
         NSLog(@"response: %@", params);
        NSArray *businessDictionaries = response[@"businesses"];
        self.businesses = [Business bussinessesWithDictionaries:businessDictionaries];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSLog(@"error: %@", [error description]);
    }];
}

- (void)onFiltersButton {
    
    FiltersViewController *vc = [[FiltersViewController alloc] init];
    vc.delegate = self; // to receive the apply event
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
