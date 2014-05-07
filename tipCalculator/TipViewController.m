//
//  TipViewController.m
//  tipCalculator
//
//  Created by Aparna Jain on 5/1/14.
//  Copyright (c) 2014 FOX. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;
- (void)updateValues;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerDefaults];
    [self updateTipControlValues];
    [self updateValues];

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}

- (void)registerDefaults
{
    NSUserDefaults *tipDefaults = [NSUserDefaults standardUserDefaults];
    [tipDefaults registerDefaults:@{@"1": @"10", @"2": @"15", @"3": @"20"}];
    [tipDefaults synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}
- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    NSMutableArray *tipValues = [[NSMutableArray alloc] init];
    NSUserDefaults *tipDefaults = [NSUserDefaults standardUserDefaults];
    for(int i=1; i<= self.tipControl.numberOfSegments; i++)
    {
        [tipValues addObject:[NSNumber numberWithFloat:[tipDefaults integerForKey:[NSString stringWithFormat:@"%d", i]]]];
    }

    float tipAmount = (billAmount *  [tipValues[self.tipControl.selectedSegmentIndex] floatValue])/100;
    float totalAmount = tipAmount + billAmount;

    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)updateTipControlValues {
    NSUserDefaults *tipDefaults = [NSUserDefaults standardUserDefaults];
    for (int i = 1; i <= self.tipControl.numberOfSegments; i++) {
        NSString* key = [NSString stringWithFormat:@"%i", i];
        [self.tipControl setTitle:[NSString stringWithFormat:@"%d%%", [tipDefaults integerForKey:key]] forSegmentAtIndex:i-1];
    }

}
- (void)viewWillAppear:(BOOL)animated {
    [self updateTipControlValues];
}
@end
