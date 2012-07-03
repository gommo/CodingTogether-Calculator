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
@property (nonatomic, strong) CalculatorBrain* brain;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize userInInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain*)brain {
    if (!_brain) {
        _brain = [[CalculatorBrain alloc]init];
    }
    return _brain;
}

- (IBAction)digitPressed:(UIButton*)sender {
    NSString* digit = [sender currentTitle];
    if (self.userInInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else {
        self.display.text = digit;
        self.userInInTheMiddleOfEnteringANumber = YES;
    }
    
}
- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userInInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)operationPressed:(id)sender {
    if (self.userInInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    NSString* operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}


@end
