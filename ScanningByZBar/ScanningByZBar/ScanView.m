//
//  ScanView.m
//  ScanningByZBar
//
//  Created by guakeliao on 15/5/29.
//  Copyright (c) 2015年 Boco. All rights reserved.
//

#import "ScanView.h"

@interface ScanView () <ZBarReaderViewDelegate>

@property (nonatomic, strong) UIImageView *readImageView;
@property (nonatomic, strong) UIImageView *readLineView;
@property (nonatomic, strong) ZBarReaderView *readview;
@property (nonatomic, assign) BOOL is_Anmotion;
@end

@implementation ScanView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self commit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self commit];
    }
    return self;
}

- (void)commit
{
    self.readview = [ZBarReaderView new];
    self.readview.readerDelegate = self;
    self.readview.allowsPinchZoom = YES; //使用手势变焦
    self.readview.trackingColor = [UIColor redColor];
    self.readview.showsFPS = NO; // 显示帧率  YES 显示  NO 不显示
    [self addSubview:self.readview];

    self.readImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanBox"]];
    [self addSubview:self.readImageView];

    self.readLineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanLine"]];
    [self addSubview:self.readLineView];
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    self.readImageView.frame =
        CGRectMake((rect.size.width - MIN(rect.size.width * 3 / 4, rect.size.height * 3 / 4)) / 2,
                   (rect.size.height - MIN(rect.size.width * 3 / 4, rect.size.height * 3 / 4)) / 2,
                   MIN(rect.size.width * 3 / 4, rect.size.height * 3 / 4),
                   MIN(rect.size.width * 3 / 4, rect.size.height * 3 / 4));
//    self.readImageView.center = self.center;

    self.readview.frame = self.bounds;
    self.readview.scanCrop = [self getScanCrop:self.readImageView.frame
                              readerViewBounds:self.readview.frame]; //将被扫描的图像的区域
}
#pragma mark 获取扫描区域
- (CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    // TODO:计算不是很准确
    CGFloat x, y, width, height;
    x = (rect.origin.y / readerViewBounds.size.height);
    y = 1 - (rect.origin.x + rect.size.width) / readerViewBounds.size.width;
    width = rect.size.height / readerViewBounds.size.height;
    height = rect.size.width / readerViewBounds.size.width;
    return CGRectMake(x, y, width, height);
}
#pragma mark 扫描动画
- (void)loopDrawLine
{
    self.is_Anmotion = NO;
    self.readLineView.frame =
        CGRectMake(self.readImageView.frame.origin.x, self.readImageView.frame.origin.y,
                   self.readImageView.frame.size.width, 10);
    [UIView animateWithDuration:3.0
        delay:0.0
        options:UIViewAnimationOptionCurveEaseIn
        animations:^{
          //修改fream的代码写在这里
          self.readLineView.frame = CGRectMake(self.readLineView.frame.origin.x,
                                               self.readLineView.frame.origin.y +
                                                   self.readImageView.frame.size.height - 5,
                                               self.readLineView.frame.size.width, 10);
          [self.readLineView setAnimationRepeatCount:1];
        }
        completion:^(BOOL finished) {
          if (!self.is_Anmotion)
          {
              [self loopDrawLine];
          }
        }];
}

- (void)start
{
    [self loopDrawLine];
    [self.readview start];
}
- (void)stop
{
    self.is_Anmotion = YES;
    self.readLineView.frame =
        CGRectMake(self.readImageView.frame.origin.x, self.readImageView.frame.origin.y,
                   self.readImageView.frame.size.width, 0);
    [self.readview stop];
}
#pragma mark 获取扫描结果
- (void)readerView:(ZBarReaderView *)readerView
    didReadSymbols:(ZBarSymbolSet *)symbols
         fromImage:(UIImage *)image
{
    // 得到扫描的条码内容
    const zbar_symbol_t *symbol = zbar_symbol_set_first_symbol(symbols.zbarSymbolSet);
    NSString *symbolStr = [NSString stringWithUTF8String:zbar_symbol_get_data(symbol)];
    if (zbar_symbol_get_type(symbol) == ZBAR_QRCODE)
    {
        // 是否QR二维码
    }
    if (self.callBack)
    {
        self.callBack(symbolStr);
    }
    //    [self stop];
}
@end
