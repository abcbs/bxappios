//
//  RegisterViewController.m
//  民生小区
//
//  Created by 闫青青 on 15/4/23.
//  Copyright (c) 2015年 闫青青. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "RegistModel.h"
#import "AFNHelp.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "VPImageCropperViewController.h"
#import "Conf.h"
#import "RegistUtil.h"
#import "ValidateMessage.h"
#define ORIGINAL_MAX_WIDTH 640.0f

@interface RegisterViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, VPImageCropperDelegate>
{
    NSString *i;
}

//头像的imageview
@property (nonatomic, strong) UIImageView *portraitImageView;
@property (strong,nonatomic) UITextField *userTextField;
@property (strong,nonatomic) UITextField *realNameText;
@property (strong,nonatomic) UITextField *sexText;
@property (strong,nonatomic) UITextField *phoneText;
@property (strong,nonatomic) UITextField *validateText;
@property (strong,nonatomic) UITextField *codeText;
@property (strong,nonatomic) UITextField *commitCodeText;
@property (strong,nonatomic) UITextField *addressText;
@property (nonatomic,strong) UIButton*button1;
@property (nonatomic,strong) UIButton*button2;
@property (strong,nonatomic) RegistModel *rs;



@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.portraitImageView];
    [self loadPortrait];
    
    // Do any additional setup after loading the view.
    //背景色
    self.view.backgroundColor = [UIColor colorWithRed:0.234 green:0.234 blue:0.234 alpha:0.1];
    //红色界面
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 65)];
    NSString *imageName = [NSString stringWithFormat:@"register-head.png"];
    imageView1.image = [UIImage imageNamed:imageName];
    [self.view addSubview:imageView1];
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.0625, self.view.bounds.size.height*0.052916, self.view.bounds.size.width*0.078125, self.view.bounds.size.width*0.078125)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"login-2.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClickeds:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    //完成按钮
    UIButton *commitButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.78125, SCREEN_HEIGHT*0.052916, SCREEN_WIDTH*0.140625, SCREEN_HEIGHT*0.04208)];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"register-2.png"] forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(commitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
    //白色的头像
    //    UIImageView *iconBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, 80, 90, 90)];
    //    NSString *iconBackImageName = [NSString stringWithFormat:@"register-3.png"];
    //    iconBackImage.image = [UIImage imageNamed:iconBackImageName];
    //    [self.view addSubview:iconBackImage];
    //上传头像按钮
    UIButton *upButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.71875, SCREEN_HEIGHT*0.2025, SCREEN_WIDTH*0.21875, SCREEN_HEIGHT*0.0520833)];
    [upButton setBackgroundImage:[UIImage imageNamed:@"register-4.png"] forState:UIControlStateNormal];
    [upButton addTarget:self action:@selector(editPortrait) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:upButton];
    
    //上传  按钮
    UIButton *upsuccessButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.12625, SCREEN_HEIGHT*0.2025, SCREEN_WIDTH*0.21875, SCREEN_HEIGHT*0.0520833)];
    [upsuccessButton setBackgroundImage:[UIImage imageNamed:@"register-4.png"] forState:UIControlStateNormal];
    [upsuccessButton addTarget:self action:@selector(upsuccess:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:upsuccessButton];
    
    //下面的输入框和label
    NSArray *array = @[@"   用 户 名:",@"   真实姓名:",@"   性  别:",@"   密 码:",@"   确认密码:",@"   详细地址:",@"   手机号:",@"   验证码:"];
    for(int i = 0;i <8;i++){
        //label
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.2748+SCREEN_HEIGHT*0.09075*i, SCREEN_WIDTH*0.28125, SCREEN_HEIGHT*0.083)];
        label.text = array[i];
        label.font = [UIFont fontWithName:nil size:15];
        label.textColor = [UIColor colorWithRed:0.500 green:0.500 blue:0.500 alpha:0.9];
        label.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:label];
    }
    //本地保存
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    
    //usertext
    _userTextField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.275+SCREEN_HEIGHT*0.09075*0, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _userTextField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_userTextField];
    [userDefaults setObject:_userTextField.text forKey:@"username"];
    //realNameText
    _realNameText = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.275+SCREEN_HEIGHT*0.09075*1, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _realNameText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_realNameText];
    //白色背景
    UIView *backImage = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.275+SCREEN_HEIGHT*0.09075*2, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    backImage.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backImage];
    //单选按钮
    _button1 = [self createButtonwithframe:CGRectMake(SCREEN_WIDTH*0.30625, SCREEN_HEIGHT*0.475, SCREEN_WIDTH*0.12625, SCREEN_HEIGHT*0.05208) image:@"RadioButton-Unselected" seletedImage:@"RadioButton-Selected"];
    //_button1.selected = YES;
    _button2 = [self createButtonwithframe:CGRectMake(SCREEN_WIDTH*0.50625, SCREEN_HEIGHT*0.475, SCREEN_WIDTH*0.12625, SCREEN_HEIGHT*0.05208) image:@"RadioButton-Unselected" seletedImage:@"RadioButton-Selected"];
    [self.view addSubview:_button2];
    [self.view addSubview:_button1];
    //性别男Label
    UILabel *man = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.4225, SCREEN_HEIGHT*0.475, SCREEN_WIDTH*0.0675, SCREEN_HEIGHT*0.05208)];
    man.text = @"男";
    man.font = [UIFont fontWithName:nil size:15];
    man.textColor = [UIColor colorWithRed:0.500 green:0.500 blue:0.500 alpha:0.9];
    man.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:man];
    //性别女Label
    UILabel *woman = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.6225, SCREEN_HEIGHT*0.475, SCREEN_WIDTH*0.0675, SCREEN_HEIGHT*0.05208)];
    woman.text = @"女";
    woman.font = [UIFont fontWithName:nil size:15];
    woman.textColor = [UIColor colorWithRed:0.500 green:0.500 blue:0.500 alpha:0.9];
    woman.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:woman];
    //code
    _codeText = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.275+SCREEN_HEIGHT*0.09075*3, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _codeText.backgroundColor = [UIColor whiteColor];
    [userDefaults setObject:_userTextField.text forKey:@"password"];
    [self.view addSubview:_codeText];
    _codeText.secureTextEntry = YES;
    //commitCode
    _commitCodeText = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.275+SCREEN_HEIGHT*0.09075*4, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _commitCodeText.backgroundColor = [UIColor whiteColor];
    _commitCodeText.secureTextEntry = YES;
    [self.view addSubview:_commitCodeText];
    //address
    _addressText = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.275+SCREEN_HEIGHT*0.09075*5, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _addressText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_addressText];
    //phoneText
    _phoneText = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.275+SCREEN_HEIGHT*0.09075*6, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _phoneText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_phoneText];
    //获取验证码button
    UIButton *huoQuButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.711875, SCREEN_HEIGHT*0.285+SCREEN_HEIGHT*0.09075*6, SCREEN_WIDTH*0.2325, SCREEN_HEIGHT*0.06816)];
    [huoQuButton setBackgroundImage:[UIImage imageNamed:@"der.png"] forState:UIControlStateNormal];
    huoQuButton.layer.cornerRadius = 8;
    [huoQuButton addTarget:self action:@selector(validatecode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:huoQuButton];
    //validateCodeText
    _validateText = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.26125, SCREEN_HEIGHT*0.275+SCREEN_HEIGHT*0.09075*7, SCREEN_WIDTH*0.90625, SCREEN_HEIGHT*0.08333)];
    _validateText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_validateText];
    NSLog(@"%@",userDefaults);
    
}

