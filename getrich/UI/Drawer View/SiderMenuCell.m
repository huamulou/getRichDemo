//
//  SiderMenuCell.m
//  getrich
//
//  Created by huamulou on 14-10-18.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import "SiderMenuCell.h"
#import "UIImage+Overlay.h"
#import "UIColor+Hex.h"

@implementation SiderMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:
            [UIImage imageWithColor:[UIColor colorWithHexString:@"3b4360"] withSize:self.bounds.size]];

    // Configure the view for the selected state
}

@end
