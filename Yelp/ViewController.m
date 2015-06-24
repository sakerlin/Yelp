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
#import "Filters.h"
NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) YelpClient *client;
@property(atomic, strong) NSArray *businesses;
@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) NSString *queryTerm;
@property(nonatomic, strong) UIColor *naviColor;
- (void)fetchBusinessWithQuery:(NSString *)query params:(NSDictionary *)params;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.queryTerm = @"Pizza";
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey
                                           consumerSecret:kYelpConsumerSecret
                                              accessToken:kYelpToken
                                             accessSecret:kYelpTokenSecret];
    
    [self fetchBusinessWithQuery: self.queryTerm params:nil];
    UIColor *naviColor = [UIColor
                 colorWithRed:0.73
                 green:0.05
                 blue:0.01
                 alpha:1.0];
   self.navigationController.navigationBar.barTintColor = naviColor;
    
    // cell registration
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
    // cell auto height.
    self.tableView.estimatedRowHeight = 86;
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    // set navigation bar buttons
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filters"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(onFiltersButton)];
    self.navigationItem.leftBarButtonItem.tintColor= [UIColor whiteColor];
    // add search bar to navigation bar
    self.searchBar = [[UISearchBar alloc] init];
    self.navigationItem.titleView = self.searchBar;
    [self.searchBar setShowsCancelButton:YES animated:YES];
    self.searchBar.text = self.queryTerm;
    [self.searchBar setShowsCancelButton:NO animated:YES];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
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
             didChangeFilters:(Filters *)filters {
    NSDictionary *params = filters.setParams;
    [self fetchBusinessWithQuery:self.queryTerm params:params];

    //NSLog(@"Fire a new network event: %@", params);
    
}
#pragma mark - Search bar delegate methods
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar sizeToFit];
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
   [searchBar resignFirstResponder]; // hide keyboard
    self.queryTerm = searchBar.text;
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [self.view endEditing:YES];
    
    [self fetchBusinessWithQuery:self.searchBar.text params:nil];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [self.view endEditing:YES];
    searchBar.text = self.queryTerm;
    [searchBar sizeToFit];
}

#pragma mark - Private methods
- (void)fetchBusinessWithQuery:(NSString *)query params:(NSDictionary *)params{
    [self.client searchWithTerm: query
                         params:params
                        success:^(AFHTTPRequestOperation *operation, id response) {
       // NSLog(@"response: %@", response);
       
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
