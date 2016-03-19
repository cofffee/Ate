//
//  ViewController.m
//  Ate
//
//  Created by Kevin Remigio on 2/10/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataStack.h"
#import "Food.h"

@interface ViewController () {

    NSMutableArray *foodsArray;
}

@property (nonatomic, strong) UIView *titleView;
@property (strong, nonatomic) IBOutlet UITableView *foodsTable;


@end

@implementation ViewController
- (IBAction)logoutButton:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"loggedin"];
    [defaults synchronize];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self showMainScreen];
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIViewController *appRootViewController = window.rootViewController;
    UIViewController *topViewController = appRootViewController;
    while (topViewController.modalViewController != nil) {
        topViewController = topViewController.modalViewController;
        NSLog(@"%@",topViewController);
    }
    

}
-(void)showMainScreen {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *pv = [storyboard instantiateViewControllerWithIdentifier:@"premain"];
    
    [self presentViewController:pv animated:YES completion:nil];
//    self.window.rootViewController = pv;
//    [self.window makeKeyAndVisible];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    foodsArray = @[@"Hello",@"Hello", @"Hello"];
    foodsArray = [[NSMutableArray alloc]init];
    
    //Alloc off screen
    self.foodsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.foodsTable.dataSource = self;
    self.foodsTable.delegate = self;
    
    //For reusable cells
//    [self.foodsTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //Display the table
    [self.view addSubview:self.foodsTable];

}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [foodsArray removeAllObjects];
    
    CoreDataStack *dataStack = [CoreDataStack coreDataStack];
//    
    [foodsArray addObjectsFromArray:[dataStack getAllFood]];
//    
//    [self.foodsTable reloadData];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return foodsArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
int count = 0;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //REUSABLE CELLS
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        NSLog(@"%d", count++);
    }
    Food *food = [foodsArray objectAtIndex:indexPath.row];
    NSString *nutrient_info = [NSString stringWithFormat:@"Energy: %@ Protein: %@ Carbohydrates: %@ Fat: %@ Sugar: %@ Water: %@",food.food_calories,food.food_protein, food.food_carbohydrate, food.food_fat,food.food_sugar,food.food_water];
    
    cell.textLabel.text = food.food_name;
    cell.detailTextLabel.text = nutrient_info;
    cell.accessoryType = UITableViewCellAccessoryDetailButton;

    cell.backgroundColor = [UIColor colorWithRed:231/255.0 green:112/255.0 blue:52/255.0 alpha:1];
    cell.textLabel.textColor = [UIColor blackColor];
    
    //Set highlighted color
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:47/255.0 green:74/255.0 blue:255/255.0 alpha:1];
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
}
//Set up height of rows
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200.0;
    NSSet
}

-(void)showTitleViewAnimation {

    
}

@end
