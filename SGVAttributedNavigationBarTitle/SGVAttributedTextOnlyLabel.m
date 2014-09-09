//
//  SGVAttributedTextOnlyLabel.m
//  SGVAttributedNavigationBarTitle
//
//  Created by Aleksandr Gusev on 9/3/14.
//  Copyright (c) 2014 sanekgusev. All rights reserved.
//

#import "SGVAttributedTextOnlyLabel.h"

@implementation SGVAttributedTextOnlyLabel

#pragma mark - NSObject

- (Class)class {
    return [[super class] superclass];
}

#pragma mark - UILabel

- (void)setText:(NSString *)text {
}

- (void)setFont:(UIFont *)font {
}

- (void)setTextColor:(UIColor *)textColor {
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
}

@end
