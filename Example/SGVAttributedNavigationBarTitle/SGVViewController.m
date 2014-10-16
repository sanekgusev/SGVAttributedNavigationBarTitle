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
@property (weak, nonatomic) IBOutlet UISwitch *attributedTitleSwitch;
@property (weak, nonatomic) IBOutlet UITableViewCell *firstCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *secondCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *thirdCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *fourthCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *nilCell;

@end

@implementation SGVViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCells];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.attributedTitleSwitch setOn:self.navigationController.navigationBar.sgv_attributedTitleEnabled
                             animated:animated];
}

#pragma mark - Private

- (void)setupCells {
    NSAttributedString *georgia = [[NSAttributedString alloc] initWithString:@"Modest Georgia"
                                                                  attributes:@{NSForegroundColorAttributeName : [UIColor blueColor],
                                                                               NSFontAttributeName : [UIFont fontWithName:@"Georgia"
                                                                                                                     size:17.0f]}];
    self.firstCell.textLabel.attributedText = georgia;
    
    NSAttributedString *baskerville = [[NSAttributedString alloc] initWithString:@"Elegant Baskerville"
                                                                      attributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor],
                                                                                   NSFontAttributeName : [UIFont fontWithName:@"Baskerville"
                                                                                                                         size:16.0f]}];
    self.secondCell.textLabel.attributedText = baskerville;
    
    NSAttributedString *chalkduster = [[NSAttributedString alloc] initWithString:@"Kinky Chalkduster"
                                                                      attributes:@{NSForegroundColorAttributeName : [UIColor orangeColor],
                                                                                   NSFontAttributeName : [UIFont fontWithName:@"Chalkduster"
                                                                                                                         size:19.0f]}];
    self.thirdCell.textLabel.attributedText = chalkduster;
    
    NSAttributedString *zapfino = [[NSAttributedString alloc] initWithString:@"Impeccable Zapfino"
                                                                  attributes:@{NSForegroundColorAttributeName : [UIColor purpleColor],
                                                                               NSFontAttributeName : [UIFont fontWithName:@"Zapfino"
                                                                                                                     size:16.0f]}];
    self.fourthCell.textLabel.attributedText = zapfino;
}

#pragma mark - Actions

- (IBAction)attributedTitleSwitchValueChanged {
    self.navigationController.navigationBar.sgv_attributedTitleEnabled = self.attributedTitleSwitch.on;
}

#pragma mark - UITableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        return nil;
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch ([indexPath section]) {
        case 1:{
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            self.navigationItem.sgv_attributedTitle = cell.textLabel.attributedText;
            // TODO: prompt!
            break;
        }
        case 2:
            self.navigationItem.sgv_attributedTitle = nil;
            break;
        default:
            break;
    }
}

@end
