//
//  SGVMixinHelper.m
//  SGVAttributedNavigationBarTitle
//
//  Created by Aleksandr Gusev on 9/4/14.
//  Copyright (c) 2014 sanekgusev. All rights reserved.
//

#import "SGVMixinHelper.h"
#import <objc/runtime.h>

@implementation SGVMixinHelper

+ (Class)classWithName:(NSString *)className
createdByInheritingFromClass:(Class __unsafe_unretained)parent
andMixingInMethodsFromClass:(Class __unsafe_unretained)anotherClass {
    NSCParameterAssert(className);
    NSCParameterAssert(parent);
    NSCParameterAssert(anotherClass);
    if (!className || !parent || !anotherClass) {
        return nil;
    }
    Class __unsafe_unretained anotherClassSuperclass = class_getSuperclass(anotherClass);
    if (![parent isSubclassOfClass:anotherClassSuperclass]) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"parent class should be the subclass of anotherClass' superclass"];
    }
    Class __unsafe_unretained newClass = objc_allocateClassPair(parent,
                                                                [className UTF8String],
                                                                0);
    if (!newClass) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"objc_allocateClassPair() failed, class already exists?"];
    }
    
    unsigned int ivarsCount = 0;
    Ivar *ivars = class_copyIvarList(anotherClass, &ivarsCount);
    free(ivars);
    if (ivarsCount > 0) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"mixing in classes with ivars is not supported."];
    }
    
    unsigned int methodsCount = 0;
    Method *methods = class_copyMethodList(anotherClass,
                                           &methodsCount);
    for (unsigned int i = 0; i < methodsCount; i++) {
        Method method = methods[i];
        BOOL __unused added = class_addMethod(newClass,
                                              method_getName(method),
                                              method_getImplementation(method),
                                              method_getTypeEncoding(method));
        NSCAssert(added, @"Method should be added successfully");
    }
    free(methods);
    
    objc_registerClassPair(newClass);
    
    return newClass;
}

@end
