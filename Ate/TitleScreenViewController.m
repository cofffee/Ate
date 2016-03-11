//
//  TitleScreenViewController.m
//  Ate
//
//  Created by Kevin Remigio on 2/10/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import "TitleScreenViewController.h"
#import "LoginViewController.h"

@interface TitleScreenViewController ()

@property (nonatomic, strong) UIView *titleView;

@end

@implementation TitleScreenViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(20, -369, 280, 397)];
    self.titleView.backgroundColor = [UIColor purpleColor];
    
//    self.goButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 433, 280, 115)];
//    [self.view addSubview:self.goButton];
    
    [self.view addSubview:self.titleView];
    [self showTitleViewAnimation];
}
-(void)showTitleViewAnimation {
    self.titleView.hidden = NO;
    self.titleView.frame = CGRectMake(20, -369, 280, 397);
    self.titleView.alpha = 0.1;
    
    [UITableView animateWithDuration:3.5 animations:^{
        self.titleView.frame = CGRectMake(20, 28, 280, 457);
        self.titleView.alpha = 1.0;
    } completion:nil];
    
    [self.view addSubview:self.titleView];
    
}
-(void)showGoButtonAnimation {
    
}
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    LoginViewController *vc = [segue destinationViewController];
//    if([segue.identifier isEqualToString:@"register"]){
//        vc.title = @"Register";
//        vc.userTextField.text = @"Kevin";
////        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
////        vc.user = [arrayOfUsers objectAtIndex:indexPath.row];
//    }
//    else {
//        vc.title = @"Login";
//    }
//    
//}
@end




