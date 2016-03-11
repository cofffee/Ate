//
//  Food_List+CoreDataProperties.h
//  Ate
//
//  Created by Kevin Remigio on 2/22/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Food_List.h"

NS_ASSUME_NONNULL_BEGIN

@interface Food_List (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) Food *foods;
@property (nullable, nonatomic, retain) Users *users;

@end

NS_ASSUME_NONNULL_END