//单选按钮
-(UIButton*)createButtonwithframe:(CGRect)frame image:(NSString*)imageName seletedImage:(NSString*)seletedImageName{
    UIButton*button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =frame;
    UIImage*image = [UIImage imageNamed:imageName];
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    UIImage*selecteIamge = [UIImage imageNamed:seletedImageName];
    [selecteIamge imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button setImage:selecteIamge forState:UIControlStateSelected];
    return button;
}
-(NSInteger)buttonClicked:(UIButton*)button{
    if (button==_button1) {
        _button1.selected = YES;
        _button2.selected = NO;
        i = @"0";
        NSLog(@"返回0");
        return 0;
    }else{
        _button1.selected = NO;
        _button2.selected = YES;
        NSLog(@"返回1");
        i = @"1";
        return 1;
    }
}

#pragma mark--头像事件
- (void)loadPortrait {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        //        NSURL *portraitUrl = [NSURL URLWithString:@"http://photo.l99.com/bigger/31/1363231021567_5zu910.jpg"];
        //        UIImage *protraitImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:portraitUrl]];
        UIImage *protraitImg = [UIImage imageNamed:@"register-3.png"];
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.portraitImageView.image = protraitImg;
        });
    });
}
- (void)editPortrait {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    self.portraitImageView.image = editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    UIGraphicsEndImageContext();
    //转换base－64
    //UIImage *_originImage = [UIImage imageNamed:newImage];
    NSData *_data = UIImageJPEGRepresentation(newImage, 1.0f);
    NSString *encodedImageStr = [_data base64Encoding];
    self.contents = encodedImageStr;
    //保存
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.contents forKey:@"image"];
    NSLog(@"===Encoded newImage:\n%@", encodedImageStr);
    return newImage;
}
#pragma mark portraitImageView getter
- (UIImageView *)portraitImageView {
    if (!_portraitImageView) {
        CGFloat w = 100.0f; CGFloat h = w;
        //CGFloat x = (self.view.frame.size.width - w) / 2;
        //CGFloat y = (self.view.frame.size.height - h) / 2;
        _portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.34375, SCREEN_HEIGHT*0.115, SCREEN_WIDTH*0.28125, SCREEN_WIDTH*0.28125)];
        [_portraitImageView.layer setCornerRadius:(_portraitImageView.frame.size.height/2)];
        [_portraitImageView.layer setMasksToBounds:YES];
        [_portraitImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_portraitImageView setClipsToBounds:YES];
        _portraitImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        _portraitImageView.layer.shadowOffset = CGSizeMake(4, 4);
        _portraitImageView.layer.shadowOpacity = 0.5;
        _portraitImageView.layer.shadowRadius = 2.0;
        _portraitImageView.layer.borderColor = [[UIColor blackColor] CGColor];
        _portraitImageView.layer.borderWidth = 2.0f;
        _portraitImageView.userInteractionEnabled = YES;
        _portraitImageView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
        [_portraitImageView addGestureRecognizer:portraitTap];
    }
    return _portraitImageView;
}

