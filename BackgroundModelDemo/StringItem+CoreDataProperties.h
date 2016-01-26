//
//  StringItem+CoreDataProperties.h
//  BackgroundModelDemo
//
//  Created by Vincent on 16/1/15.
//  Copyright © 2016年 Vincent. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "StringItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface StringItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *fileData;
@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic, assign) NSInteger itemIndex;
@end

NS_ASSUME_NONNULL_END
