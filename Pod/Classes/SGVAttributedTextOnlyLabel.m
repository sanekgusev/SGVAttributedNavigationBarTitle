//
//  SGVAttributedTextOnlyLabel.m
//  SGVAttributedNavigationBarTitle
//
//  Created by Aleksandr Gusev on 9/3/14.
//  Copyright (c) 2014 sanekgusev. All rights reserved.
//

#import "SGVAttributedTextOnlyLabel.h"
#import <objc/runtime.h>

static void const * const kDelegateKey = &kDelegateKey;

static void const * const kTextKey = &kTextKey;
static void const * const kFontKey = &kFontKey;
static void const * const kTextColorKey = &kTextColorKey;
static void const * const kTextAlignmentKey = &kTextAlignmentKey;
static void const * const kLineBreakModeKey = &kLineBreakModeKey;

@implementation SGVAttributedTextOnlyLabel

@dynamic sgv_delegate;

#pragma mark - Properties

- (id<SGVAttributedTextOnlyLabelDelegate>)sgv_delegate {
    return objc_getAssociatedObject(self, kDelegateKey);
}

- (void)sgv_setDelegate:(id<SGVAttributedTextOnlyLabelDelegate>)delegate {
    objc_setAssociatedObject(self, kDelegateKey, delegate, OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - NSObject

- (Class)class {
    return [[super class] superclass];
}

#pragma mark - UIView

- (void)setFrame:(CGRect)frame {
    CGSize sizeThatFits = [self sizeThatFits:frame.size];
    CGFloat widthDiff = sizeThatFits.width - frame.size.width;
    CGFloat halfDiff = widthDiff / 2.0f;
    frame.origin.x -= halfDiff;
    frame.size.width += widthDiff;
    CGFloat superviewHeight = CGRectGetHeight(self.superview.frame);
    CGFloat desiredHeight = sizeThatFits.height;
    if (desiredHeight > superviewHeight || CGRectGetHeight(frame) > superviewHeight) {
        frame.origin.y = (superviewHeight - desiredHeight) / 2.0f;
        frame.size.height = desiredHeight;
    }
    [super setFrame:CGRectIntegral(frame)];
}

#pragma mark - UILabel

- (void)setText:(NSString *)text {
    [self sgv_saveText:text];
    NSAttributedString *attributedText = [self.sgv_delegate sgv_attributedTextForAttributedTextOnlyLabel:self];
    [self setAttributedText:attributedText];
    
    if (!attributedText) {
        [self sgv_restoreTextParameters];
        [super setText:text];
    }
}

- (void)setFont:(UIFont *)font {
    if (self.attributedText) {
        [self sgv_saveFont:font];
    }
    else {
        [super setFont:font];
    }
}

- (void)setTextColor:(UIColor *)textColor {
    if (self.attributedText) {
        [self sgv_saveTextColor:textColor];
    }
    else {
        [super setTextColor:textColor];
    }
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    if (self.attributedText) {
        [self sgv_saveTextAlignment:textAlignment];
    }
    else {
        [super setTextAlignment:textAlignment];
    }
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
    if (self.attributedText) {
        [self sgv_saveLineBreakMode:self.lineBreakMode];
    }
    else {
        [super setLineBreakMode:lineBreakMode];
    }
}

#pragma mark - Public

- (void)sgv_saveTextParameters {
    [self sgv_saveText:self.text];
    [self sgv_saveFont:self.font];
    [self sgv_saveTextColor:self.textColor];
    [self sgv_saveTextAlignment:self.textAlignment];
    [self sgv_saveLineBreakMode:self.lineBreakMode];
}

- (void)sgv_restoreTextParameters {
    NSString *text = objc_getAssociatedObject(self, kTextKey);
    [super setText:text];
    UIFont *font = objc_getAssociatedObject(self, kFontKey);
    [super setFont:font];
    UIColor *textColor = objc_getAssociatedObject(self, kTextColorKey);
    [super setTextColor:textColor];
    NSTextAlignment textAignment = [objc_getAssociatedObject(self, kTextAlignmentKey) integerValue];
    [super setTextAlignment:textAignment];
    NSLineBreakMode lineBreakMode = [objc_getAssociatedObject(self, kLineBreakModeKey) integerValue];
    [super setLineBreakMode:lineBreakMode];
}

#pragma mark - Private

- (void)sgv_saveText:(NSString *)text {
    objc_setAssociatedObject(self, kTextKey, text, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)sgv_saveFont:(UIFont *)font {
    objc_setAssociatedObject(self, kFontKey, font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sgv_saveTextColor:(UIColor *)textColor {
    objc_setAssociatedObject(self, kTextColorKey, textColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sgv_saveTextAlignment:(NSTextAlignment)textAlignment {
    objc_setAssociatedObject(self, kTextAlignmentKey, @(textAlignment), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sgv_saveLineBreakMode:(NSLineBreakMode)lineBreakMode {
    objc_setAssociatedObject(self, kLineBreakModeKey, @(lineBreakMode), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
