//
//  LwViewController.m
//  LwScanningByZBar
//
//  Created by liaowei on 06/19/2015.
//  Copyright (c) 2014 liaowei. All rights reserved.
//

#import "LwViewController.h"
#import "ScanView.h"
#import "CreateViewController.h"
@interface LwViewController ()

@property (weak, nonatomic) IBOutlet ScanView *scanVIew;

@end

@implementation LwViewController

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

    self.navigationItem.leftBarButtonItem =
        [self barButtonItemWithTitle:@"生成" andAction:@selector(createImage:)];
    self.title = @"扫描二维码";
    //扫描二维码
    self.scanVIew.callBack = ^(id data) {
      NSLog(@"hello:%@", data);
    };
    //识别二维码
    self.callBack = ^(id data) {
      NSLog(@"%@", data);
    };
}

- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title andAction:(SEL)action
{
    UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonItem setTitle:title forState:UIControlStateNormal];
    [buttonItem addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [buttonItem sizeToFit];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:buttonItem];
    return barItem;
}
- (void)createImage:(id)sender
{
    [self performSegueWithIdentifier:@"createVC" sender:self];
}

@end
