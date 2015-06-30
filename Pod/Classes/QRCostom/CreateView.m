//
//  CreateView.m
//  ScanningByZBar
//
//  Created by guakeliao on 15/6/12.
//  Copyright (c) 2015年 Boco. All rights reserved.
//

#import "CreateView.h"
#import "qrencode.h"
#import "TSMessageView.h"

enum
{
    qr_margin = 3
};

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
        UIImage *image = [self createImageForString:self.textView.text imageSize:300];
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

#pragma mark
#pragma mark other methord
- (void)drawQRCode:(QRcode *)code context:(CGContextRef)ctx size:(CGFloat)size
{
    unsigned char *data = 0;
    int width;
    data = code->data;
    width = code->width;
    float zoom = (double)size / (code->width + 2.0 * qr_margin);
    CGRect rectDraw = CGRectMake(0, 0, zoom, zoom);

    // draw
    CGContextSetFillColor(ctx, CGColorGetComponents([UIColor blackColor].CGColor));
    for (int i = 0; i < width; ++i)
    {
        for (int j = 0; j < width; ++j)
        {
            if (*data & 1)
            {
                rectDraw.origin = CGPointMake((j + qr_margin) * zoom, (i + qr_margin) * zoom);
                CGContextAddRect(ctx, rectDraw);
            }
            ++data;
        }
    }
    CGContextFillPath(ctx);
}

- (UIImage *)createImageForString:(NSString *)string imageSize:(CGFloat)size
{
    if (![string length])
    {
        return nil;
    }

    QRcode *code = QRcode_encodeString([string UTF8String], 0, QR_ECLEVEL_L, QR_MODE_8, 1);
    if (!code)
    {
        return nil;
    }

    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
#define kCGImageAlphaPremultipliedLast (kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast)
#else
#define kCGImageAlphaPremultipliedLast kCGImageAlphaPremultipliedLast
#endif

    CGContextRef ctx = CGBitmapContextCreate(0, size, size, 8, size * 4, colorSpace,
                                             kCGImageAlphaPremultipliedLast);

    CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -size);
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
    CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));

    // draw QR on this context
    [self drawQRCode:code context:ctx size:size];

    // get image
    CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
    UIImage *qrImage = [UIImage imageWithCGImage:qrCGImage];

    // some releases
    CGContextRelease(ctx);
    CGImageRelease(qrCGImage);
    CGColorSpaceRelease(colorSpace);
    QRcode_free(code);

    return qrImage;
}

@end
