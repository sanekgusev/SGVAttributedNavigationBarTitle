//
//  UINavigationBar+SGVAttributedNavigationBarTitle.m
//  SGVAttributedNavigationBarTitle
//
//  Created by Alexander Gusev on 8/5/14.
//  Copyright (c) 2014 sanekgusev. All rights reserved.
//

#import "UINavigationBar+SGVAttributedNavigationBarTitle.h"
#import <objc/runtime.h>

static NSString * const kModifiedClassSuffix = @"_SGVAttributedNavigationBarTitle";

static NSMutableDictionary *kClassToModifiedClassDictionary = nil;
static NSMutableSet *kModifiedClasses = nil;

@implementation UINavigationBar (SGVAttributedNavigationBarTitle)

@dynamic sgv_attributedTitleEnabled;

#pragma mark - Properties

- (void)sgv_setAttributedTitleEnabled:(BOOL)sgv_attributedTitleEnabled {
    if ([self sgv_attributedTitleEnabled]) {
        return;
    }
    Class modifiedClass = [UINavigationBar sgv_classToModifiedClassDictionary][(id<NSCopying>)object_getClass(self)];
    if (!modifiedClass) {
        modifiedClass = [UINavigationBar sgv_createModifiedClass];
    }
    object_setClass(self, modifiedClass);
}

- (BOOL)sgv_attributedTitleEnabled {
    return [kModifiedClasses containsObject:(id)object_getClass(self)];
}

#pragma mark - Private

+ (NSMutableDictionary *)sgv_classToModifiedClassDictionary {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kClassToModifiedClassDictionary = [NSMutableDictionary new];
    });
    return kClassToModifiedClassDictionary;
}

+ (NSMutableSet *)sgv_modifiedClasses {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kModifiedClasses = [NSMutableSet new];
    });
    return kModifiedClasses;
}

+ (Class)sgv_createModifiedClass {
    Class originalClass = object_getClass(self);
    const char *modifiedClassName = [[@(class_getName(originalClass)) stringByAppendingString:kModifiedClassSuffix] UTF8String];
    Class modifiedClass = objc_allocateClassPair(originalClass,
                                                 modifiedClassName,
                                                 0);

    // TODO: add methods

    objc_registerClassPair(modifiedClass);

    [UINavigationBar sgv_classToModifiedClassDictionary][(id<NSCopying>)originalClass] = modifiedClass;
    [[UINavigationBar sgv_modifiedClasses] addObject:modifiedClass];

    return modifiedClass;
}

@end
