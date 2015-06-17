//
//  KTInfrastructureView.m
//  KTAPP
//
//  Created by admin on 15/6/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTInfrastructureView.h"

@interface KTInfrastructureView ()

@end

@implementation KTInfrastructureView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.225 green:0.225 blue:0.225 alpha:0.05];
    //红色界面
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 65)];
    NSString *imageName = [NSString stringWithFormat:@"fbxq_01.png"];
    imageView1.image = [UIImage imageNamed:imageName];
    
    
    [self.view addSubview:imageView1];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"KTInfrastructureView" bundle:nil];
    
    KTInfrastructureView *infrastructureControl = [storyboard instantiateInitialViewController];
    
    [self.navigationController pushViewController:infrastructureControl animated:YES];
    
    [self reloadInputViews];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"segue test...");
}


@end
