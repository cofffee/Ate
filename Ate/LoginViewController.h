//
//  LoginViewController.h
//  Ate
//
//  Created by Kevin Remigio on 2/22/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Users.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (nonatomic, strong) Users *user;
- (IBAction)cancelButton:(id)sender;

@end
