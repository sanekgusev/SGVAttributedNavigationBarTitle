//
//  UINavigationItem+SGVAttributedNavigationBarTitle.m
//  SGVAttributedNavigationBarTitle
//
//  Created by Alexander Gusev on 8/5/14.
//  Copyright (c) 2014 sanekgusev. All rights reserved.
//

#import "UINavigationItem+SGVAttributedNavigationBarTitle.h"
#import <objc/runtime.h>

static void const * const kAttributedTitleKey = &kAttributedTitleKey;

@implementation UINavigationItem (SGVAttributedNavigationBarTitle)

@dynamic sgv_attributedTitle;

- (void)sgv_setAttributedTitle:(NSAttributedString *)attributedTitle {
    objc_setAssociatedObject(self,
                             kAttributedTitleKey,
                             [attributedTitle copy],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.title = [attributedTitle string];
}

- (NSAttributedString *)sgv_attributedTitle {
    return objc_getAssociatedObject(self, kAttributedTitleKey);
}

@end
