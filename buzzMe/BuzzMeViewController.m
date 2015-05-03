//
//  ViewController.m
//  buzzMe
//
//  Created by Diego Sanchez on 5/2/15.
//  Copyright (c) 2015 BuzzMe Team. All rights reserved.
//

#import "BuzzMeViewController.h"
#import "buzzUser.h"
#import "customCell.h"
#import "STHTTPRequest.h"
#import "MGSwipeTableCell.h"
#import "MGSwipeButton.h"

#define URL_LOGIN @"http://buzzme.herokuapp.com/clients/sign_in.json"
#define URL_QUEUE @"http://buzzme.herokuapp.com/queue/post_show.json"
#define URL_LIST @"http://buzzme.herokuapp.com/clients.json"

@interface BuzzMeViewController ()

@end

@implementation BuzzMeViewController
{
    NSMutableArray *usersList;
    NSString *tempUserID;
    NSString *tempUsername;
    NSString *tempPhoneNumber;
    
}
@synthesize usersTable,addUserName,addUserPhoneNumber,passwordTextField,emailTextField,loginView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //userList = [NSMutableArray array];
    //userList = [NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
    tempUserID = @"1";
    [self getQueue];
    

}

-(void)getQueue{
    
    @try {
        
        NSLog(@"UserID being sent %@",tempUserID);
        
        
        STHTTPRequest *conn = [STHTTPRequest requestWithURLString:URL_QUEUE];
        
        [conn setHeaderWithName:@"Accept" value:@"application/json"];
        
        conn.POSTDictionary = @{ @"client_id":tempUserID, @"os":@"blad"};
        //@"email":[emailTextField text] , @"password":pass
        
        conn.completionBlock = ^(NSDictionary *headers, NSString *body) {
            
            
            //NSLog(@"RESPUESTA API PARA LOGIN: %@", body);
            
            BOOL success = [self processQueue:body];
            
            NSLog(@"Status of ResponseIsSuccessful");
            NSLog(@"bool %s", success ? "true" : "false");
            
            if (success) {
                
                
                NSLog(@"Success! Captured the list");
                
                [usersTable reloadData];
                
            }
            
            else{
                
            }
            
            
            
        };
        
        
        conn.errorBlock = ^(NSError *error) {
            
            NSLog(@"RESPUESTA error (NEW) : %@", error);
            
            if (error.code==-1009) {
                NSLog(@"User is offline");
                
                
            }
            
            else if (error.code==-1001) {
                NSLog(@"User is offline");
                
            }
            
            else if (error.code==-1005) {
                NSLog(@"User is offline");
                
            }
            
            else if (error.code==202) {
                NSLog(@"Success!");
                
            }
            
            else{
                NSLog(@"Some other error");
            }
            
        };
        
        [conn startAsynchronous];
        
        
        
        //        // Send a synchronous request
        //        NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:URL_QUEUE]];
        //        NSURLResponse * response = nil;
        //        NSError * error = nil;
        //        NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
        //                                              returningResponse:&response
        //                                                          error:&error];
        //
        //        NSLog(response);
        //        NSLog(data);
        //
        //        if (error == nil)
        //        {
        //            // Parse data here
        //        }
        
        
    }
    
    @catch (NSException *exception) {
        
    }
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addUser:(id)sender {
    
    NSLog(@"Adding a new user to the queue");
    
    if(addUserPhoneNumber.text != nil && addUserName.text != nil){
        NSLog(@"Passed fields verification");
        
        [self createNewUser];
        
    }
    
    else{
        NSLog(@"One of the fields is empty");
    }
    
    

    
}

-(void) createNewUser{
    //Creates a new user in the app
    
    
    @try {
        userList = [[NSMutableArray alloc] init];
        
        buzzUser *temp = [[buzzUser alloc] init];
        [temp setUserName: addUserName.text];
        NSLog(@" Adding %@ to the list ", addUserName.text);
        
        [temp setPhoneNumer: addUserPhoneNumber.text];
        NSLog(@" Adding %@ to the list ", addUserPhoneNumber.text);

        [userList addObject:temp];
        
        [usersTable reloadData];
        
        NSLog(@"New length of the list %lu",(unsigned long)[userList count]);
        
    }
    @catch (NSException *exception) {
        NSLog(@"Error when adding the new user to the queue");
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [userList count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    @try {
        static NSString *CellIdentifier = @"customCell";
        customCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(!cell){
            cell = [[customCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            // More initializations if needed.
        }
        
        buzzUser *newUser;
        newUser = [userList objectAtIndex:indexPath.row];
        
        cell.lblUsername.text = [NSString stringWithFormat:@"%@", [newUser userName]];
        return cell;
    }


    @catch (NSException *exception) {
        NSLog(@"Error when setting the user's information on the table");
    }

}



- (IBAction)signInButtonPressed:(id)sender {
    
    
    NSLog(@"Sign In Button Pressed");
    
    loginView.hidden=YES;

    
    @try {
        

        
        
        STHTTPRequest *conn = [STHTTPRequest requestWithURLString:URL_LOGIN];
        
        
        [conn setHeaderWithName:@"Accept" value:@"application/json"];
        
        //Helper *helper = [[Helper alloc] init ];
        
        NSString *pass = [passwordTextField text];
        
        NSLog(@"email %@", [emailTextField text]);
        NSLog(@"password %@", pass);
        //Email or username are both valid for the user to login
        
        //conn.POSTDictionary = @{@"client":@{@"email":[emailTextField text],@"password":[passwordTextField text]}};
        
        
        //conn.POSTDictionary = [NSString stringWithFormat:@"client: %@",@"email: blah@yahoo.com, password: password"] ;
        NSDictionary *client = @{
                                 @"email":@"blah@yahoo.com",
                                 @"password":@"password"
                                 
                                 
                                 };
        
        NSDictionary *params = @{
                                 @"client":client
                                 
                                 };
     
        NSLog(@"PostDictionary %@", params);
        conn.POSTDictionary = params;
        
        
        //NSLog(@"PostDictionary Being sent to API %@",@{@"client":@{@"email":[emailTextField text],@"password":[passwordTextField text]}});
        
       // NSLog(@"PostDictionary Being sent to API %@",[NSString stringWithFormat:@"{client:{ %@",@"email: blah@yahoo.com, password: password}}"]);
        
        
        conn.completionBlock = ^(NSDictionary *headers, NSString *body) {
            
            
            //NSLog(@"RESPUESTA API PARA LOGIN: %@", body);
            
            BOOL success = [self responseIsSuccessful:body];
            
            NSLog(@"Status of ResponseIsSuccessful");
            NSLog(@"bool %s", success ? "true" : "false");
            
            if (success) {
                
              
                
                loginView.hidden=YES;
                
            }
            
            else{

            }
            
            
            
        };
        
        
        conn.errorBlock = ^(NSError *error) {
            
            NSLog(@"RESPUESTA error (NEW) : %@", error);
            
            if (error.code==-1009) {
                NSLog(@"User is offline");
                
           
            }
            
            else if (error.code==-1001) {
                NSLog(@"User is offline");
                
            }
            
            else if (error.code==-1005) {
                NSLog(@"User is offline");
                
            }
            
            else if (error.code==202) {
                NSLog(@"Success!");
                
            }
            
            else{
                NSLog(@"Some other error");
            }
            
        };
        
        [conn startAsynchronous];

        
        
//        // Send a synchronous request
//        NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:URL_QUEUE]];
//        NSURLResponse * response = nil;
//        NSError * error = nil;
//        NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
//                                              returningResponse:&response
//                                                          error:&error];
//        
//        NSLog(response);
//        NSLog(data);
//        
//        if (error == nil)
//        {
//            // Parse data here
//        }
        
        
    }

    @catch (NSException *exception) {
        
    }


}

-(BOOL)responseIsSuccessful:(NSString *)response
{
    NSLog(@"Entered Response check");
    
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    NSError* error;
    NSArray* json2 = [NSJSONSerialization
                          JSONObjectWithData:data
                          
                          options:kNilOptions
                          error:&error];
    NSLog(@" json %@ ",json2);
    
    
    NSDictionary *json = json2[0];
    
    
    
        @try {
            NSLog(@"Entered Try for Response Check");
            
            tempUserID = [json objectForKey:@"id"];
            NSLog(@" Set the userID %@ ",[json objectForKey:@"id"]);
            
             NSLog(@"Step 1");
            
           tempPhoneNumber = [json objectForKey:@"phone_number"];
            NSLog(@" Set the userID %@ ",[json objectForKey:@"phone_number"]);
            
            NSLog(@"Step 2");
            
            
            tempUsername = [json objectForKey:@"name"];
            NSLog(@" Set the userID %@ ",[json objectForKey:@"name"]);
            
            NSLog(@"Step 3");
            
    
            
            return true;
        }
        
        
        @catch (NSException *exception) {
            
            return false;
            
            NSLog(@"Something went wrong.");
            
            
        }
        
        
        
    
    
    
    
    
}


-(BOOL)processQueue:(NSString *)response
{
    NSLog(@"Entered Process Queue");
    
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    NSError* error;
    NSArray* json2 = [NSJSONSerialization
                      JSONObjectWithData:data
                      
                      options:kNilOptions
                      error:&error];
    NSLog(@" json %@ ",json2);
    
    NSArray *myArray  = json2[0];
    
    
    NSDictionary *json = json2[0];
    
    
    
    @try {
        
        int tam = [myArray count];
        
        NSLog(@"Entered Try for the list of Queue");
        
        
        NSLog(@"Array size %i",tam);
        
        NSMutableArray  *usersArray = [NSMutableArray array];

        for(int i=0; i<tam; i++ ){
            
            tempUserID = [json objectForKey:@"id"];
            NSLog(@" Set the userID %@ ",[json objectForKey:@"id"]);
            
            NSLog(@"Step 1");
            
            tempPhoneNumber = [json objectForKey:@"phone_number"];
            NSLog(@" Set the userPhoneNumber %@ ",[json objectForKey:@"phone_number"]);
            
            NSLog(@"Step 2");
            
            
            tempUsername = [json objectForKey:@"name"];
            NSLog(@" Set the userName %@ ",[json objectForKey:@"name"]);
            
            NSLog(@"Step 3");
            
            buzzUser *tempUser = [[buzzUser alloc] init];
            
            [tempUser setUserID:tempUserID];
            [tempUser setPhoneNumer:tempPhoneNumber];
            [tempUser setUserName:tempUsername];
            
            [usersArray addObject:tempUser];
        }
     
        
        
        userList = usersArray;
        
        return true;
    }
    
    
    @catch (NSException *exception) {
        
        return false;
        
        NSLog(@"Something went wrong.");
        
        
    }
    
    
    return true;
    
    
    
    
    
}


//Swipe functions

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    NSLog(@"Entered cellForRowAtIndexPath");
//    static NSString * reuseIdentifier = @"programmaticCell";
//    NSLog(@"Entered cellForRowAtIndexPath1");
//    MGSwipeTableCell * cell = [self.usersTable dequeueReusableCellWithIdentifier:reuseIdentifier];
//    if (!cell) {
//        NSLog(@"Entered cellForRowAtIndexPath2");
//        cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
//    }
//
//    
//    NSLog(@"Entered cellForRowAtIndexPath3");
//    
//  
//    
//
////    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"replyDirectMessage.png"] backgroundColor:[UIColor blackColor]]];
////    NSLog(@"Entered cellForRowAtIndexPath4");
//    
//    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"replyDirectMessage.png"] backgroundColor:[UIColor blackColor] callback:^BOOL(MGSwipeTableCell * sender){
//        
//        NSLog(@"Reply Message Button clicked from the SENT view");
//        
//        @try {
//            
//            
//            
//            int idx=(int) indexPath.row;
//            
//            NSLog(@"index %i",idx);
//            
//            buzzUser *tempUser = [userList objectAtIndex:idx];
//            NSLog(@" User  %@ ", [tempUser userName]);
//            
//            tempUsername = [tempUser userName];
//            
//        }
//        
//        
//        @catch (NSException *exception) {
//            NSLog(@"Something went wront \?/");
//        }
//        
//        return YES;
//    }]];
//    
//    cell.rightSwipeSettings.transition = MGSwipeDirectionRightToLeft;
//    
//
//    cell.textLabel.text = [[cell userName]text];
//    
//        return cell;
//    
//}

//Expandable buttons configuration
-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings
{
    swipeSettings.transition = MGSwipeTransitionBorder;
    expansionSettings.buttonIndex = 0;
    
    
    buzzUser *selectedUser = [userList objectAtIndex:[self.usersTable indexPathForCell:cell]];
    NSLog(@"Selected user: %@", selectedUser);
    
    
    if (direction == MGSwipeDirectionRightToLeft) {
        
        expansionSettings.fillOnTrigger = NO;
        expansionSettings.threshold = 2;
        return @[[MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"directMessage.png"] backgroundColor:[UIColor colorWithRed:0 green:122/255.0 blue:1.0 alpha:1.0] padding:5 callback:^BOOL(MGSwipeTableCell *sender) {
            
            //            MailData * mail = [me mailForIndexPath:[me.tableView indexPathForCell:sender]];
            //            mail.read = !mail.read;
            //            [me updateCellIndicactor:mail cell:(MailTableCell*)sender];
            [cell refreshContentView]; //needed to refresh cell contents while swipping
            
            //change button text
            //            [(UIButton*)[cell.leftButtons objectAtIndex:0] setTitle:[me readButtonText:mail.read] forState:UIControlStateNormal];
            
            NSLog(@"Woooa, nice!");
            
            return YES;
        }]];
    }
    

    
    
    
    return nil;
    
    
}


-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell canSwipe:(MGSwipeDirection) direction;
{
    return YES;
}

-(void) swipeTableCell:(MGSwipeTableCell*) cell didChangeSwipeState:(MGSwipeState)state gestureIsActive:(BOOL)gestureIsActive
{
    NSString * str;
    switch (state) {
        case MGSwipeStateNone: str = @"None"; break;
        case MGSwipeStateSwippingLeftToRight: str = @"SwippingLeftToRight"; break;
        case MGSwipeStateSwippingRightToLeft: str = @"SwippingRightToLeft"; break;
        case MGSwipeStateExpandingLeftToRight: str = @"ExpandingLeftToRight"; break;
        case MGSwipeStateExpandingRightToLeft: str = @"ExpandingRightToLeft"; break;
    }
    NSLog(@"Swipe state: %@ ::: Gesture: %@", str, gestureIsActive ? @"Active" : @"Ended");
}

- (void)tableView: (UITableView*)tableView
  willDisplayCell: (UITableViewCell*)cell
forRowAtIndexPath: (NSIndexPath*)indexPath
{
    int idx=(int)indexPath.row;
    
    NSLog(@"index %i",idx);
    
    buzzUser *selectedUser;
    
    tempUserID = [selectedUser userID];
    NSLog(@"User's ID %@",tempUserID);
}




@end
