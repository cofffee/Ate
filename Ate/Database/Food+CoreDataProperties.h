//
//  Food+CoreDataProperties.h
//  Ate
//
//  Created by Kevin Remigio on 2/22/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Food.h"

NS_ASSUME_NONNULL_BEGIN

@interface Food (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *food_calories;
@property (nullable, nonatomic, retain) NSString *food_carbohydrate;
@property (nullable, nonatomic, retain) NSString *food_fat;
@property (nullable, nonatomic, retain) NSString *food_name;
@property (nullable, nonatomic, retain) NSString *food_protein;
@property (nullable, nonatomic, retain) NSString *food_sugar;
@property (nullable, nonatomic, retain) NSString *food_water;
@property (nullable, nonatomic, retain) NSDate *time;
@property (nullable, nonatomic, retain) NSSet<Food_List *> *foods_list;
@property (nullable, nonatomic, retain) Users *users;

@end

@interface Food (CoreDataGeneratedAccessors)

- (void)addFoods_listObject:(Food_List *)value;
- (void)removeFoods_listObject:(Food_List *)value;
- (void)addFoods_list:(NSSet<Food_List *> *)values;
- (void)removeFoods_list:(NSSet<Food_List *> *)values;

@end

NS_ASSUME_NONNULL_END
