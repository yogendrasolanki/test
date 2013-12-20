//
//  CustomCell.m
//  DemoTable
//
//  Created by alok patil on 03/07/13.
//  Copyright (c) 2013 Hiteshi . All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize nameLabel;
@synthesize thumbnailImageView;
@synthesize prepTimeLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
