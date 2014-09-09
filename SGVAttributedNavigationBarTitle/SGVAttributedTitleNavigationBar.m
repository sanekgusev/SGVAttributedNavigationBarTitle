//
//  SGVAttributedTitleNavigationBar.m
//  SGVAttributedNavigationBarTitle
//
//  Created by Alexander Gusev on 8/5/14.
//  Copyright (c) 2014 sanekgusev. All rights reserved.
//

#import "SGVAttributedTitleNavigationBar.h"
#import "UINavigationItem+SGVAttributedNavigationBarTitle.h"
#import <objc/runtime.h>
#import "SGVAttributedTextOnlyLabel.h"
#import "SGVClassModificationHelper.h"

static void const * const kModifiedTitleLabelKey = &kModifiedTitleLabelKey;
static NSString * const kModifiedTitleLabelClassSuffix = @"_SGVAttributedNavigationBarTitle";

@interface SGVAttributedTitleNavigationBar()

@property (nonatomic, strong, setter=sgv_setModifiedTitleLabel:) UILabel *sgv_modifiedTitleLabel;

@end

@implementation SGVAttributedTitleNavigationBar

#pragma mark - Private

- (void)sgv_setModifiedTitleLabel:(UILabel *)titleLabel {
    objc_setAssociatedObject(self, kModifiedTitleLabelKey, titleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)sgv_modifiedTitleLabel {
    UILabel *titleLabel = objc_getAssociatedObject(self, kModifiedTitleLabelKey);
    return titleLabel;
}

- (UILabel *)sgv_titleLabelFromSubviews {
    return [self sgv_titleLabelInView:self];
}

- (UILabel *)sgv_titleLabelInView:(UIView *)view {
    __block UILabel *titleLabel;
    [[view subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *subview = obj;
        if ([subview isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)subview;
            if ([label.text isEqualToString:self.topItem.title]) {
                titleLabel = label;
            }
        }
        if (!titleLabel) {
            titleLabel = [self sgv_titleLabelInView:subview];
        }
        if (titleLabel) {
            *stop = YES;
        }
    }];
    return titleLabel;
}

- (BOOL)sgv_tryApplyAttributedTitle {
    NSAttributedString *topNavigationItemAttributedTitle = [self topItem].sgv_attributedTitle;
    if (!topNavigationItemAttributedTitle) {
        return NO;
    }
    UILabel *titleLabel = [self sgv_titleLabelFromSubviews];
    if (!titleLabel) {
        return NO;
    }
    [self sgv_setModifiedTitleLabel:titleLabel];
    Class __unsafe_unretained titleLabelClass = object_getClass(titleLabel);
    if (![SGVClassModificationHelper isClass:titleLabelClass
                             modifiedWithSuffix:kModifiedTitleLabelClassSuffix
                                  originalClass:NULL]) {
        Class __unsafe_unretained modifiedTitleLabelClass =
        [SGVClassModificationHelper createdOrExistingModifiedClassForClass:titleLabelClass
                                                                withSuffix:kModifiedTitleLabelClassSuffix
                                                      withMethodsFromClass:[SGVAttributedTextOnlyLabel class]];
        object_setClass(titleLabel, modifiedTitleLabelClass);
    }
    titleLabel.text = nil;
    titleLabel.attributedText = topNavigationItemAttributedTitle;
    return YES;
}

- (BOOL)sgv_tryRestoreTitleLabelClass {
    UILabel *titleLabel = [self sgv_modifiedTitleLabel];
    if (!titleLabel) {
        return NO;
    }
    Class __unsafe_unretained titleLabelClass = object_getClass(titleLabel);
    Class __unsafe_unretained originalClass;
    if ([SGVClassModificationHelper isClass:titleLabelClass
                         modifiedWithSuffix:kModifiedTitleLabelClassSuffix
                              originalClass:&originalClass]) {
        object_setClass(titleLabel, originalClass);
        return YES;
    }
    return NO;
}

#pragma mark - Public

- (BOOL)sgv_tryRestoreTitleLabelAppearance {
    BOOL restored = [self sgv_tryRestoreTitleLabelClass];
//    UILabel *titleLabel = [self sgv_titleLabel];
//    titleLabel.text = [titleLabel.attributedText string];
    [self sgv_setModifiedTitleLabel:nil];
    return restored;
}

#pragma mark - NSObject

- (Class)class {
    return [[super class] superclass];
}

#pragma mark - UIView

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    if ([self sgv_tryApplyAttributedTitle]) {
//        [super layoutSubviews];
//    }
//}

- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
    [self sgv_tryRestoreTitleLabelAppearance];
    [self sgv_tryApplyAttributedTitle];
}

#pragma mark - UINavigationItem

- (void)pushNavigationItem:(UINavigationItem *)item animated:(BOOL)animated {
    [super pushNavigationItem:item animated:animated];
    [self sgv_tryRestoreTitleLabelAppearance];
    [self sgv_tryApplyAttributedTitle];
}

- (UINavigationItem *)popNavigationItemAnimated:(BOOL)animated {
    UINavigationItem *popped = [super popNavigationItemAnimated:animated];
    [self sgv_tryRestoreTitleLabelAppearance];
    [self sgv_tryApplyAttributedTitle];
    return popped;
}

- (void)setItems:(NSArray *)items animated:(BOOL)animated {
    [super setItems:items animated:animated];
    [self sgv_tryRestoreTitleLabelAppearance];
    [self sgv_tryApplyAttributedTitle];
}

@end
