//
//  Users+CoreDataProperties.h
//  Ate
//
//  Created by Kevin Remigio on 2/22/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Users.h"

NS_ASSUME_NONNULL_BEGIN

@interface Users (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSString *user_email;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSSet<Food_List *> *food_list;
@property (nullable, nonatomic, retain) NSSet<Food *> *foods;

@end

@interface Users (CoreDataGeneratedAccessors)

- (void)addFood_listObject:(Food_List *)value;
- (void)removeFood_listObject:(Food_List *)value;
- (void)addFood_list:(NSSet<Food_List *> *)values;
- (void)removeFood_list:(NSSet<Food_List *> *)values;

- (void)addFoodsObject:(Food *)value;
- (void)removeFoodsObject:(Food *)value;
- (void)addFoods:(NSSet<Food *> *)values;
- (void)removeFoods:(NSSet<Food *> *)values;

@end

NS_ASSUME_NONNULL_END
