//
//  ATUSettingsViewController.m
//  AutotypeURL
//
//  Created by George Snow on 7/10/19.
//  Copyright © 2019 George Snow All rights reserved.
//

#import "ATUSettingsViewController.h"
#import "ATUAutotypeURL.h"

@interface ATUSettingsViewController ()

@property (strong) IBOutlet NSButton *useCompleteURLAsWindowTitleButton;
@property (strong) IBOutlet NSButton *useURLHostAsWindowTitleButton;

- (IBAction)toggleWindowTitleBehaviour:(id)sender;

@end

@implementation ATUSettingsViewController

- (void)dealloc {
  [self.useCompleteURLAsWindowTitleButton unbind:NSValueBinding];
}

- (NSBundle *)nibBundle {
  return [NSBundle bundleForClass:self.class];
}

- (NSString *)nibName {
  return @"AutotypeURLSettings";
}

- (void)viewDidLoad {
  BOOL useCompletURL = [NSUserDefaults.standardUserDefaults boolForKey:kMPASettingsKeyFullMatch];
  if(useCompletURL) {
    self.useCompleteURLAsWindowTitleButton.state = NSOnState;
    self.useURLHostAsWindowTitleButton.state = NSOffState;
  }
  else {
    self.useCompleteURLAsWindowTitleButton.state = NSOffState;
    self.useURLHostAsWindowTitleButton.state = NSOnState;
  }
}

- (void)toggleWindowTitleBehaviour:(id)sender {
  BOOL useCompletURL = self.useCompleteURLAsWindowTitleButton.state == NSOnState;
  [NSUserDefaults.standardUserDefaults setBool:useCompletURL forKey:kMPASettingsKeyFullMatch];
}


@end


