//
//  FiltersViewController.m
//  Yelp
//
//  Created by Saker Lin on 2015/6/21.
//  Copyright (c) 2015年 Saker Lin. All rights reserved.
//

#import "FiltersViewController.h"
#import "SwitchCell.h"
@interface FiltersViewController () <UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, readonly) NSDictionary *filters;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSMutableSet *selectedCategotries;
- (void)initCategories;

@end

@implementation FiltersViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.selectedCategotries = [NSMutableSet set];
        [self initCategories];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil]forCellReuseIdentifier:@"SwitchCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - tableview data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
    cell.titleLabel.text = self.categories[indexPath.row][@"name"];
    cell.on = [self.selectedCategotries containsObject:self.categories[indexPath.row]];
    cell.delegate = self;
    return cell;
}

#pragma mark - switch cell delegate  methods
- (void) switchCell:(SwitchCell *)cell didUpdateValue:(BOOL)value{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if(value){
        [self.selectedCategotries addObject:self.categories [indexPath.row]];
    }else{
        [self.selectedCategotries removeObject:self.categories [indexPath.row]];
    }
}
#pragma mark - private methods
- (NSDictionary *)filters{
    NSMutableDictionary *filters = [NSMutableDictionary dictionary];
    if(self.selectedCategotries.count >0){
        NSMutableArray *names = [NSMutableArray array];
        for(NSDictionary *category in self.selectedCategotries){
            [names addObject:category[@"name"]];
        }
        NSString *categoryFilter = [names componentsJoinedByString:@","];
        [filters setObject:categoryFilter forKey:@"category_filter"];
    }
    return filters;
}
- (void)onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onApplyButton {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate filtersViewController:self didChangeFilters:self.filters];
}

- (void)initCategories{
     self.categories =
      @[@{@"name":@"afghan1",@"code":@"afghani-a"},
        @{@"name":@"afghan2",@"code":@"afghani-b"},
        @{@"name":@"afghan3",@"code":@"afghani-c"},
        @{@"name":@"British",@"code":@"british"},
        @{@"name":@"British",@"code":@"british"},
        @{@"name":@"Buffets",@"code":@"bufferts"},
        @{@"name":@"bulgarian",@"code":@"bulgarian"},
        @{@"name":@"Burgers",@"code":@"burgers"} 
       ];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
