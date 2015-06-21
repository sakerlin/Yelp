//
//  SwitchCell.m
//  Yelp
//
//  Created by Saker Lin on 2015/6/21.
//  Copyright (c) 2015年 Saker Lin. All rights reserved.
//

#import "SwitchCell.h"
@interface SwitchCell ()


@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;
- (IBAction)swithValueChanged:(id)sender;

@end

@implementation SwitchCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)swithValueChanged:(id)sender {
    [self.delegate switchCell:self didUpdateValue:self.toggleSwitch.on ];
}


-(void) setOn:(BOOL)on {
    [self setOn:on animated:NO];
}
-(void)setOn:(BOOL)on animated:(BOOL) animated {
    _on = on;
    [self.toggleSwitch setOn:on animated:animated];
}
@end
