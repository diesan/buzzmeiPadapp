//
//  ViewController.h
//  buzzMe
//
//  Created by Diego Sanchez on 5/2/15.
//  Copyright (c) 2015 BuzzMe Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuzzMeViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource>{
    
    //Array with users
    NSMutableArray *userList;
    
    //TableView
    UITableView *usersTable;
}

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleInQueueLabel;

@property (weak, nonatomic) IBOutlet UITextField *addUserName;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UITextField *addUserPhoneNumber;

@property (nonatomic,retain) IBOutlet  UITableView *usersTable;

@end

