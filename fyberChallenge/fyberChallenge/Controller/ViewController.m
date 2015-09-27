//
//  ViewController.m
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 26/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import "ViewController.h"
#import "NetworkHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self getOffers];
}

- (void)getOffers
{
    [[NetworkHelper sharedManager] getOffersWithCompletion:^(NSArray *array, NSError *error) {
        if (!error) {
            
            
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Fyber" message:[[error userInfo] objectForKey:NSLocalizedDescriptionKey] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:alertAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
