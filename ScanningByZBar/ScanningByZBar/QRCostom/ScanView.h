//
//  ScanView.h
//  ScanningByZBar
//
//  Created by guakeliao on 15/5/29.
//  Copyright (c) 2015年 Boco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
/**
 *  扫描二维码
 */
@interface ScanView : UIView

@property (nonatomic, copy) void (^callBack)(id data);

@property (nonatomic, strong) NSString *readImageString; //扫描框的图片
@property (nonatomic, strong) NSString *readLineString;  //扫描线的图片

- (void)start;
- (void)stop;
@end
