//
//  CoreDataStack.h
//  Ate
//
//  Created by Kevin Remigio on 2/18/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Users.h"

@interface CoreDataStack : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(CoreDataStack*) coreDataStack;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(NSArray *) getAllFood;
-(NSArray*) getAllUsers;
-(void) addUserWithName:(NSString*)un andPass:(NSString*)pwd andEmail:(NSString*)email;
-(void) deleteUser:(Users *)user;
-(BOOL)validateUserWithName:username andPass:password;
//-(void)addFoodWithName:(NSString*)name andProt:(NSString*)prot andFat:(NSString*)fat andCarb:(NSString*)carb andCal:(NSString*)cal andWater:(NSString*)water andSugar:(NSString*)sug ;
@end
