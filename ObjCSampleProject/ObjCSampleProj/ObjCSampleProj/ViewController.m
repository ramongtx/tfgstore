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

-(void)viewDidAppear:(BOOL)animated {
    
    [TFGStore presentWithViewController:self jsonURL:@"https://storeparse.parseapp.com/storeapps.json" parseKey:@"https://storeparse.parseapp.com/storeapps.json" restApiKey:@"twmlIXOsmtXOnYFoWqKJuxcW3HVjtMQERa4SAdTW" cloudFunction:@"hello"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
