//
//  SGVViewController.m
//  SGVAttributedNavigationBarTitle
//
//  Created by Alexander Gusev on 8/5/14.
//  Copyright (c) 2014 sanekgusev. All rights reserved.
//

#import "SGVViewController.h"
#import "UINavigationItem+SGVAttributedNavigationBarTitle.h"

@interface SGVViewController ()

@end

@implementation SGVViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:@"Test"
                                                                                            attributes:@{NSForegroundColorAttributeName : [UIColor greenColor],
                                                                                                         NSFontAttributeName : [UIFont fontWithName:@"Georgia"
                                                                                                                                               size:12.0f]}];
        self.navigationItem.sgv_attributedTitle = attributedTitle;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:@"Test"
                                                                                            attributes:@{NSForegroundColorAttributeName : [UIColor greenColor],
                                                                                                         NSFontAttributeName : [UIFont fontWithName:@"Georgia"
                                                                                                                                               size:12.0f]}];
        self.navigationItem.sgv_attributedTitle = attributedTitle;
    }
    return self;
}

@end
