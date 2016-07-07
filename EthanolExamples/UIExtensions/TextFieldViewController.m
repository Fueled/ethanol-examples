//
//  TextFieldViewController.m
//  Ethanol Example
//
//  Created by Stephane Copin on 3/20/14.
//  Copyright (c) 2015 Fueled Digital Media, LLC.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "TextFieldViewController.h"

@import EthanolValidationFormatting;
@import EthanolUIComponents;
@import EthanolUIExtensions;
@import EthanolTools;

static NSString * const kCellIdentifier = @"Cell";

@interface TextFieldViewController () <ETHTextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;
@property (weak, nonatomic) IBOutlet UITableView * formatterTableView;
@property (weak, nonatomic) IBOutlet UITableView * validatorTableView;
@property (weak, nonatomic) IBOutlet UITableView * charactersTableView;
@property (weak, nonatomic) IBOutlet ETHTextField * textField;

@property (nonatomic, strong) NSIndexPath * formatterSelectedIndexPath;
@property (nonatomic, strong) NSIndexPath * validatorSelectedIndexPath;
@property (nonatomic, strong) NSIndexPath * allowedCharactersSelectedIndexPath;
@property (nonatomic, strong) NSArray * formatters;
@property (nonatomic, strong) NSArray * validators;
@property (nonatomic, strong) NSArray * allowedCharacters;

@end

