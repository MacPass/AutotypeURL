//
//  MPHSettingsViewController.m
//  MacPassHTTP
//
//  Created by Michael Starke on 11/11/15.
//  Copyright © 2015 HicknHack Software GmbH. All rights reserved.
//

#import "MPATUSettingsViewController.h"
#import "ATUAutotypeURL.h"



@interface MPATUSettingsViewController ()

//@property (weak) IBOutlet NSTextField *portTextField;
//@property (weak) IBOutlet NSButton *showMenuItemCheckButton;
//@property (weak) IBOutlet NSButton *showNotificationsCheckButton;
//@property (weak) IBOutlet NSButton *allowRemoteConnectionCheckButton;
//@property (strong) IBOutlet NSButton *includeCustomFieldsInResultsButton;
//
//- (IBAction)clearKeys:(id)sender;
//- (IBAction)clearPermissions:(id)sender;

//
@property (weak) IBOutlet NSMenuItem *urlDomain;
@property (weak) IBOutlet NSMenuItem *urlSubDomain;
@property (weak) IBOutlet NSMenuItem *urlComplete;



@property (weak) IBOutlet NSButton *allowSafari;
@property (weak) IBOutlet NSButton *allowChrome;

- (IBAction)resetDefaults:(id)sender;
//


@end

@implementation MPATUSettingsViewController





- (void)dealloc {
  NSLog(@"%@ dealloc", [self class]);
//  [self.portTextField unbind:NSValueBinding];
//  [self.showMenuItemCheckButton unbind:NSValueBinding];
}

- (NSBundle *)nibBundle {
  return [NSBundle bundleForClass:[self class]];
}

- (NSString *)nibName {
  return @"MPATUAutotype";
}

- (void)awakeFromNib {
  static BOOL didAwake = NO;
  if(!didAwake) {
    NSUserDefaultsController *defaultsController = [NSUserDefaultsController sharedUserDefaultsController];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.allowsFloats = NO;
    formatter.alwaysShowsDecimalSeparator = NO;
    
    
    [self.allowSafari bind:NSValueBinding
                              toObject:defaultsController
                           withKeyPath:[NSString stringWithFormat:@"values.%@", kSettingsAllowSafari]
                               options:nil];
    [self.allowChrome bind:NSValueBinding
                                   toObject:defaultsController
                                withKeyPath:[NSString stringWithFormat:@"values.%@", kSettingsAllowChrome]
                                    options:nil];
    [self.urlDomain bind:NSValueBinding
                                   toObject:defaultsController
                                withKeyPath:[NSString stringWithFormat:@"values.%@", kSettingsURLDomain]
                                    options:nil];
    [self.urlSubDomain bind:NSValueBinding
                                         toObject:defaultsController
                                      withKeyPath:[NSString stringWithFormat:@"values.%@", kSettingsURLSubDomain]
                                          options:nil];
    [self.urlComplete bind:NSValueBinding
                   toObject:defaultsController
                withKeyPath:[NSString stringWithFormat:@"values.%@", kSettingsURLCompleteDomain]
                    options:nil];
    didAwake = YES;
  }
}
- (IBAction)resetDefaults:(id)sender {
  //[self.plugin resetDefaults];
}


@end
