//
//  FDTakeController.m
//  KTAPP
//
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSPhotoTakeController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "BSIFTTHeader.h"
#import "Resources.h"
#import "BSPhotoViewController.h"

#import "BSPhotoTakeViewController.h"
//拍照
#define kPhotosActionSheetTag 1
//视频
#define kVideosActionSheetTag 2
//选择
#define kVideosOrPhotosActionSheetTag 3

#define kSinglePhotosActionSheetTag 11
#define kMultPhotosActionSheetTag 12

static NSString * const kTakePhotoKey = @"takePhoto";
static NSString * const kTakeVideoKey = @"takeVideo";
static NSString * const kChooseFromLibraryKey = @"chooseFromLibrary";
static NSString * const kChooseFromPhotoRollKey = @"chooseFromPhotoRoll";
static NSString * const kCancelKey = @"cancel";
static NSString * const kNoSourcesKey = @"noSources";
static NSString * const kStringsTableName = @"BSPhotoTake";


typedef NS_ENUM(NSInteger, BSImagePickerControllerMode) {
    BSImagePickerSingleTypePhotoLibrary=11,
    BSImagePickerMultTypePhotoLibrary=12
};

@interface BSPhotoTakeController() <UIActionSheetDelegate, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,BSImagePickerControllerDelegate ,BSPhoneImagePickerControllerDelegate>
{
    BOOL isHeaderImage;
    //商品头像图
    __block Resources *rs;
    //
    NSMutableArray *rsInfoArray;
    //
    NSMutableArray *rsImageArray;
    
    UIImage *singleImage;
    
    __block NSInteger maxPickImagesMax;
    BOOL pickImageOver;
    __block BOOL isCheckDataOver;

}

@property (strong, nonatomic) NSMutableArray *sources;
@property (strong, nonatomic) NSMutableArray *buttonTitles;
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (strong, nonatomic) UIPopoverController *popover;
@property (strong, nonatomic) UIImagePickerController *imagePicker;

@property (strong, nonatomic)  UIViewController *aViewController;
//相机拍摄照片放入集合展示

//从相册中选择一张
@property (strong,nonatomic )  BSImagePickerController *multimagePickerController;
//从相册中选择多张
@property (strong,nonatomic )  BSImagePickerController *singleimagePickerController;

@property (strong,nonatomic )  BSPhotoImagePickerController *bsPhotoImagePickController;
// Returns either optional view control for presenting or main window
- (UIViewController*)presentingViewController;

// encapsulation of actionsheet creation
- (void)_setUpActionSheet;
- (NSString*)textForButtonWithTitle:(NSString*)title;


@end

@implementation BSPhotoTakeController

@synthesize sources = _sources;
@synthesize buttonTitles = _buttonTitles;
@synthesize actionSheet = _actionSheet;
@synthesize imagePicker = _imagePicker;
@synthesize popover = _popover;
@synthesize viewControllerForPresentingImagePickerController = _viewControllerForPresenting;
@synthesize popOverPresentRect = _popOverPresentRect;

@synthesize aViewController=_aViewController;

@synthesize multimagePickerController=_multimagePickerController;
@synthesize singleimagePickerController=_singleimagePickerController;
@synthesize bsPhotoImagePickController=_bsPhotoImagePickController;

- (void)viewDidLoad {
    [super viewDidLoad];
    maxPickImagesMax=0;
    pickImageOver=NO;
    isCheckDataOver=NO;
 }

- (void)dealloc{
    self.bsPhotoImagePickController=nil;
    self.imagePicker=nil;
    
    
}

-(UIViewController *)aViewController{
    if (!_aViewController){
    _aViewController = [self _topViewController:[[[UIApplication sharedApplication] keyWindow] rootViewController] ];
    }
    return _aViewController;
    
}


- (NSMutableArray *)sources
{
    if (!_sources) _sources = [[NSMutableArray alloc] init];
    return _sources;
}

