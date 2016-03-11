//
//  FoodsViewController.m
//  Ate
//
//  Created by Kevin Remigio on 2/10/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import "FoodsViewController.h"
#import "CoreDataStack.h"
#import "Food.h"
#import "Reachability.h"
@interface FoodsViewController () <UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate> {
    NSMutableArray *arrayOfFoods;
//    NSArray *arrayOfNutrients;


}

@property (strong, nonatomic) IBOutlet UITableView *foodsTable;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation FoodsViewController
- (IBAction)saveFood:(id)sender {
    NSString *name = @"bread";
    NSString *protein = @"10";
    NSString *fat = @"10";
    NSString *carb = @"10";
    NSString *calorie = @"10";
    NSString *water = @"10";
    NSString *sugar = @"10";
    CoreDataStack *cds = [CoreDataStack coreDataStack];
//    [cds addFoodWithName:name andProt:protein andFat:fat andCarb:carb andCal:calorie andWater:water andSugar:sugar];
    [self.navigationController popViewControllerAnimated:YES];
}

//Set up behavior of textfields
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.searchTextField resignFirstResponder];
    
//    [self.view addSubview:self.foodsTable];
    [self showTableAnimation];
//    [self downloadData];
    arrayOfFoods = [self downloadData:self.searchTextField.text];
    [self.foodsTable reloadData];
    return YES;
}
//Set up table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//return 4;
    return arrayOfFoods.count;
}

int countt = 0;
//Delegate that gets called if user touches a row
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //REUSABLE CELLS
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"foodcell"];
    
    //Food *food = [[Food alloc] init];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"foodcell"];
        //NSLog(@"%d", countt++);
    }
    //Get nutrient value of each ndbno food
//    NSLog(@"%@", arrayOfFoods);
    cell.textLabel.text = [arrayOfFoods objectAtIndex:indexPath.row];

//    
//    cell.textLabel.text = food.food_name;
//    cell.detailTextLabel.text = nutrient_info;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
//Set up height of rows
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    //arrayOfFoods = @[@"Hello",@"Hello", @"Hello"];
    arrayOfFoods = [[NSMutableArray alloc]init];
    
    //Alloc off screen
    self.foodsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 559, 320, 440)];
    self.foodsTable.dataSource = self;
    self.foodsTable.delegate = self;



   [self.view addSubview:self.foodsTable];

    //[self showTableAnimation];
}

