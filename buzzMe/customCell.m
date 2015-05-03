//
//  customCell.m
//  buzzMe
//
//  Created by Diego Sanchez on 5/2/15.
//  Copyright (c) 2015 BuzzMe Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "customCell.h"

@implementation customCell

@synthesize lblUsername,lblPhoneNumber;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


@end