- (NSMutableArray *)buttonTitles
{
    if (!_buttonTitles) _buttonTitles = [[NSMutableArray alloc] init];
    return _buttonTitles;
}

- (CGRect)popOverPresentRect
{

    if (_popOverPresentRect.size.height == 0 || _popOverPresentRect.size.width == 0)
        _popOverPresentRect = CGRectMake(0, 0, 1, 1);
    return _popOverPresentRect;
}

//图片选择控制器
- (UIImagePickerController *)imagePicker
{
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        _imagePicker.allowsEditing = YES;
    }
    return _imagePicker;
}



-( BSPhotoImagePickerController *)bsPhotoImagePickController{
    if (!_bsPhotoImagePickController) {
        _bsPhotoImagePickController=[BSPhotoImagePickerController new];
        _bsPhotoImagePickController.delegate = self;
        _bsPhotoImagePickController.allowsMultipleSelection = YES;
        //最多9张，最少3张轮播介绍图片
        _bsPhotoImagePickController.maximumNumberOfSelection = PICK_IMAGE_MAX;
        _bsPhotoImagePickController.minimumNumberOfSelection = PICK_IMAGE_MIN;
        _bsPhotoImagePickController.showsNumberOfSelectedAssets = YES;
    }
    return _bsPhotoImagePickController;
}
-(void) pickImagesFromPhotoTake:(UIImage *)image{
    if (maxPickImagesMax<TAKE_PHOTP_MAX) {
        maxPickImagesMax++;
        [self.bsPhotoImagePickController selectPhotoImage:image];
        return;
    }
    [self.bsPhotoImagePickController selectPhotoImage:image];
    pickImageOver=YES;
    [self.bsPhotoImagePickController reloadCollectionData];
    [[self presentingViewController] presentViewController:self.bsPhotoImagePickController animated:YES completion:nil];

    
}

/**
 *选择多张照片
 */
-(BSImagePickerController *)multimagePickerController{
    if (!rsImageArray) {
        rsImageArray=[[NSMutableArray alloc]init];
    }
    if (!rsInfoArray) {
        rsInfoArray=[[NSMutableArray alloc]init];
    }
    if (!_multimagePickerController) {
        _multimagePickerController = [BSImagePickerController new];
        _multimagePickerController.mediaType = BSImagePickerMediaTypeImage;
        
        
        _multimagePickerController.delegate = self;
        _multimagePickerController.allowsMultipleSelection = YES;
        //最多9张，最少3张轮播介绍图片
        _multimagePickerController.maximumNumberOfSelection = PICK_IMAGE_MAX;
        _multimagePickerController.minimumNumberOfSelection = PICK_IMAGE_MIN;
        _multimagePickerController.showsNumberOfSelectedAssets = YES;
      

    }
    return _multimagePickerController;
}
- (void)multImagePicker {
   
     isHeaderImage=NO;
     [[self presentingViewController] presentViewController:self.multimagePickerController animated:YES completion:nil];
    
}

-(BSImagePickerController *)singleimagePickerController{
    if (!_singleimagePickerController) {
        _singleimagePickerController= [BSImagePickerController new];
        _singleimagePickerController.mediaType = BSImagePickerMediaTypeImage;
         _singleimagePickerController.delegate = self;
        _singleimagePickerController.allowsMultipleSelection = NO;
        _singleimagePickerController.showsNumberOfSelectedAssets = NO;
    }
    return _singleimagePickerController;
}
- (void)singleImagePicker {
    isHeaderImage=YES;
    [[self presentingViewController] presentViewController:self.singleimagePickerController animated:YES completion:nil];
}

- (UIPopoverController *)popover
{
    if (!_popover) _popover = [[UIPopoverController alloc] initWithContentViewController:self.imagePicker];
    return _popover;
}

/**
 *图片和拍照方法，一张的操作
 */
