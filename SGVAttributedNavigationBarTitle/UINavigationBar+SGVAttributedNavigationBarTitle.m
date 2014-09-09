//
//  UINavigationBar+SGVAttributedNavigationBarTitle.m
//  SGVAttributedNavigationBarTitle
//
//  Created by Alexander Gusev on 8/5/14.
//  Copyright (c) 2014 sanekgusev. All rights reserved.
//

#import "UINavigationBar+SGVAttributedNavigationBarTitle.h"
#import "SGVAttributedTitleNavigationBar.h"
#import "SGVClassModificationHelper.h"
#import <objc/runtime.h>

static NSString * const kModifiedClassSuffix = @"_SGVAttributedNavigationBarTitle";

@implementation UINavigationBar (SGVAttributedNavigationBarTitle)

@dynamic sgv_attributedTitleEnabled;
//@dynamic sgv_defaultAttributedTitleAttributes;

#pragma mark - Properties

- (void)sgv_setAttributedTitleEnabled:(BOOL)attributedTitleEnabled {
    if ([self sgv_attributedTitleEnabled] == !!attributedTitleEnabled) {
        return;
    }
    Class __unsafe_unretained classToBeSet;
    Class __unsafe_unretained currentClass = object_getClass(self);
    if (attributedTitleEnabled) {
        classToBeSet = [SGVClassModificationHelper createdOrExistingModifiedClassForClass:currentClass
                                                                               withSuffix:kModifiedClassSuffix
                                                                     withMethodsFromClass:[SGVAttributedTitleNavigationBar class]];
    }
    else {
        [SGVClassModificationHelper isClass:currentClass
                         modifiedWithSuffix:kModifiedClassSuffix
                              originalClass:&classToBeSet];
        [((SGVAttributedTitleNavigationBar *)self) sgv_tryRestoreTitleLabelAppearance];
    }
    object_setClass(self, classToBeSet);
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (BOOL)sgv_attributedTitleEnabled {
    return [SGVClassModificationHelper isClass:object_getClass(self)
                            modifiedWithSuffix:kModifiedClassSuffix
                                 originalClass:NULL];
}

//- (NSDictionary *)sgv_defaultAttributedTitleAttributes {
//    
//}

@end
