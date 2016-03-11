//
//  RegisterViewController.m
//  Ate
//
//  Created by Kevin Remigio on 2/23/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import "RegisterViewController.h"
#import "CoreDataStack.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)saveUser:(id)sender {
    NSString *username = self.nameField.text;
    NSString *password = self.nameField.text;
    NSString *email = self.emailField.text;
    
    CoreDataStack *cds = [CoreDataStack coreDataStack];
    [cds addUserWithName:username andPass:password andEmail:email];
    [self dismissViewControllerAnimated:YES completion:nil];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
