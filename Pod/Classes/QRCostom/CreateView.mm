//
//  CreateView.m
//  ScanningByZBar
//
//  Created by guakeliao on 15/6/12.
//  Copyright (c) 2015年 Boco. All rights reserved.
//

#import "CreateView.h"
#import <QREncoder.h>
#import <TSMessageView.h>
@interface CreateView ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation CreateView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.textView = [[UITextView alloc] init];
    self.textView.frame =
        CGRectMake(8, 8, CGRectGetWidth(rect) - 8 * 2, CGRectGetHeight(rect) - 8 * 2);
    [self addSubview:self.textView];
}
- (void)layoutSubviews
{
    self.textView.frame =
        CGRectMake(8, 8, CGRectGetWidth(self.frame) - 8 * 2, CGRectGetHeight(self.frame) - 8 * 2);
    [super layoutSubviews];
}

- (void)createImage:(void (^)(id image))successBlock
{
    if (self.textView.text.length > 0)
    {
        UIImage *image = [self createImageWithString:self.textView.text];
        if (successBlock)
        {
            successBlock(image);
        }
    }
    else
    {
        [TSMessage showNotificationWithTitle:@"请输入文字" type:TSMessageNotificationTypeWarning];
    }
}
- (UIImage *)createImageWithString:(NSString *)string
{
    DataMatrix *qrMatrix =
        [QREncoder encodeWithECLevel:QR_ECLEVEL_AUTO version:QR_VERSION_AUTO string:string];
    UIImage *qrcodeImage = [QREncoder renderDataMatrix:qrMatrix imageDimension:250];
    return qrcodeImage;
}

@end
