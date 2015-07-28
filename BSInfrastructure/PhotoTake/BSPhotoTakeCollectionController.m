//
//  BSPhotoTakeCollectionController.m
//  KTAPP
//
//  Created by admin on 15/7/27.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSPhotoTakeCollectionController.h"
#import "CollectionViewCell.h"


@interface BSPhotoTakeCollectionController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    //BOOL bsAllowsMultipleSelection;
    
}

@property (nonatomic, strong) UIBarButtonItem *doneButton;
@property (nonatomic, assign) CGRect previousPreheatRect;

@property (nonatomic, assign) BOOL disableScrollToBottom;
@property (nonatomic, strong) NSIndexPath *lastSelectedItemIndexPath;

@property (nonatomic,strong) UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic,strong ) UICollectionView *collectionView;

//
@property (nonatomic, strong) NSMutableArray *fetchResult;
@property (nonatomic, strong) NSBundle *assetBundle;

@end

@implementation BSPhotoTakeCollectionController
@synthesize bsAllowsMultipleSelection=_bsAllowsMultipleSelection;
@synthesize minimumNumberOfSelection=_minimumNumberOfSelection;
@synthesize maximumNumberOfSelection=_maximumNumberOfSelection;
@synthesize selectedAssets=_selectedAssets;
@synthesize collectionView=_collectionView;
@synthesize collectionViewLayout=_collectionViewLayout;
@synthesize assetBundle=_assetBundle;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpToolbarItems];
    [self resetCachedAssets];

  
    self.collectionView = [[UICollectionView alloc]initWithFrame:
        CGRectMake(0, 66, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:self.collectionViewLayout];
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    
    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    //
    int i=0;
    for (i=0; i<10; i++) {
        [self.fetchResult addObject:@"img_02.jpg"];
    }
    
}

-(UICollectionViewFlowLayout *)collectionViewLayout{
    if (!_collectionViewLayout) {
        _collectionViewLayout=[[UICollectionViewFlowLayout alloc] init];
        [_collectionViewLayout setScrollDirection:UICollectionViewScrollDirectionVertical];

    }
    return _collectionViewLayout;
}

-(NSMutableArray *)fetchResult{
    if (!_fetchResult) {
        _fetchResult=[NSMutableArray array];
    }
    return _fetchResult;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Configure navigation item
    self.navigationItem.title = self.title;;
    
    // Configure collection view
    self.collectionView.allowsMultipleSelection = self.bsAllowsMultipleSelection;
    
    // Show/hide 'Done' button
    if (self.bsAllowsMultipleSelection) {
        [self.navigationItem setRightBarButtonItem:self.doneButton animated:NO];
    } else {
        [self.navigationItem setRightBarButtonItem:nil animated:NO];
    }
    
    [self updateDoneButtonState];
    
    // Scroll to bottom
    if (self.fetchResult.count > 0 && self.isMovingToParentViewController && !self.disableScrollToBottom) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:(self.fetchResult.count - 1) inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.disableScrollToBottom = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.disableScrollToBottom = NO;

}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    // Save indexPath for the last item
    
    NSIndexPath *indexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    // Update layout
    [self.collectionViewLayout invalidateLayout];
    
    // Restore scroll position
    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
    }];
     
}

#pragma mark - Toolbar
- (void)setUpToolbarItems
{
    // Space
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    UIBarButtonItem *rightSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    
    // Info label
    NSDictionary *attributes = @{ NSForegroundColorAttributeName: [UIColor blackColor] };
    UIBarButtonItem *infoButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
    infoButtonItem.enabled = NO;
    [infoButtonItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [infoButtonItem setTitleTextAttributes:attributes forState:UIControlStateDisabled];
    
    self.toolbarItems = @[leftSpace, infoButtonItem, rightSpace];
}

- (void)resetCachedAssets
{

    self.previousPreheatRect = CGRectZero;
}


- (void)updateDoneButtonState
{
    self.doneButton.enabled = [self isMinimumSelectionLimitFulfilled];
}

- (BOOL)isMinimumSelectionLimitFulfilled
{
    return (self.minimumNumberOfSelection <= self.selectedAssets.count);
}

- (void)updateSelectionInfo
{
    NSMutableOrderedSet *selectedAssets = self.selectedAssets;
    
    if (selectedAssets.count > 0) {
        NSBundle *bundle = self.assetBundle;
        NSString *format;
        if (selectedAssets.count > 1) {
            format = NSLocalizedStringFromTableInBundle(@"assets.toolbar.items-selected", @"BSImagePicker", bundle, nil);
        } else {
            format = NSLocalizedStringFromTableInBundle(@"assets.toolbar.item-selected", @"BSImagePicker", bundle, nil);
        }
        
        NSString *title = [NSString stringWithFormat:format, selectedAssets.count];
        [(UIBarButtonItem *)self.toolbarItems[1] setTitle:title];
    } else {
        [(UIBarButtonItem *)self.toolbarItems[1] setTitle:@""];
    }
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.fetchResult.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    
    cell.imgView.image = [UIImage imageNamed:[self.fetchResult objectAtIndex:indexPath.row]] ;
    cell.text.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-20)/2, (SCREEN_WIDTH-20)/2);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 5, 5);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"选择%ld",indexPath.row);
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(NSBundle *)assetBundle{
    // Get asset bundle
    if (_assetBundle) {
        _assetBundle = [NSBundle bundleForClass:[self class]];
        NSString *bundlePath = [_assetBundle pathForResource:@"BSImagePicker" ofType:@"bundle"];
        if (bundlePath) {
            _assetBundle = [NSBundle bundleWithPath:bundlePath];
        }
        
    }
    return _assetBundle;
}

@end
