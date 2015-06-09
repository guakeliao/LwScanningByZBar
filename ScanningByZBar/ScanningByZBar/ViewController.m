//
//  ViewController.m
//  ScanningByZBar
//
//  Created by guakeliao on 15/5/29.
//  Copyright (c) 2015年 Boco. All rights reserved.
//

#import "ViewController.h"
#import "ScanView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ScanView *scanVIew;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.scanVIew start];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.scanVIew stop];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.scanVIew.callBack = ^(id data) {
      NSLog(@"hello:%@", data);
    };
}
@end