- (void)takeSinglePhotoOrChooseFromLibrary
{
    self.sources = nil;
    //按钮选择
    self.buttonTitles = nil;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {//照相是否许可
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypeCamera]];
        [self.buttonTitles addObject:[self textForButtonWithTitle:kTakePhotoKey]];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {//来自相册
        //单选操作
        [self.sources addObject:[NSNumber numberWithInteger:BSImagePickerSingleTypePhotoLibrary]];
        [self.buttonTitles addObject:[self textForButtonWithTitle:kChooseFromLibraryKey]];
    }
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypeSavedPhotosAlbum]];
        [self.buttonTitles addObject:[self textForButtonWithTitle:kChooseFromPhotoRollKey]];
    }
    [self _setUpActionSheet];
    [self.actionSheet setTag:kPhotosActionSheetTag];
}

/**
 *图片和拍照方法，多张张的操作
 */
- (void)takeMultPhotoOrChooseFromLibrary
{
    self.sources = nil;
    //按钮选择
    self.buttonTitles = nil;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {//照相是否许可
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypeCamera]];
        [self.buttonTitles addObject:[self textForButtonWithTitle:kTakePhotoKey]];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {//选择多张图片
        [self.sources addObject:[NSNumber numberWithInteger:BSImagePickerMultTypePhotoLibrary]];
        [self.buttonTitles addObject:[self textForButtonWithTitle:kChooseFromLibraryKey]];
    }
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypeSavedPhotosAlbum]];
        [self.buttonTitles addObject:[self textForButtonWithTitle:kChooseFromPhotoRollKey]];
    }
    [self _setUpActionSheet];
    [self.actionSheet setTag:kPhotosActionSheetTag];
}



#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == self.actionSheet.cancelButtonIndex) {//取消操作
        if ([self.delegate respondsToSelector:@selector(takeController:didCancelAfterAttempting:)])
            [self.delegate takeController:self didCancelAfterAttempting:NO];
    } else {//没有取消正常操作
        if([[self.sources objectAtIndex:buttonIndex] integerValue]==kSinglePhotosActionSheetTag){
            [self singleImagePicker];
            return;
        }
        if ([[self.sources  objectAtIndex:buttonIndex] integerValue]==kMultPhotosActionSheetTag) {
            [self multImagePicker];
            return;
        }
        
        self.imagePicker.sourceType = [[self.sources objectAtIndex:buttonIndex] integerValue];
        //从拍照
        if ((self.imagePicker.sourceType==UIImagePickerControllerSourceTypeCamera) || (self.imagePicker.sourceType==UIImagePickerControllerSourceTypeCamera)) {
            if (self.defaultToFrontCamera && [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
                [self.imagePicker setCameraDevice:UIImagePickerControllerCameraDeviceFront];
            }
        }
        // set the media type: photo or video
        if (actionSheet.tag == kPhotosActionSheetTag) {//拍照之后对图片的许可操作
            self.imagePicker.allowsEditing = self.allowsEditingPhoto;
            self.imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
        } else if (actionSheet.tag == kVideosActionSheetTag) {
            self.imagePicker.allowsEditing = self.allowsEditingVideo;
            self.imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        } else if (actionSheet.tag == kVideosOrPhotosActionSheetTag) {
            if ([self.sources count] == 1) {
                if (buttonIndex == 0) {
                    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
                }
            } else {
                if (buttonIndex == 0) {
                    self.imagePicker.allowsEditing = self.allowsEditingPhoto;
                    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
                } else if (buttonIndex == 1) {
                    self.imagePicker.allowsEditing = self.allowsEditingVideo;
                    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
                } else if (buttonIndex == 2) {
                    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
                }
            }
        }
        
        // On iPad use pop-overs.
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [self.popover presentPopoverFromRect:self.popOverPresentRect
                                          inView:_aViewController.view
                        permittedArrowDirections:UIPopoverArrowDirectionAny
                                        animated:YES];
        }
        else {
            // On iPhone use full screen presentation.
            [[self presentingViewController] presentViewController:self.imagePicker animated:YES completion:nil];
        }
    }
}

