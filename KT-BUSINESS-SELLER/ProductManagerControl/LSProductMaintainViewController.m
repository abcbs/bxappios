//
//  LSProductMaintainViewController.m
//  KTAPP
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LSProductMaintainViewController.h"

@interface LSProductMaintainViewController ()

@end

@implementation LSProductMaintainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  modifiedStyle];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewDidUnload{
    //删除数据
    [super viewDidUnload];
}

- (void)dealloc{
    
    
}

-(void)modifiedStyle{
    CGSize size=_productName.size;
    _productName.size=BSSizeMake(size.height,size.width);
}

- (IBAction)saveProductDate:(id)sender {
    
}
@end
