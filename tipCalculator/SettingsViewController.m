
//
//  SettingsViewController.m
//  tipCalculator
//
//  Created by Aparna Jain on 5/1/14.
//  Copyright (c) 2014 FOX. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tipPercentage1;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentage2;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentage3;

- (IBAction)onTap:(id)sender;
@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateDefaultsValue:(float)value forKey:(NSString *)key{
    NSUserDefaults *tipDefaults = [NSUserDefaults standardUserDefaults];
    [tipDefaults setFloat:value forKey:key];
    [tipDefaults synchronize];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    float newPercentage = [textField.text floatValue];
    if (textField == self.tipPercentage1) {
        [self updateDefaultsValue:newPercentage forKey:@"1"];
    }else if (textField == self.tipPercentage2){
                    [self updateDefaultsValue:newPercentage forKey:@"2"];
    }else if (textField == self.tipPercentage3) {
                [self updateDefaultsValue:newPercentage forKey:@"3"];
    }
}
@end
