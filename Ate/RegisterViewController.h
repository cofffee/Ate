//
//  RegisterViewController.h
//  Ate
//
//  Created by Kevin Remigio on 2/23/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Users.h" 

@interface RegisterViewController : UIViewController
@property (nonatomic, strong) Users *user;
- (IBAction)cancelButton:(id)sender;


@end