@implementation TextFieldViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.formatterTableView.tableFooterView = [[UIView alloc] init];
  self.validatorTableView.tableFooterView = [[UIView alloc] init];
  self.charactersTableView.tableFooterView = [[UIView alloc] init];
  
  [self.formatterTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
  [self.validatorTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
  [self.charactersTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
  
  [self handleKeyboardNotifications];
  
  [self eth_registerForKeyboardNotificationsWithHandler:^(BOOL showing, KeyboardNotificationState state, CGRect beginRect, CGRect endRect, NSTimeInterval duration, UIViewAnimationOptions options) {
    switch (state) {
      case KeyboardNotificationStateDidShow:
        self.view.backgroundColor = [UIColor redColor];
        break;
      case KeyboardNotificationStateWillShow:
        self.view.backgroundColor = [UIColor greenColor];
        break;
      case KeyboardNotificationStateWillHide:
        self.view.backgroundColor = [UIColor blueColor];
        break;
      case KeyboardNotificationStateDidHide:
      default:
        self.view.backgroundColor = [UIColor whiteColor];
        break;
    }
  }];
  
  self.validators = @[[ETHNonemptyValidator validator],
                      [ETHSelectorValidator validatorWithSelector:@selector(eth_isValidEmail) error:@"This is not a valid email"],
                      [ETHBlockValidator validatorWithBlock:^BOOL(ETHBlockValidator * validator, id object, NSString **errorMessage) {
                        NSString * string = object;
                        if([string rangeOfString:@"Ethanol"].location != NSNotFound) {
                          return YES;
                        }
                        *errorMessage = @"String does not contain Ethanol";
                        return NO;
                      }],
                      [ETHUSAStateValidator validator]];
  self.formatters = @[[ETHCreditCardNumberFormatter formatter],
                      [ETHCreditCardExpirationDateFormatter formatter]];
  self.allowedCharacters = @[@{@"title": @"Everything",
                               @"characters": [NSNull null]},
                             @{@"title": @"Alphanumeric",
                               @"characters": [NSCharacterSet alphanumericCharacterSet]},
                             @{@"title": @"Whitespace character set",
                               @"characters": [NSCharacterSet whitespaceCharacterSet]},
                             @{@"title": @"Alphanumeric + Whitespace",
                               @"characters": ({ NSMutableCharacterSet * set = [NSMutableCharacterSet alphanumericCharacterSet]; [set formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]]; set; })},
                             @{@"title": @"Numeric",
                               @"characters": [NSCharacterSet decimalDigitCharacterSet]},
                             @{@"title": @"Letter",
                               @"characters": [NSCharacterSet letterCharacterSet]},
                             @{@"title": @"Decomposable",
                               @"characters": [NSCharacterSet decomposableCharacterSet]},
                             @{@"title": @"Illegal",
                               @"characters": [NSCharacterSet illegalCharacterSet]},
                             @{@"title": @"Punctuation",
                               @"characters": [NSCharacterSet punctuationCharacterSet]},
                             @{@"title": @"Symbols",
                               @"characters": [NSCharacterSet symbolCharacterSet]}];
  
  self.textField.maximumLength = 20;
}

- (void)handleKeyboardNotifications {
  [self.validatorTableView eth_handleKeyboardNotifications];
  [self.formatterTableView eth_handleKeyboardNotifications];
  
  // Example to show how notificatin can be read on any NSObject for custom changes
  [self eth_registerForKeyboardNotificationsWithHandler:^(BOOL show, KeyboardNotificationState state, CGRect startRect, CGRect endRect, NSTimeInterval duration, UIViewAnimationOptions animationOptions) {
    self.view.backgroundColor = show ? [UIColor redColor] : [UIColor whiteColor];
    switch(state) {
      case KeyboardNotificationStateWillShow:
        self.containerScrollView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        break;
      case KeyboardNotificationStateDidShow:
        self.containerScrollView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
        break;
      case KeyboardNotificationStateWillHide:
        self.containerScrollView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
        break;
      case KeyboardNotificationStateDidHide:
        self.containerScrollView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        break;
    }
  }];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [self.containerScrollView flashScrollIndicators];
}

- (void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  NSLog(@"The top view controller is %@",[UIViewController topMostController]);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return NO;
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return tableView == self.formatterTableView ? self.formatters.count : (tableView == self.validatorTableView ? self.validators.count : self.allowedCharacters.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSIndexPath * selectedIndexPath = tableView == self.formatterTableView ? self.formatterSelectedIndexPath : (tableView == self.validatorTableView ? self.validatorSelectedIndexPath : self.allowedCharactersSelectedIndexPath);
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
  cell.textLabel.text = tableView == self.formatterTableView ? [[self class] stringForFormatter:self.formatters[indexPath.row]] : (tableView == self.validatorTableView ? [[self class] stringForValidator:self.validators[indexPath.row]] : self.allowedCharacters[indexPath.row][@"title"]);
  cell.accessoryType = [selectedIndexPath isEqual:indexPath] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
  return cell;
}

#pragma mark - UITableViewDelegate Methods

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
  NSIndexPath * selectedIndexPath = tableView == self.formatterTableView ? self.formatterSelectedIndexPath : (tableView == self.validatorTableView ? self.validatorSelectedIndexPath : self.allowedCharactersSelectedIndexPath);
  return indexPath.row != selectedIndexPath.row;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSIndexPath * selectedIndexPath = tableView == self.formatterTableView ? self.formatterSelectedIndexPath : (tableView == self.validatorTableView ? self.validatorSelectedIndexPath : self.allowedCharactersSelectedIndexPath);
  if (selectedIndexPath != nil) {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:selectedIndexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
  }
  
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  cell.accessoryType = UITableViewCellAccessoryCheckmark;
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  if(tableView == self.formatterTableView) {
    self.textField.formatter = self.formatters[indexPath.row];
    
    self.formatterSelectedIndexPath = indexPath;
  } else if(tableView == self.validatorTableView) {
    self.textField.validator = self.validators[indexPath.row];
    
    self.validatorSelectedIndexPath = indexPath;
  } else {
    self.textField.allowedCharacterSet = self.allowedCharacters[indexPath.row][@"characters"] == [NSNull null] ? nil : self.allowedCharacters[indexPath.row][@"characters"];
    
    self.allowedCharactersSelectedIndexPath = indexPath;
  }
}

+ (NSString *)stringForFormatter:(ETHFormatter *)formatter {
  if([formatter class] == [ETHCreditCardNumberFormatter class]) {
    return @"Credit Card";
  } else if([formatter class] == [ETHCreditCardExpirationDateFormatter class]) {
    return @"Credit Card Exp No.";
  }
  return @"Unknown";
}

+ (NSString *)stringForValidator:(ETHValidator *)validator {
  if([validator class] == [ETHNonemptyValidator class]) {
    return @"Non empty";
  } else if([validator class] == [ETHSelectorValidator class]) {
    return @"Selector (Example)";
  } else if([validator class] == [ETHBlockValidator class]) {
    return @"Block (Example)";
  } else if([validator class] == [ETHUSAStateValidator class]) {
    return @"USA State validator";
  }
  return @"Unknown";
}

@end
