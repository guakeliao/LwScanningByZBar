//
//  RecognizeViewController.h
//  ScanningByZBar
//
//  Created by guakeliao on 15/6/12.
//  Copyright (c) 2015年 Boco. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  识别二维码
 */
@interface RecognizeViewController : UIViewController
/**
 *  二维码返回的信息
 */
@property (nonatomic, copy) void (^callBack)(id data);

@end