#pragma mark - BSImagePickerControllerDelegate
//多选操作
- (void)imagePickerController:(BSImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets{
    //选择图片
    
    if (isHeaderImage&&assets.count==1) {//点击为头图片选择
        PHAsset *headerImage=(PHAsset *)assets[0];
        if (!rs) {
            rs=[[Resources alloc]init];
        }
        rs.metatype=headerImage.mediaType;
        [self pickImageInfo:headerImage];
        
    }else{
        //多张图片
        [self resourceImageView:assets];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)resourceImageView:(NSArray *)assets{
    //
    __block NSMutableArray *tempArray = [NSMutableArray array];
    __block int count=0;
    [rsInfoArray removeAllObjects];
    [rsImageArray removeAllObjects];
    for (PHAsset *headerImage in assets) {
        Resources *rss=[[Resources alloc]init];
        rss.metatype=headerImage.mediaType;
        [[PHImageManager defaultManager]
         requestImageDataForAsset:headerImage
         options:nil
         resultHandler:^(NSData *imageData, NSString *dataUTI,
                         UIImageOrientation orientation,
                         NSDictionary *info){
             UIImage *image=[[UIImage alloc]initWithData:imageData];
             [tempArray addObject:image];
             if ([info objectForKey:@"PHImageFileURLKey"]) {
                 // path looks like this -
                 NSURL *path = [info objectForKey:@"PHImageFileURLKey"];
                 //数据类型
                 rss.name=[path path];
                 ++count;
                 [rsInfoArray addObject:rss];
                 [rsImageArray addObject:image];
             }
             if (assets.count==count) {//多张图片
            
                 if ([self.delegate respondsToSelector:@selector(takeController:gotPhotoArray:withInfo:)]){
                     [self.delegate takeController:self gotPhotoArray:rsImageArray withInfo:rsInfoArray];
                 }
             }
         }];
    }
    
}

/**
 *选择一张图片
 */
-(void)pickImageInfo:(PHAsset *)headerImage{
    
    [[PHImageManager defaultManager]
     requestImageDataForAsset:headerImage
     options:nil
     resultHandler:^(NSData *imageData, NSString *dataUTI,
                     UIImageOrientation orientation,
                     NSDictionary *info){
         UIImage *image=[[UIImage alloc]initWithData:imageData];
         BSLog(@"info = %@", info);
         if ([info objectForKey:@"PHImageFileURLKey"]) {
             // path looks like this -
             NSURL *path = [info objectForKey:@"PHImageFileURLKey"];
             //数据类型
             rs.name=[path path];
         }
         if ([self.delegate respondsToSelector:@selector(takeController:gotPhoto:withInfo:)]){
             [self.delegate takeController:self gotPhoto:image withInfo:rs];
         
        }

     }];
}

//选择照片之后需要跳转到起始页
- (void)imagePhotoPickerController:(BSPhotoImagePickerController *)imagePickerController didFinishPickingAssets:(NSMutableArray *)assets{
    __block UIViewController *bs=nil;
    if ([self.delegate respondsToSelector:@selector(takeController:)]) {
        bs=[self.delegate takeController:self];
    }
    if ([self.delegate respondsToSelector:@selector(takeController:gotPhoto:withInfo:)]){
        
        [self.delegate takeController:self gotPhotoArray:assets withInfo:nil];
        [bs dismissViewControllerAnimated:YES completion:nil];
        [[self presentingViewController]
                presentViewController:bs animated:YES completion:nil];
    }
}
/**
 *拍照成功之后的动作，事件源UIImagePickerControllerDelegate
 */
- (void)takeController:(BSPhotoTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary  *)info{
    if ([self.delegate respondsToSelector:@selector(takeController:gotPhoto:withInfo:)]){
        Resources *rss=[[Resources alloc]init];
        rss.metatype=1;
        if (!pickImageOver){//是否拍够了预定照片数，没有的时候一张一张的显示
            [self.delegate takeController:self gotPhoto:photo withInfo:rss];
        }
        //图片选择结束
        
        if ([self.delegate respondsToSelector:@selector(isOverTakeController:)]){
            isCheckDataOver=[self.delegate isOverTakeController:self];
            if (isCheckDataOver) {
                [self.bsPhotoImagePickController removeCollectionObjects];
                
            }
        }
        if (!isCheckDataOver) {
            [self pickImagesFromPhotoTake:photo];

        }
        
    }
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([self.delegate respondsToSelector:@selector(takeController:didCancelAfterAttempting:)])
        [self.delegate takeController:self didCancelAfterAttempting:NO];
}

#pragma mark - UIImagePickerControllerDelegate

/**
 *图片拍照之后
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
    
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToSave = editedImage;
        } else if (originalImage) {
            imageToSave = originalImage;
        } else {//拍照失败
            if ([self.delegate respondsToSelector:@selector(takeController:didFailAfterAttempting:)])
                [self.delegate takeController:self didFailAfterAttempting:YES];
            return;
        }
        //拍照成功后执行代理操作
        [self takeController:self gotPhoto:imageToSave withInfo:info];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            [self.popover dismissPopoverAnimated:YES];
    }
    // Handle a movie capture
    else if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0)
        == kCFCompareEqualTo) {
        if ([self.delegate respondsToSelector:@selector(takeController:gotVideo:withInfo:)])
            [self.delegate takeController:self gotVideo:[info objectForKey:UIImagePickerControllerMediaURL] withInfo:info];
    }
    if (!pickImageOver) {
        [picker dismissViewControllerAnimated:YES completion:nil];
        picker=nil;
    }
   
   
}

/**
 *图片选择操作取消系统操作
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.imagePicker = nil;

    if ([self.delegate respondsToSelector:@selector(takeController:didCancelAfterAttempting:)])
        [self.delegate takeController:self didCancelAfterAttempting:YES];
}

#pragma mark - Private methods

- (UIViewController*)presentingViewController
{
    // Use optional view controller for presenting the image picker if set
    UIViewController *presentingViewController = nil;
    if (self.viewControllerForPresentingImagePickerController!=nil) {
        presentingViewController = self.viewControllerForPresentingImagePickerController;
    }
    else {
        // Otherwise do this stuff (like in original source code)
        presentingViewController = [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    }
    return presentingViewController;
}

//Added by me
- (UIViewController *)topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil) {
        return rootViewController;//返回
    }
    
    if ([rootViewController.presentedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self topViewController:presentedViewController];
}

/**
 *动作事件处理
 */
- (void)_setUpActionSheet
{
    if ([self.sources count]) {
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:nil];
        for (NSString *title in self.buttonTitles)
            [self.actionSheet addButtonWithTitle:title];
        [self.actionSheet addButtonWithTitle:[self textForButtonWithTitle:kCancelKey]];
        self.actionSheet.cancelButtonIndex = self.sources.count;
        
        // If on iPad use the present rect and pop over style.
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [self.actionSheet showFromRect:self.popOverPresentRect inView:[self presentingViewController].view animated:YES];
        }
        else if(self.tabBar) {//Bar不存在
            [self.actionSheet showFromTabBar:self.tabBar];
        }
        else {
            // Otherwise use iPhone style action sheet presentation.
            UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
            if ([window.subviews containsObject:[self presentingViewController].view]) {//按钮放在什么地方
                [self.actionSheet showInView:[self presentingViewController].view];
            } else {
                [self.actionSheet showInView:window];
            }
        }
    } else {
        NSString *str = [self textForButtonWithTitle:kNoSourcesKey];
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:str
                                   delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:nil] show];
    }
}