//返回button点击事件
- (void)buttonClickeds:(UIButton *)sender{
    [self dismissViewControllerAnimated:NO completion:^{
    }];
}
//代理实现的协议
- (void)getMessage:(NSString *)message{
    self.message = message;
    KT_AlertView_(self.message);
    if([self.message isEqual: @"注册成功"]){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
//代理实现的协议
- (void)ValidateCodeMessage:(NSString *)ValidateMessage{
    self.validateMsg = ValidateMessage;
    KT_AlertView_(self.validateMsg);
//    if([self.validateMsg isEqual:@"生成验证码成功"]){
//      [self dismissViewControllerAnimated:YES completion:nil];
//    }
}
//完成按钮点击事件
- (void)commitButtonClicked:(UIButton *)sender{
    _rs = [[RegistModel alloc]init];
    _rs.delegate = self;
    _rs.userName = self.userTextField.text;
    _rs.realName = self.realNameText.text;
    _rs.phoneNum = self.phoneText.text;
    _rs.passWord = self.codeText.text;
    _rs.address = self.addressText.text;
    _rs.commitCode = self.commitCodeText.text;
    _rs.j = i;
    [_rs registSuccess];
    //取出errorCode
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    _errorRegist = [userDefaults objectForKey:@"responseHeader"];
    NSLog(@"error:--%@",_errorRegist);
    if (![[_errorRegist objectForKey:@"errorCode"] isEqualToString:Success]) {
        
    }else if ([[_errorRegist objectForKey:@"errorCode"] isEqualToString:Success]){
        NSLog(@"注册成功并返回");
 
    }
    //移除key
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"responseHeader"];
    
}
//上传头像到服务器
- (void)upsuccess:(UIButton *)sender{
    _rs = [[RegistModel alloc]init];
    [_rs updateHeadImage];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    _errorHeadImage = [userDefaults objectForKey:@"responseHeader"];
    NSLog(@"errorHeadImage:--%@",_errorHeadImage);
    if ([[_errorHeadImage objectForKey:@"errorCode"] isEqualToString:Success]) {
        NSLog(@"上传成功并返回");
        KT_AlertView_(@"上传成功");
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        KT_AlertView_(@"上传失败");
    }
    //移除key
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"responseHeader"];
}
//获取验证码
- (void)validatecode:(UIButton *)sender{
    _rs = [[RegistModel alloc]init];
    _rs.phoneNum = self.phoneText.text;
    _rs.delegate2 = self;
    [_rs validateCode];
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    _errorValidateCode = [userDefaults objectForKey:@"responseHeader"];
    NSLog(@"获取验证码错误信息%@",_errorValidateCode);
    if([[_errorValidateCode objectForKey:@"errorCode"]isEqualToString:Success]){
//        NSLog(@"获取验证码成功");
//        KT_AlertView_(@"生成验证码成功");
    }else{
//        KT_AlertView_(@"获取失败");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
