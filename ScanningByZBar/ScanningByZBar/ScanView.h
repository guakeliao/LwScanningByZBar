//
//  ScanView.h
//  ScanningByZBar
//
//  Created by guakeliao on 15/5/29.
//  Copyright (c) 2015年 Boco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
@interface ScanView : UIView

@property (nonatomic, copy) void (^callBack)(id data);

- (void)start;
- (void)stop;
@end