// This is a hack required on iPad if you want to select a photo and you already have a popup on the screen
- (UIViewController *)_topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil)
        return rootViewController;
    
    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self _topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self _topViewController:presentedViewController];
}

- (NSString*)textForButtonWithTitle:(NSString*)title
{
	if ([title isEqualToString:kTakePhotoKey])
		return self.takePhotoText ?: NSLocalizedStringFromTable(kTakePhotoKey, kStringsTableName, @"Option to take photo using camera");
	else if ([title isEqualToString:kTakeVideoKey])
		return self.takeVideoText ?: NSLocalizedStringFromTable(kTakeVideoKey, kStringsTableName, @"Option to take video using camera");
	else if ([title isEqualToString:kChooseFromLibraryKey])
		return self.chooseFromLibraryText ?: NSLocalizedStringFromTable(kChooseFromLibraryKey, kStringsTableName, @"Option to select photo/video from library");
	else if ([title isEqualToString:kChooseFromPhotoRollKey])
		return self.chooseFromPhotoRollText ?: NSLocalizedStringFromTable(kChooseFromPhotoRollKey, kStringsTableName, @"Option to select photo from photo roll");
	else if ([title isEqualToString:kCancelKey])
		return self.cancelText ?: NSLocalizedStringFromTable(kCancelKey, kStringsTableName, @"Decline to proceed with operation");
	else if ([title isEqualToString:kNoSourcesKey])
		return self.noSourcesText ?: NSLocalizedStringFromTable(kNoSourcesKey, kStringsTableName, @"There are no sources available to select a photo");
	
	NSAssert(NO, @"Invalid title passed to textForButtonWithTitle:");
	
	return nil;
}


