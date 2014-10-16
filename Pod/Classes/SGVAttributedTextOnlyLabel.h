//
//  SGVAttributedTextOnlyLabel.h
//  SGVAttributedNavigationBarTitle
//
//  Created by Aleksandr Gusev on 9/3/14.
//  Copyright (c) 2014 sanekgusev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SGVAttributedTextOnlyLabel;

@protocol SGVAttributedTextOnlyLabelDelegate <NSObject>

- (NSAttributedString *)sgv_attributedTextForAttributedTextOnlyLabel:(SGVAttributedTextOnlyLabel *)label;

@end

@interface SGVAttributedTextOnlyLabel : UILabel

@property (nonatomic, assign, setter=sgv_setDelegate:) id<SGVAttributedTextOnlyLabelDelegate> sgv_delegate;

- (void)sgv_saveTextParameters;
- (void)sgv_restoreTextParameters;

@end
