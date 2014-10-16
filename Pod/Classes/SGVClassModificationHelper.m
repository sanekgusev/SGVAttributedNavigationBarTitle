//
//  SGVClassModificationHelper.m
//  SGVAttributedNavigationBarTitle
//
//  Created by Aleksandr Gusev on 9/4/14.
//  Copyright (c) 2014 sanekgusev. All rights reserved.
//

#import "SGVClassModificationHelper.h"
#import <objc/runtime.h>
#import "SGVMixinHelper.h"

@implementation SGVClassModificationHelper

+ (NSString *)modifiedClassNameForClass:(Class __unsafe_unretained)class
                             withSuffix:(NSString *)suffix {
    NSCParameterAssert(class);
    NSCParameterAssert(suffix);
    if (!class || !suffix) {
        return nil;
    }
    NSString *className = @(class_getName(class));
    return [className stringByAppendingString:suffix];
}

+ (BOOL)isClass:(Class __unsafe_unretained)class
modifiedWithSuffix:(NSString *)suffix
  originalClass:(Class __unsafe_unretained *)originalClass {
    NSCParameterAssert(class);
    NSCParameterAssert(suffix);
    if (!class || !suffix) {
        return NO;
    }
    NSString *className = @(class_getName(class));
    NSUInteger suffixPosition = [className rangeOfString:suffix].location;
    BOOL classIsMofified = suffixPosition == [className length] - [suffix length];
    if (classIsMofified && originalClass) {
        NSString *originalClassName = [className substringToIndex:suffixPosition];
        *originalClass = objc_lookUpClass([originalClassName UTF8String]);
    }
    return classIsMofified;
}

+ (Class)createdOrExistingModifiedClassForClass:(Class __unsafe_unretained)class
                                     withSuffix:(NSString *)suffix
                           withMethodsFromClass:(Class __unsafe_unretained)anotherClass {
    NSCParameterAssert(class);
    NSCParameterAssert(suffix);
    NSCParameterAssert(anotherClass);
    if (!class || !suffix || !anotherClass) {
        return nil;
    }
    NSString *className = @(class_getName(class));
    NSString *modifiedClassName = [className stringByAppendingString:suffix];
    Class __unsafe_unretained modifiedClass = objc_lookUpClass([modifiedClassName UTF8String]);
    if (modifiedClass) {
        return modifiedClass;
    }
    return [SGVMixinHelper classWithName:modifiedClassName
            createdByInheritingFromClass:class
             andMixingInMethodsFromClass:anotherClass];
}

@end