- (void)takePhotoOrChooseFromLibrary
{
    self.sources = nil;
    //按钮选择
    self.buttonTitles = nil;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {//照相是否许可
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypeCamera]];
        [self.buttonTitles addObject:[self textForButtonWithTitle:kTakePhotoKey]];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {//来着相册
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypePhotoLibrary]];
        [self.buttonTitles addObject:[self textForButtonWithTitle:kChooseFromLibraryKey]];
    }
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypeSavedPhotosAlbum]];
        [self.buttonTitles addObject:[self textForButtonWithTitle:kChooseFromPhotoRollKey]];
    }
    [self _setUpActionSheet];
    [self.actionSheet setTag:kPhotosActionSheetTag];
}

- (void)takeVideoOrChooseFromLibrary
{
    self.sources = nil;
    self.buttonTitles = nil;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypeCamera]];
        [self.buttonTitles addObject:[self textForButtonWithTitle:kTakeVideoKey]];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypePhotoLibrary]];
        [self.buttonTitles addObject:[self textForButtonWithTitle:kChooseFromLibraryKey]];
    }
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypeSavedPhotosAlbum]];
        [self.buttonTitles addObject:[self textForButtonWithTitle:kChooseFromPhotoRollKey]];
    }
    [self _setUpActionSheet];
    [self.actionSheet setTag:kVideosActionSheetTag];
}

- (void)takePhotoOrVideoOrChooseFromLibrary
{
    self.sources = nil;
    self.buttonTitles = nil;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypeCamera]];
        [self.buttonTitles addObject:[self textForButtonWithTitle:kTakePhotoKey]];
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypeCamera]];
        [self.buttonTitles addObject:[self textForButtonWithTitle:kTakeVideoKey]];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypePhotoLibrary]];
        [self.buttonTitles addObject:[self textForButtonWithTitle:kChooseFromLibraryKey]];
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        [self.sources addObject:[NSNumber numberWithInteger:UIImagePickerControllerSourceTypeSavedPhotosAlbum]];
        [self.buttonTitles addObject:[self textForButtonWithTitle:kChooseFromPhotoRollKey]];
    }
    [self _setUpActionSheet];
    [self.actionSheet setTag:kVideosOrPhotosActionSheetTag];
}

@end
