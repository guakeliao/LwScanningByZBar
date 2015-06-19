//
//  CreateView.h
//  ScanningByZBar
//
//  Created by guakeliao on 15/6/12.
//  Copyright (c) 2015年 Boco. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  生成二维码
 */
@interface CreateView : UIView

/**
 *  调用生成二维码图片
 *
 *  @param successBlock block里返回的是image
 */
- (void)createImage:(void (^)(id image))successBlock;

@end
