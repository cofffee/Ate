//
//  LoginViewController.m
//  Ate
//
//  Created by Kevin Remigio on 2/22/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import "LoginViewController.h"
#import "CoreDataStack.h"
#import "ViewController.h"
#import "WeekViewController.h"
#import "MonthViewController.h"


@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


@end

@implementation LoginViewController

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameField) {
        [self.passwordField becomeFirstResponder];
    } else {
        [self.passwordField resignFirstResponder];
        [self loginButton:self];
    }
    return YES;
}
- (IBAction)clearFields:(id)sender {
    self.usernameField.text = nil;
    self.passwordField.text = nil;
}

- (IBAction)loginButton:(id)sender {
    //Get input from textfields
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    //Get a copy of the database
    CoreDataStack *cds = [CoreDataStack coreDataStack];
    
    //check if user is in database
    if([cds validateUserWithName:username andPass:password]){
        NSLog(@"Yeah you're good");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

        [defaults setBool:YES forKey:@"loggedin"];
        [defaults setObject:self.usernameField.text forKey:@"username"];
        [defaults setObject:self.passwordField.text forKey:@"password"];
        [defaults synchronize];
        
        //Clear name and password from textfield
        self.usernameField.text = nil;
        self.passwordField.text = nil;
        
        [self showMainView];

//        [self presentViewController:vc animated:NO completion:nil];
        
    }
    else {
        NSLog(@"Umm, that dude don't even exist");
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"You have entered the wrong username or password!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *destroyAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//            displayLbl.text = @"Destroy ALert";
        }];
        
        [alert addAction:destroyAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    //if user is in database, flip login boolean to YES so the login/register view controllers aren't presented
}
-(void)showMainView {

    //Show main view viewcontroller
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Set up first view
    ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"mainview"];
    vc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:0];
    UINavigationController *vcNavCtrl = [[UINavigationController alloc] initWithRootViewController:vc];
    //Then second (weeks) view
    WeekViewController *wvc = [storyboard instantiateViewControllerWithIdentifier:@"weekview"];
    wvc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:0];
    UINavigationController *wvcNavCtrl = [[UINavigationController alloc] initWithRootViewController:wvc];
    
    //Then months view
    MonthViewController *mvc = [storyboard instantiateViewControllerWithIdentifier:@"monthview"];
    mvc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:0];
    UINavigationController *mvcNavCtrl = [[UINavigationController alloc] initWithRootViewController:mvc];
    
    //Set up tab controller
    UITabBarController *tabCtrl = [[UITabBarController alloc] init];
    //        self.window.rootViewController = tabCtrl;
    tabCtrl.viewControllers = @[vcNavCtrl, wvcNavCtrl, mvcNavCtrl];
    [self presentViewController:tabCtrl animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
