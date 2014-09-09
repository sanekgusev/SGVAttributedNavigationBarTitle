//
//  SGVClassModificationHelper.h
//  SGVAttributedNavigationBarTitle
//
//  Created by Aleksandr Gusev on 9/4/14.
//  Copyright (c) 2014 sanekgusev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGVClassModificationHelper : NSObject

+ (NSString *)modifiedClassNameForClass:(Class __unsafe_unretained)class
    withSuffix:(NSString *)suffix;

+ (BOOL)isClass:(Class __unsafe_unretained)class
modifiedWithSuffix:(NSString *)suffix
originalClass:(Class __unsafe_unretained *)originalClass;

+ (Class)createdOrExistingModifiedClassForClass:(Class __unsafe_unretained)class
withSuffix:(NSString *)suffix withMethodsFromClass:(Class __unsafe_unretained)anotherClass;

@end
