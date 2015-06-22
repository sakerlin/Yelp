//
//  Filters.m
//  Yelp
//
//  Created by Saker Lin on 2015/6/21.
//  Copyright (c) 2015年 Saker Lin. All rights reserved.
//

#import "Filters.h"

@interface Filters()

@end

@implementation Filters

- (id)initDefault {
    self = [super init];
    if (self) {
        self.setSortBy = @0;
        self.setOfferDeals = NO;
        self.setDistance = @0;
        self.setCategories = [NSMutableSet set];
        
        self.sortBy = @[
                        @{@"key" : @"Best matched", @"value" : @0},
                        @{@"key" : @"Distance", @"value" : @1},
                        @{@"key" : @"Highest Rated", @"value" : @2}
                        ];
        

        self.distances = @[
                           @{@"key" : @"ALL", @"value" : @0},
                           @{@"key" : @"500 m", @"value" : @500},
                           @{@"key" : @"1 km", @"value" : @1000},
                           @{@"key" : @"2 kms", @"value" : @2000},
                           @{@"key" : @"4 kms", @"value" : @4000},
                           @{@"key" : @"8 kms", @"value" : @8000},
                           ];
        self.filterSections = @[
                                @"Distance",@"Sort By",@"Offering Deals",@"Categories"
                                ];
        
        self.categories = @[
                            @{@"key" : @"Asian Fusion", @"code" : @"asianfusion"},
                            @{@"key" : @"Buffets", @"code" : @"buffets"},
                            @{@"key" : @"Burgers", @"code" : @"burgers"},
                            @{@"key" : @"Cafes", @"code" : @"cafes"},
                            @{@"key" : @"Cheesesteaks", @"code" : @"cheesesteaks"},
                            @{@"key" : @"Chinese", @"code" : @"chinese"},
                            @{@"key" : @"Diners", @"code" : @"diners"},
                            @{@"key" : @"Fast Food", @"code" : @"hotdogs"},
                            @{@"key" : @"Filipino", @"code" : @"filipino"},
                            @{@"key" : @"Fish & Chips", @"code" : @"fishnchips"},
                            @{@"key" : @"Hot Dogs", @"code" : @"hotdog"},
                            @{@"key" : @"Japanese", @"code" : @"japanese"},
                            @{@"key" : @"Pizza", @"code" : @"pizza"},
                            ];
    }
    return self;
}


- (NSDictionary *)setParams {
    NSMutableDictionary *filters = [NSMutableDictionary dictionary];
   
    NSUInteger distanceIndex = [self.setDistance unsignedIntegerValue];
    if (distanceIndex != 0) {
        filters[@"radius_filter"] = self.distances[distanceIndex][@"value"];
    }
    
    NSUInteger sortModeIndex = [self.setSortBy unsignedIntegerValue];
    filters[@"sort"] = self.sortBy[sortModeIndex][@"value"];
    
    if (self.setOfferDeals) {
        filters[@"deals_filter"] = @"1";
    }
    
    if (self.setCategories.count > 0) {
        NSMutableArray *keys = [NSMutableArray array];
        for (NSDictionary *category in self.setCategories) {
            [keys addObject:category[@"code"]];
        }
        NSString *categoryFilter = [keys componentsJoinedByString:@","];
        filters[@"category_filter"] = categoryFilter;
        
    }
    
    return filters;
}




- (id)copyWithZone:(NSZone *)zone {
    Filters *copy = [[Filters allocWithZone:zone] init];
    copy.searchTerm = self.searchTerm;
    copy.setDistance = self.setDistance;
    copy.setSortBy = self.setSortBy;
    copy.setOfferDeals = self.setOfferDeals;
    copy.categories = [self.categories mutableCopy];
    return copy;
}



@end