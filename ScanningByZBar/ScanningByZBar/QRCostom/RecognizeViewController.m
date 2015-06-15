//
//  RecognizeViewController.m
//  ScanningByZBar
//
//  Created by guakeliao on 15/6/12.
//  Copyright (c) 2015年 Boco. All rights reserved.
//

#import "RecognizeViewController.h"
#import "ZBarSDK.h"
#import <CTAssetsPickerController.h>
#import <TSMessageView.h>

@interface RecognizeViewController () <CTAssetsPickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray *assets;
//@property (nonatomic, strong) CTAssetsPickerController *picker;
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
    self.assets = [[NSMutableArray alloc] init];
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
    [self.assets removeAllObjects];
    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
    picker.assetsFilter = [ALAssetsFilter allAssets];
    picker.showsCancelButton = YES;
    picker.delegate = self;
    picker.selectedAssets = self.assets;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - Assets Picker Delegate
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker
          isDefaultAssetsGroup:(ALAssetsGroup *)group
{
    return ([[group valueForProperty:ALAssetsGroupPropertyType] integerValue] ==
            ALAssetsGroupSavedPhotos);
}
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldEnableAsset:(ALAsset *)asset
{
    // Enable video clips if they are at least 5s
    if ([[asset valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo])
    {
        NSTimeInterval duration = [[asset valueForProperty:ALAssetPropertyDuration] doubleValue];
        return lround(duration) >= 5;
    }
    else
    {
        return YES;
    }
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset
{
    return (picker.selectedAssets.count < 1 && asset.defaultRepresentation != nil);
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker
        didFinishPickingAssets:(NSArray *)assets
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    ALAsset *asset = [assets firstObject];
    if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto])
    {
        ALAssetRepresentation *rep = [asset defaultRepresentation];
        CGImageRef fullResImage = [rep fullResolutionImage];
        id ZBarSymbols = [self.reader scanImage:fullResImage];
        if (ZBarSymbols)
        {
            ZBarSymbol *zbar_symbol = [ZBarSymbols firstObject];
            NSString *dataString =
                [NSString stringWithUTF8String:zbar_symbol_get_data(zbar_symbol.zbarSymbol)];
            if (self.callBack)
            {
                self.callBack(dataString);
            }
        }
        else
        {
            //二维码图片无效
            [TSMessage showNotificationWithTitle:@"二维码无效" type:TSMessageNotificationTypeError];
        }
    }
}
@end
