//
//  CreateViewController.m
//  ScanningByZBar
//
//  Created by guakeliao on 15/6/17.
//  Copyright (c) 2015年 Boco. All rights reserved.
//

#import "CreateViewController.h"
#import "CreateView.h"

@interface CreateViewController ()

@property (weak, nonatomic) IBOutlet CreateView *createView;

@end

@implementation CreateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem =
        [self barButtonItemWithTitle:@"生成" andAction:@selector(createImage:)];
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
    [self.createView createImage:^(id image){
        //      UIImage *image1 = image;//自定义image用法
    }];
}
@end
