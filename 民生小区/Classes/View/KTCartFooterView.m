//
//  KTCartFooterView.m
//  民生小区
//
//  Created by 罗芳芳 on 15/5/12.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTCartFooterView.h"
#import "DeleteShoppingCartRequest.h"
#import "DeleteShoppingCartParams.h"
#import "DeleteShoppingCartRequest.h"
@interface KTCartFooterView ()
@property (nonatomic, strong) UIButton *btn;
- (IBAction)allSelectedClick:(UIButton*)sender;
-(IBAction)deleteClick:(UIButton *)sender;
@end

@implementation KTCartFooterView


- (IBAction)allSelectedClick:(UIButton*)sender
{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(ktFooterViewDelegate:)]) {
        [self.delegate ktFooterViewDelegate:sender.selected];
    }
}
-(IBAction)deleteClick:(UIButton *)sender
{
    
    
    
    
    
}

#pragma mark -- 网络请求
-(void) deleteCart:(NSString *)sessionId
{
    
//  
//    DeleteShoppingCartDict *shoppingcartlist=[[shoppingcartlist alloc] init];
//    shoppingCartList.sessionId = sessionId;
//    shpppingCartList.ID = ID;
//    
//    
//    [shoppingCartList deleteCart:shoppingCartList
//                  blockArray:^(NSError *error,ErrorMessage *errorMessage) {
//                      if (error) {
//                          NSLog(@"网络异常");
//                      }
//                      if (errorMessage) {
//                          NSLog(@"删除购物车成功%@",errorMessage.message);
//                      }
//                  }
//     
//     
//     ];
    
//    DeleteShoppingCartParams *params = [DeleteShoppingCartParams param];
//    params.sessionId = sessionId;
//   
//    params.shoppingCartList.ID = [NSNumber numberWithInt:1];
//    
//    
//    
//    [DeleteShoppingCartRequest deleteShoppingCartWith:params block:^(DeleteShoppingCartResult *result, NSError *error, BasicHeader *headr) {
//        if (result) {
//            NSLog(@"成功 ",result.responseBody);
//        }
//        if (headr) {
//            NSLog(@"失败 原因 %@",headr.message);
//        }
////        if (error) {
////            NSLog(@"网络异常 %ld %@",error.code,error.useInof);
////        }
//    }];
}
@end
