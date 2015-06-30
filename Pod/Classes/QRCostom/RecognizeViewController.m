//
//  RecognizeViewController.m
//  ScanningByZBar
//
//  Created by guakeliao on 15/6/12.
//  Copyright (c) 2015年 Boco. All rights reserved.
//

#import "RecognizeViewController.h"
#import "ZBarSDK.h"
#import "TSMessageView.h"

@interface RecognizeViewController () <ZBarReaderDelegate>

@property (nonatomic, strong) ZBarReaderController *reader;

@end

@implementation RecognizeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initForData];
    [self initForView];
    [self initForAction];
}
#pragma mark
#pragma mark Init For VC

- (void)initForData
{
}

- (void)initForView
{
    UIBarButtonItem *addButton =
        [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Pick", nil)
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(pickAssets:)];
    self.navigationItem.rightBarButtonItem = addButton;

    self.reader = [[ZBarReaderController alloc] init];
}

- (void)initForAction
{
}

- (void)pickAssets:(id)sender
{
    self.reader.allowsEditing = NO;
    self.reader.showsHelpOnFail = NO;
    self.reader.readerDelegate = self;
    self.reader.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ZBarImageScanner *scanner = self.reader.scanner;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    [self presentViewController:self.reader animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for (symbol in results)
        break;
    if (self.callBack)
    {
        self.callBack(symbol.data);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)readerControllerDidFailToRead:(ZBarReaderController *)reader withRetry:(BOOL)retry
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //二维码图片无效
    [TSMessage showNotificationWithTitle:@"二维码无效" type:TSMessageNotificationTypeError];
}

@end
