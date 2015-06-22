//
//  FiltersViewController.m
//  Yelp
//
//  Created by Saker Lin on 2015/6/21.
//  Copyright (c) 2015年 Saker Lin. All rights reserved.
//

#import "FiltersViewController.h"
#import "Filters.h"
@interface FiltersViewController () <UITableViewDelegate, UITableViewDataSource >

@property (weak, nonatomic) IBOutlet UITableView *tableView;
 
@property(nonatomic, strong) Filters *filters;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *distances;
@property (nonatomic, strong) NSArray *sortBy;
@property (nonatomic, strong) NSMutableSet *selectedCategotries;
@property(nonatomic, strong) NSMutableDictionary *expanded;
@property (nonatomic, strong) UISwitch *mySwitch;
//- (void)initCategories;

@end

@implementation FiltersViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Filters";
        //init filters
        self.filters = [[Filters alloc] initDefault];
        self.selectedCategotries = [NSMutableSet set];
        self.expanded = [NSMutableDictionary dictionary];
        self.mySwitch = [[UISwitch alloc] init];
        [self.mySwitch addTarget:self
                             action:@selector(onmySwitch)
                   forControlEvents:UIControlEventValueChanged];
        
        //[self initCategories];
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(onCancelButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Apply"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(onApplyButton)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"FiltersCell"];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - tableview data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return [self isExpandSection:section] ? self.filters.distances.count : 1;
        case 1:
            return [self isExpandSection:section] ? self.filters.sortBy.count : 1;
        case 2:
            return 1;
        case 3:
            return [self isExpandSection:section] ? self.filters.categories.count : 6;
            
        default:
            return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FiltersCell" forIndexPath:indexPath];
    cell.accessoryView = nil;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSInteger selectedRow;
    switch (section) {
        case 0: {
            
            if ([self isExpandSection:section]) {
                selectedRow = row;
                if (selectedRow == [self.filters.setDistance unsignedIntegerValue]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            } else {
                selectedRow = [self.filters.setDistance unsignedIntegerValue];
                cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropdown"]];
            }
            cell.textLabel.text = self.filters.distances[(NSUInteger) selectedRow][@"key"];
            
            return cell;
        }
        case 1: {
            
            if ([self isExpandSection:section]) {
                selectedRow = row;
                if (selectedRow == [self.filters.setSortBy unsignedIntegerValue]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            } else {
                selectedRow = [self.filters.setSortBy unsignedIntegerValue];
                cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropdown"]];
            }
            cell.textLabel.text = self.filters.sortBy[(NSUInteger) selectedRow][@"key"];
            
            return cell;
        }
            
        case 2: {
            cell.textLabel.text = @"Offering Deals";
            cell.accessoryView = self.mySwitch;
            return cell;
        }
        case 3: {
            if (![self isExpandSection:section] && row == 5) {
                cell.textLabel.text = @"Show All";
                cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropdown"]];
                return cell;
            }
            NSUInteger categoryRow = (NSUInteger) row;
            
            cell.textLabel.text = self.filters.categories[categoryRow][@"key"];
            if ([self.filters.setCategories containsObject:self.filters.categories[categoryRow]]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            return cell;
        }
            
        default:
           return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
   
    switch (section) {
        case 0:
        case 1:
            if ([self isExpandSection:section]) { // collapse section
                [self collapseSection:section selectedRow:indexPath.row];
            } else {
                [self expandSection:section];
            }
            break;
        case 2:
            // select switch instead
            break;
        case 3:
            if (![self isExpandSection:section] && row == 3) {
                [self expandSection:section];
            } else {
                NSUInteger category = (NSUInteger) row;
                [self toggleCategory:category];
            }
            break;
            
        default:
              break;
    }
    
}


- (void)collapseSection:(NSInteger)section selectedRow:(NSInteger)row {
    NSIndexPath *prevSelectedIndexPath;
    switch (section) {
        case 0:
            prevSelectedIndexPath = [NSIndexPath indexPathForRow:[self.filters.setDistance unsignedIntegerValue]
                                                       inSection:section];
            self.filters.setDistance = @(row);
            break;
        case 1:
            prevSelectedIndexPath = [NSIndexPath indexPathForRow:[self.filters.setSortBy unsignedIntegerValue]
                                                       inSection:section];
            self.filters.setSortBy = @(row);
            break;
        default:
            break;
    }
    
    UITableViewCell *prevSelectedCell = [self.tableView cellForRowAtIndexPath:prevSelectedIndexPath];
    prevSelectedCell.accessoryType = UITableViewCellAccessoryNone;
    NSIndexPath *newSelectedIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
    UITableViewCell *newSelectedCell = [self.tableView cellForRowAtIndexPath:newSelectedIndexPath];
    newSelectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    self.expanded[@(section)] = @NO;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:(NSUInteger) section]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (BOOL)isExpandSection:(NSInteger)section {
    return [self.expanded[@(section)] boolValue];
}

- (void)expandSection:(NSInteger)section {
    self.expanded[@(section)] = @YES;
    [self.tableView reloadSections:[NSIndexSet
                                    indexSetWithIndex:(NSUInteger) section]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)toggleCategory:(NSUInteger)categoryIndex {
    
    // find the cell for this category
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:categoryIndex inSection:3];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    // check if already selected
    if ([self.filters.setCategories containsObject:self.filters.categories[categoryIndex]]) {  // already selected -> remove it.
        [self.filters.setCategories removeObject:self.filters.categories[categoryIndex]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        [self.filters.setCategories addObject:self.filters.categories[categoryIndex]]; // add it
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.filters.filterSections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.filters.filterSections[section];
}

- (void)onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onApplyButton {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate filtersViewController:self didChangeFilters: self.filters];
}
- (void)onmySwitch {
    self.filters.setOfferDeals = self.mySwitch.on;
}

@end
