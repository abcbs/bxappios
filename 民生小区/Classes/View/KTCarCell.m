//
//  KTCarCell.m
//  民生小区
//
//  Created by 罗芳芳 on 15/5/11.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTCarCell.h"
#import "WaterSending.h"
#import "CartList.h"
#import "UpdateShoppingCartParams.h"
#import "UpdateShoppingCartRequest.h"
@interface KTCarCell()<UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UIButton *selectBtn;




- (IBAction)minusClick:(UIButton *)sender;
- (IBAction)addClick:(UIButton *)sender;


@end
@implementation KTCarCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark  --- 购物车信息
- (void) cartList {
    self.productName.text = self.carlist.productName;// self.waterSending.name;
    self.productIntroduce.text = [NSString stringWithFormat:@"商品简介 : %@",self.carlist.productIntroduce];
    
    self.productSalePrice.text =[NSString stringWithFormat:@"￥%d",self.carlist.productSalePrice];
    
    self.productPreferPrice.text =[NSString stringWithFormat:@"￥%d",self.carlist.productPreferPrice];
    
}


- (IBAction)danxuanClick:(UIButton *)sender {
    //sender.selected = !sender.selected;
    if (self.applyCallBack) {
        self.applyCallBack(self.tag,!sender.selected);
    }
}

- (void)setIsSelect:(BOOL)isSelect{
    self.selectBtn.selected = isSelect;
}


- (IBAction)minusClick:(UIButton *)sender {
    int currentCount = (int)[self.count.titleLabel.text integerValue];
    currentCount--;
    if(currentCount<=0)
    {
        
        currentCount = 0;
    }
    [self.count setTitle:[NSString stringWithFormat:@"%d",currentCount] forState:UIControlStateNormal];
    if (self.plusOrMinCallBack) {
        self.plusOrMinCallBack(currentCount);
    }
}

- (IBAction)addClick:(UIButton *)sender {
    int currentCount = (int)[self.count.titleLabel.text integerValue];
    currentCount++;
    [self.count setTitle:[NSString stringWithFormat:@"%d",currentCount] forState:UIControlStateNormal];
    if (self.plusOrMinCallBack)
    {
        self.plusOrMinCallBack(currentCount);
    }

}


-(void)updateCart:(NSString *)sessionId ID:(NSNumber *)ID addCount:(NSNumber *)addCount
{
    
//    ShoppingCart *cartlist=[[ShoppingCart alloc] init];
//    shoppingCart.sessionId = sessionId;
//    shpppingCart.ID = ID;
//    
//    
//    [shoppingCart updateCart:shoppingCart
//                      blockArray:^(NSError *error,ErrorMessage *errorMessage) {
//                          if (error) {
//                              NSLog(@"网络异常");
//                          }
//                          if (errorMessage) {
//                              NSLog(@"删除%@",errorMessage.message);
//                          }
//                      }
//     
//     
//     ];
//    UpdateShoppingCartParams *params = [UpdateShoppingCartParams param];
//    params.sessionId = sessionId;
//    params.shoppingCart.ID = [NSNumber numberWithInt:1];
//    params.shoppingCart.count = [[NSNumber numberWithLongLong:[addCount longlongValue]];
//    [UpdateShoppingCartRequest updateShoppingCartWith:params block:^(UpdateShoppingCartResult *result, NSError *error, BasicHeader *headr) {
//
//        if (result) {
//            NSLog(@"成功 ",result.responseBody);
//        }
//        if (headr) {
//            NSLog(@"失败 原因 %@",headr.message);
//        }
//        if (error) {
//            NSLog(@"网络异常 %ld %@",error.code,error.useInof);
//        }
//    }];
//    
    
    
}
@end
