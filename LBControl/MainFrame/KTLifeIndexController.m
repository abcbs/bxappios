//
//  KTLifeIndexController.m
//  民生小区
//
//  Created by 闫青青 on 15/6/2.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "KTLifeIndexController.h"
#import "UIView+Frame.h"
#import "Conf.h"
#import "KTLifeIndexCell.h"
#import "ADTImagePlayer.h"
#import "recommendController.h"
#import "communicateController.h"
#import "communicate.h"
#import "appointmentController.h"
#import "lifeServiceController.h"
#import "bankController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHight [UIScreen mainScreen].bounds.size.height
@interface KTLifeIndexController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,imagePlayerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *imageNameArray;

@property (strong, nonatomic)IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic)IBOutlet UIPageControl *pageControl;


@property (nonatomic, weak) UIView *imageView;
@property (nonatomic, weak) ADTImagePlayer *imagePlayer;



@end



@implementation KTLifeIndexController


/**
 *  懒加载TableView
 *
 *  @return 返回一个创建好的TableView
 */

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_ADD_STATUS_HEIGHT) style:UITableViewStyleGrouped];
        self.tableView.dataSource =self;
        self.tableView.delegate = self;
        self.imageNameArray = @[@"tuhongse.png",@"tukuaihuang.png",@"tulvse.png",@"tukuailvse.png",@"tukuail.png"];
        UINib *nib = [UINib nibWithNibName:@"KTLifeIndexCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"KTLifeIndexCell"];
        //设置每个section之间的间隙
        self.tableView.sectionHeaderHeight = 1;
        
    }
    return _tableView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
   
    //添加列表
    [self.view addSubview:self.tableView];
    //添加头部图片轮播器
    [self addImagePlay];
}

/**
 *  添加头部图片轮播器
 */
- (void)addImagePlay{
    
    ADTImagePlayer *imagePlayer = [ADTImagePlayer imagePlayer];
    imagePlayer.playerDelegate = self;
    self.imagePlayer = imagePlayer;
    [imagePlayer setPageControlPositionToBottom:40];
    self.tableView.tableHeaderView = self.imagePlayer;

    //
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < 5; i++){
        NSString *imgName = [NSString stringWithFormat:@"img_0%d.jpg",i+1];
        [tempArray addObject:imgName];
    }
    [self.imagePlayer setImageNames:tempArray];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

      KTLifeIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KTLifeIndexCell"];
        cell.bigImage.image = [UIImage imageNamed:self.imageNameArray[indexPath.row+0]];
        return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
//设置页脚高度，也就是cell之间的间隙
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        recommendController *vc1 = [[recommendController alloc]init];
        [self presentViewController:vc1 animated:NO completion:nil];
    }
    else if (indexPath.row == 1){
        communicate *vc2 = [[communicate alloc]init];
        [self presentViewController:vc2 animated:NO completion:nil];
    }
    else if (indexPath.row == 2){
        appointmentController *vc3 = [[appointmentController alloc]init];
        [self presentViewController:vc3 animated:NO completion:nil];
    }
    else if (indexPath.row == 3){
        lifeServiceController *vc4 = [[lifeServiceController alloc]init];
        [self presentViewController:vc4 animated:NO completion:nil];
    }
    else if (indexPath.row == 4){
        bankController *vc5 = [[bankController alloc]init];
        [self presentViewController:vc5 animated:NO completion:nil];
    }

}









@end
