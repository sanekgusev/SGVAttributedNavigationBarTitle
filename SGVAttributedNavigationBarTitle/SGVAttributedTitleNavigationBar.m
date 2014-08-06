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

static void const * const kTopNavigationItemKey = &kTopNavigationItemKey;
static void const * const kTitleLabelKey = &kTitleLabelKey;

@implementation SGVAttributedTitleNavigationBar

#pragma mark - Private

-(void)sgv_setTopNavigationItem:(UINavigationItem *)navigationItem {
    objc_setAssociatedObject(self, kTopNavigationItemKey, navigationItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UINavigationItem *)sgv_topNavigationItem {
    return objc_getAssociatedObject(self, kTopNavigationItemKey);
}

- (void)sgv_setTitleLabel:(UILabel *)titleLabel {
    objc_setAssociatedObject(self, kTitleLabelKey, titleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)sgv_titleLabel {
    UILabel *titleLabel = objc_getAssociatedObject(self, kTitleLabelKey);
    if (!titleLabel) {
        titleLabel = [self sgv_titleLabelFromSubviews];
    }
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
            CGPoint labelCenterInBounds = [self convertPoint:label.center fromView:[label superview]];
            CGRect bounds = sel
            if (fabs(.x - CGRectGetMidX([self bounds])) < 2.0) {
                titleLabel = label;
            }
        }
        else {
            titleLabel = [self sgv_titleLabelInView:subview];
        }
        if (titleLabel) {
            *stop = YES;
        }
    }];
    return titleLabel;
}

- (BOOL)sgv_tryApplyAttributedTitle {
    UILabel *titleLabel = [self sgv_titleLabel];
    NSAttributedString *topNavigationItemAttributedTitle = [self sgv_topNavigationItem].sgv_attributedTitle;
    if (titleLabel && topNavigationItemAttributedTitle) {
        titleLabel.attributedText = topNavigationItemAttributedTitle;
        return YES;
    }
    return NO;
}

- (void)sgv_clearTitleLabelReferenceAndSetTopNavigationItem:(UINavigationItem *)topNavigationItem {
    [self sgv_setTitleLabel:nil];
    [self sgv_setTopNavigationItem:topNavigationItem];
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    if ([self sgv_tryApplyAttributedTitle]) {
        [super layoutSubviews];
    }
}

- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
    [self sgv_tryApplyAttributedTitle];
}

#pragma mark - UINavigationItem

- (void)pushNavigationItem:(UINavigationItem *)item animated:(BOOL)animated {
    [super pushNavigationItem:item animated:animated];
    [self sgv_clearTitleLabelReferenceAndSetTopNavigationItem:item];
}

- (UINavigationItem *)popNavigationItemAnimated:(BOOL)animated {
    UINavigationItem *popped = [super popNavigationItemAnimated:animated];
    [self sgv_clearTitleLabelReferenceAndSetTopNavigationItem:[self.items lastObject]];
    return popped;
}

- (void)setItems:(NSArray *)items animated:(BOOL)animated {
    [super setItems:items animated:animated];
    [self sgv_clearTitleLabelReferenceAndSetTopNavigationItem:[items lastObject]];
}

- (void)setItems:(NSArray *)items {
    [super setItems:items];
    [self sgv_clearTitleLabelReferenceAndSetTopNavigationItem:[items lastObject]];
}

@end
