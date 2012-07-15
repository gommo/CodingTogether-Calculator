//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Colin Goudie on 2/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userInInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL enteringAFloatingPointNmber;
@property (nonatomic, strong) CalculatorBrain* brain;

- (void) reset;

@end

@implementation CalculatorViewController

@synthesize display;
@synthesize userInInTheMiddleOfEnteringANumber;
@synthesize enteringAFloatingPointNmber;
@synthesize brain = _brain;

- (CalculatorBrain*)brain {
    if (!_brain) {
        _brain = [[CalculatorBrain alloc]init];
    }
    return _brain;
}

- (void) reset {
    [self.brain clear];
    self.display.text = @"0";
    self.userInInTheMiddleOfEnteringANumber = NO;
    self.enteringAFloatingPointNmber = NO;
}

- (IBAction)digitPressed:(UIButton*)sender {
    NSString* digit = [sender currentTitle];
    
    if (self.userInInTheMiddleOfEnteringANumber) {
        if ([digit isEqualToString:@"."]) {
            if (self.enteringAFloatingPointNmber) {
                return;
            }
            self.enteringAFloatingPointNmber = YES;
        }
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else {
        if ([digit isEqualToString:@"."]) {
            digit = @"0.";
            self.enteringAFloatingPointNmber = YES;
        }
        self.display.text = digit;
        self.userInInTheMiddleOfEnteringANumber = YES;
    }
    
}
- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userInInTheMiddleOfEnteringANumber = NO;
    self.enteringAFloatingPointNmber = NO;
}

- (IBAction)operationPressed:(id)sender {
    if (self.userInInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    NSString* operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

- (IBAction)clearPressed:(id)sender {
    [self reset];
}

@end
