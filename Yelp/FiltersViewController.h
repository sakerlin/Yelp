//
//  FiltersViewController.h
//  Yelp
//
//  Created by Saker Lin on 2015/6/21.
//  Copyright (c) 2015年 Saker Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FiltersViewController;
@protocol FiltersViewControllerDelegate <NSObject>

- (void)filtersViewController:(FiltersViewController *)
    filtersViewController didChangeFilters:(NSDictionary *)filters;
@end

@interface FiltersViewController : UIViewController
@property (nonatomic, weak) id<FiltersViewControllerDelegate> delegate;
@end
