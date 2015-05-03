//
//  user.h
//  buzzMe
//
//  Created by Diego Sanchez on 5/2/15.
//  Copyright (c) 2015 BuzzMe Team. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface buzzUser : NSObject{
    
    NSString *userID;
    NSString *userName;
    NSString *reservationSize;
    NSString *phoneNumer;
    NSString *status;

    
}

@property(nonatomic,strong) NSString *userID;
@property(nonatomic,strong) NSString *userName;
@property(nonatomic,strong) NSString *reservationSize;
@property(nonatomic,strong) NSString *status;
@property(nonatomic,strong) NSString *phoneNumer;


@end
