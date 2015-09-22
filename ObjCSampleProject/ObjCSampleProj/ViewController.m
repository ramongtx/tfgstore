//
//  ViewController.m
//  ObjCSampleProj
//
//  Created by Ramon Carvalho Maciel on 9/22/15.
//  Copyright © 2015 Ramon Carvalho Maciel. All rights reserved.
//

#import "ViewController.h"
#import "ObjCSampleProj-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonTouched:(id)sender {
    [TFGStore presentWithViewController:self jsonURL:@"https://storeparse.parseapp.com/storeapps.json" parseKey:@"CZ4JUohdD3Z1xEXouwaKlx4sNxeAA9oJtnAv1WrX" restApiKey:@"twmlIXOsmtXOnYFoWqKJuxcW3HVjtMQERa4SAdTW" cloudFunction:@"addLogs"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
