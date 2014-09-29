//
//  SGVViewController.m
//  SGVAttributedNavigationBarTitle
//
//  Created by Alexander Gusev on 8/5/14.
//  Copyright (c) 2014 sanekgusev. All rights reserved.
//

#import "SGVViewController.h"
#import "UINavigationItem+SGVAttributedNavigationBarTitle.h"
#import "UINavigationBar+SGVAttributedNavigationBarTitle.h"

@interface SGVViewController ()

@end

@implementation SGVViewController

- (id)initWithAttributedTitle:(NSAttributedString *)attributedTitle {
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        [self commonInitializationWithAttributedTitle:attributedTitle];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:@"Test"
                                                                                            attributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor],
                                                                                                         NSFontAttributeName : [UIFont fontWithName:@"Georgia"
                                                                                                                                               size:17.0f]}];
        [self commonInitializationWithAttributedTitle:attributedTitle];
    }
    return self;
}

- (void)commonInitializationWithAttributedTitle:(NSAttributedString *)attributedTitle {
    self.navigationItem.sgv_attributedTitle = attributedTitle;
}

- (IBAction)buttonAction {
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:@"Pretty Long Title"
                                                                                        attributes:@{NSForegroundColorAttributeName : [UIColor blueColor],
                                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:17.0f]}];
    SGVViewController *newViewController = [[SGVViewController alloc] initWithAttributedTitle:attributedTitle];
    [self.navigationController pushViewController:newViewController animated:YES];
}
- (IBAction)disableAction {
    self.navigationController.navigationBar.sgv_attributedTitleEnabled = NO;
}
- (IBAction)enableAction {
    self.navigationController.navigationBar.sgv_attributedTitleEnabled = YES;
}
- (IBAction)grayAction {
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:@"Gray Georgia"
                                                                                        attributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor],
                                                                                                     NSFontAttributeName : [UIFont fontWithName:@"Georgia"
                                                                                                                                           size:17.0f]}];
    self.navigationItem.sgv_attributedTitle = attributedTitle;
}
- (IBAction)pinkAction {
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:@"Big Pink Georgia"
                                                                                        attributes:@{NSForegroundColorAttributeName : [UIColor purpleColor],
                                                                                                     NSFontAttributeName : [UIFont fontWithName:@"Georgia"
                                                                                                                                           size:20.0f]}];
    self.navigationItem.sgv_attributedTitle = attributedTitle;
}
- (IBAction)nilAction {
    self.navigationItem.sgv_attributedTitle = nil;
}

@end
