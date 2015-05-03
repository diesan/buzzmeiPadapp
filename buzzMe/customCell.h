//
//  customCell.h
//  buzzMe
//
//  Created by Diego Sanchez on 5/2/15.
//  Copyright (c) 2015 BuzzMe Team. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol customCellDelegate;

@interface customCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNumber;



@end