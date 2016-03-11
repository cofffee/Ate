//
//  ViewController.h
//  Ate
//
//  Created by Kevin Remigio on 2/10/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *helloLabel;
- (IBAction)logoutButton:(id)sender;

@end