-(void)showTableAnimation {
    self.foodsTable.hidden = NO;
    self.foodsTable.frame = CGRectMake(0, 559, 320, 440);
    self.foodsTable.alpha = 0.1;
    
    [UITableView animateWithDuration:1.0 animations:^{
        self.foodsTable.frame = CGRectMake(0, 127, 320, 440);
        self.foodsTable.alpha = 1.0;
    } completion:nil];
    
    [self.view addSubview:self.foodsTable];
    
}
-(NSMutableArray *)downloadData: (NSString*)search{
    //Access plist
    NSString *str = [[NSBundle mainBundle] pathForResource:@"Global" ofType:@"plist"];
    NSDictionary *globalDictionary = [NSDictionary dictionaryWithContentsOfFile:str];
   
    //Food Search Setup Parameters
    NSString *API_KEY = [globalDictionary objectForKey:@"API_KEY"];
    NSString *q = search;
    NSString *sort = @"r";
    NSString *max = @"15";
    NSString *offset = @"0";
    NSString *format = @"json";
    
    NSString *proteinId = [[globalDictionary objectForKey:@"Food Nutrient IDs"] objectForKey:@"Protein"];
    NSString *fatId = [[globalDictionary objectForKey:@"Food Nutrient IDs"] objectForKey:@"Fats"];
    NSString *carbId = [[globalDictionary objectForKey:@"Food Nutrient IDs"] objectForKey:@"Carbohydrates"];
    NSString *calorieId = [[globalDictionary objectForKey:@"Food Nutrient IDs"] objectForKey:@"Calories"];
    NSString *waterId =[[globalDictionary objectForKey:@"Food Nutrient IDs"] objectForKey:@"Water"];
    
    //Process q to handle spaces
    q = [q stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    
    NSString *foodURL = [NSString stringWithFormat:@"http://api.nal.usda.gov/ndb/search/?format=%@&q=%@&sort=%@&max=%@&offset=%@&api_key=%@", format, q, sort, max, offset, API_KEY];

    NSLog(@"%@", foodURL);
    
    Reachability *internetReachable = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    
    if (internetStatus != NotReachable) {
        NSLog(@"Sorry no internet");
    }
    
    //Initialize food data from the internet!!
    NSData *foodData = [NSData dataWithContentsOfURL:[NSURL URLWithString:foodURL]];
    NSDictionary *foodDictionary = [NSJSONSerialization JSONObjectWithData:foodData options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *arrayNDBNO = [[NSMutableArray alloc] init];
    NSMutableArray *arrayNutrientsURLs = [[NSMutableArray alloc] init];
    
    arrayOfFoods = [[foodDictionary objectForKey:@"list"] objectForKey:@"item"];
    
//    Test print statements
//    NSLog(@"%@", foodURL);
//    NSLog(@"%@", dictionary);
//    NSLog(@"%ld", arrayOfResults.count);
//    Test Statement//NSLog(@"%@", nutrientDictionary);
    
    //GET each food's nbdno
    BOOL firstPass = YES;
    for (NSDictionary *foodDict in arrayOfFoods) {
        
        NSMutableString *nutrientURL = [NSMutableString stringWithFormat:@"http://api.nal.usda.gov/ndb/nutrients/?format=%@&api_key=%@&nutrients=%@&nutrients=%@&nutrients=%@&nutrients=%@&nutrients=%@&ndbno=",format, API_KEY, proteinId, fatId, carbId, calorieId, waterId];
        [arrayNDBNO addObject:[foodDict objectForKey:@"ndbno"]];
        //NSLog(@"%@",[foodDict objectForKey:@"ndbno"]);
        if (!firstPass) {
            //trim last five characters and replace with ndbno
            [nutrientURL replaceCharactersInRange:NSMakeRange([nutrientURL length],0) withString:[foodDict objectForKey:@"ndbno"]];
//            NSLog(@"%@", nutrientURL);
        } else {
            //first pass
            nutrientURL = [NSMutableString stringWithFormat:@"%@%@",nutrientURL,[foodDict objectForKey:@"ndbno"]];
//            NSLog(@"%@", nutrientURL);
            firstPass = NO;
        }
        //Load all nutrient URLs
        [arrayNutrientsURLs addObject:nutrientURL];
    }
    
    //GET array of nutrient dictionaries from each ndbno food search
    NSMutableArray *arrayNutrientDictionary = [[NSMutableArray alloc]init];
    for (NSString *nutURL in arrayNutrientsURLs) {
        
        
        NSData *nutrientData = [NSData dataWithContentsOfURL:[NSURL URLWithString:nutURL]];
        NSDictionary *nutrientDictionary = [NSJSONSerialization JSONObjectWithData:nutrientData options:NSJSONReadingMutableContainers error:nil];
        [arrayNutrientDictionary addObject:nutrientDictionary];
    }
    
    //GET nutrient information about each nbdno
    NSMutableArray *arrayOfNutrients = [[NSMutableArray alloc]init];
    for (NSDictionary *ndbnoDict in arrayNutrientDictionary) {
        [arrayOfNutrients addObject:[[ndbnoDict objectForKey:@"report"] objectForKey:@"foods"]];
        //NSLog(@"%@", ndbnoDict);
    }
    //return arrayOfNutrients;
    
    //Get nutrient value of each ndbno food
    NSMutableArray *arrayOfFoodNames = [[NSMutableArray alloc]init];
//    Food *food = [[Food alloc]init];
    for (NSDictionary *nutDict in arrayOfNutrients) {
        for (NSDictionary *nutArray in nutDict) {
//            NSLog(@"%@", [nutArray objectForKey:@"name"]);
//            Food *food = [[Food alloc]init];
            [arrayOfFoodNames addObject:[nutArray objectForKey:@"name"]];
//            food.food_name = [nutArray objectForKey: @"name"];
//            [arrayOfFoodNames addObject:food];
            NSLog(@"%@", arrayOfFoodNames);
            for (int i = 0; i < 5; i++) {
                NSString *str = [[NSString alloc]initWithFormat:@"%@ %@", [[[nutArray objectForKey:@"nutrients"]objectAtIndex:i] objectForKey:@"nutrient"],[[[nutArray objectForKey:@"nutrients"]objectAtIndex:i] objectForKey:@"value"]];
                NSLog(@"%@", str);
                //[arrayOfFoodNames addObject:str];

            }
        }
    }
 //   NSLog(@"%@", arrayOfFoodNames);
    return arrayOfFoodNames;
    
}
-(void)parseData {
    
}
@end
