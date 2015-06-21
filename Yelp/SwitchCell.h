//
//  SwitchCell.h
//  Yelp
//
//  Created by Saker Lin on 2015/6/21.
//  Copyright (c) 2015年 Saker Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchCell;

@protocol SwitchCellDelegate <NSObject>
-(void) switchCell:(SwitchCell *)cell didUpdateValue:(BOOL) value;

@end

@interface SwitchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) BOOL on;
@property (nonatomic, weak) id<SwitchCellDelegate> delegate;

-(void)setOn:(BOOL)on animated:(BOOL) animated;
@end


