//
//  Filters.h
//  Yelp
//
//  Created by Saker Lin on 2015/6/21.
//  Copyright (c) 2015年 Saker Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filters : NSObject <NSCopying>

@property(nonatomic, copy) NSString *searchTerm;
@property(nonatomic, strong) NSArray *filterSections;
@property(nonatomic, strong) NSArray *category;
@property(nonatomic, strong) NSArray *sortBy;
@property(nonatomic, strong) NSArray *distances;
@property(nonatomic, strong) NSDictionary *setParams;
@property(nonatomic, strong) NSNumber *setDistance;
@property(nonatomic, strong) NSNumber *setSortBy;
@property(nonatomic, strong) NSMutableSet *setCategories;
@property(nonatomic, assign) BOOL setOfferDeals;

- (id)initDefault;

@end