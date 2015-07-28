//
//  BSAssetsViewController.m
//  BSImagePicker
//
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSPhotoTakeViewController.h"
#import <Photos/Photos.h>
#import "BSIFTTHeader.h"
// Views
#import "BSImagePickerController.h"
#import "BSAssetCell.h"
#import "BSVideoIndicatorView.h"

@interface BSPhotoImagePickerController (Private)

@property (nonatomic, strong) NSMutableOrderedSet *selectedAssets;
@property (nonatomic, strong) NSBundle *assetBundle;

@end

@implementation NSIndexSet (Convenience)

- (NSArray *)indexPathsFromIndexesWithSection:(NSUInteger)section
{
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [indexPaths addObject:[NSIndexPath indexPathForItem:idx inSection:section]];
    }];
    return indexPaths;
}

@end

@implementation UICollectionView (Convenience)

- (NSArray *)indexPathsForElementsInRect:(CGRect)rect
{
    NSArray *allLayoutAttributes = [self.collectionViewLayout layoutAttributesForElementsInRect:rect];
    if (allLayoutAttributes.count == 0) { return nil; }
    
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:allLayoutAttributes.count];
    for (UICollectionViewLayoutAttributes *layoutAttributes in allLayoutAttributes) {
        NSIndexPath *indexPath = layoutAttributes.indexPath;
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

@end

@interface BSPhotoTakeViewController () <UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate, UICollectionViewDataSource
>
{
  
}

@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneButton;



@property (nonatomic, strong) PHCachingImageManager *imageManager;

@property (nonatomic, assign) CGRect previousPreheatRect;

@property (nonatomic, assign) BOOL disableScrollToBottom;

@property (nonatomic, strong) NSIndexPath *lastSelectedItemIndexPath;

@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;



@property (nonatomic, copy) NSString *prompt;

- (IBAction)backClick:(id)sender;

@end

@implementation BSPhotoTakeViewController
@synthesize collectionViewLayout=_collectionViewLayout;
@synthesize fetchResult=_fetchResult;

@synthesize imagePickerController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.collectionView = [[UICollectionView alloc]initWithFrame:
     //                      CGRectMake(0, 66, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:self.collectionViewLayout];
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self setUpToolbarItems];
    [self resetCachedAssets];
}



-(NSMutableArray *)fetchResult{
    if (!_fetchResult) {
        _fetchResult=[NSMutableArray array];
        //
    }
    return _fetchResult;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Configure collection view
    self.collectionView.allowsMultipleSelection = self.imagePickerController.allowsMultipleSelection;
    
    // Show/hide 'Done' button
    if (self.imagePickerController.allowsMultipleSelection) {
        [self.navigationItem setRightBarButtonItem:self.doneButton animated:NO];
    } else {
        [self.navigationItem setRightBarButtonItem:nil animated:NO];
    }
    
    [self updateDoneButtonState];
    [self updateSelectionInfo];
    
    // Scroll to bottom
    if (self.fetchResult.count > 0  && !self.disableScrollToBottom) {
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
    
    [self updateCachedAssets];
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

- (void)dealloc
{
    // Deregister observer
    [self.fetchResult removeAllObjects];
}


#pragma mark - Accessors



- (BOOL)isAutoDeselectEnabled
{
    return (self.imagePickerController.maximumNumberOfSelection == 1
            && self.imagePickerController.maximumNumberOfSelection >= self.imagePickerController.minimumNumberOfSelection);
}


#pragma mark - Actions

- (IBAction)done:(id)sender
{

    if ([self.imagePickerController.delegate respondsToSelector:@selector(imagePhotoPickerController:didFinishPickingAssets:)]) {
        [self.imagePickerController.delegate imagePhotoPickerController:self.imagePickerController
                                                 didFinishPickingAssets:[NSMutableArray arrayWithArray:self.imagePickerController.selectedAssets.array]];
        //[self.imagePickerController.selectedAssets removeAllObjects];
        //[self backClick];
    }
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

- (void)updateSelectionInfo
{
    
    NSMutableOrderedSet *selectedAssets = self.imagePickerController.selectedAssets;
    
    if (selectedAssets.count > 0) {
        NSBundle *bundle = self.imagePickerController.assetBundle;
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


#pragma mark - Fetching Assets

- (void)updateFetchRequest
{
    
    BSLog(@"updateFetchRequest");
}


#pragma mark - Checking for Selection Limit

- (BOOL)isMinimumSelectionLimitFulfilled
{
    return (self.imagePickerController.minimumNumberOfSelection <= self.imagePickerController.selectedAssets.count);

}

- (BOOL)isMaximumSelectionLimitReached
{
    NSUInteger minimumNumberOfSelection = MAX(1, self.imagePickerController.minimumNumberOfSelection);
    
    if (minimumNumberOfSelection <= self.imagePickerController.maximumNumberOfSelection) {
        return (self.imagePickerController.maximumNumberOfSelection <= self.imagePickerController.selectedAssets.count);
    }
    return NO;
}

- (void)updateDoneButtonState
{
    self.doneButton.enabled = [self isMinimumSelectionLimitFulfilled];
}


#pragma mark - Asset Caching

- (void)resetCachedAssets
{
    [self.imageManager stopCachingImagesForAllAssets];
    self.previousPreheatRect = CGRectZero;
}

- (void)updateCachedAssets
{
    BOOL isViewVisible = [self isViewLoaded] && self.view.window != nil;
    if (!isViewVisible) { return; }
    
    // The preheat window is twice the height of the visible rect
    CGRect preheatRect = self.collectionView.bounds;
    preheatRect = CGRectInset(preheatRect, 0.0, -0.5 * CGRectGetHeight(preheatRect));
    
    // If scrolled by a "reasonable" amount...
    CGFloat delta = ABS(CGRectGetMidY(preheatRect) - CGRectGetMidY(self.previousPreheatRect));
    
    if (delta > CGRectGetHeight(self.collectionView.bounds) / 3.0) {
        // Compute the assets to start caching and to stop caching
        NSMutableArray *addedIndexPaths = [NSMutableArray array];
        NSMutableArray *removedIndexPaths = [NSMutableArray array];
        
        [self computeDifferenceBetweenRect:self.previousPreheatRect andRect:preheatRect addedHandler:^(CGRect addedRect) {
            NSArray *indexPaths = [self.collectionView indexPathsForElementsInRect:addedRect];
            [addedIndexPaths addObjectsFromArray:indexPaths];
        } removedHandler:^(CGRect removedRect) {
            NSArray *indexPaths = [self.collectionView indexPathsForElementsInRect:removedRect];
            [removedIndexPaths addObjectsFromArray:indexPaths];
        }];

        self.previousPreheatRect = preheatRect;
    }
}

- (void)computeDifferenceBetweenRect:(CGRect)oldRect andRect:(CGRect)newRect addedHandler:(void (^)(CGRect addedRect))addedHandler removedHandler:(void (^)(CGRect removedRect))removedHandler
{
    if (CGRectIntersectsRect(newRect, oldRect)) {
        CGFloat oldMaxY = CGRectGetMaxY(oldRect);
        CGFloat oldMinY = CGRectGetMinY(oldRect);
        CGFloat newMaxY = CGRectGetMaxY(newRect);
        CGFloat newMinY = CGRectGetMinY(newRect);
        
        if (newMaxY > oldMaxY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, oldMaxY, newRect.size.width, (newMaxY - oldMaxY));
            addedHandler(rectToAdd);
        }
        if (oldMinY > newMinY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, (oldMinY - newMinY));
            addedHandler(rectToAdd);
        }
        if (newMaxY < oldMaxY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, (oldMaxY - newMaxY));
            removedHandler(rectToRemove);
        }
        if (oldMinY < newMinY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, oldMinY, newRect.size.width, (newMinY - oldMinY));
            removedHandler(rectToRemove);
        }
    } else {
        addedHandler(newRect);
        removedHandler(oldRect);
    }
}

- (NSArray *)assetsAtIndexPaths:(NSArray *)indexPaths
{
    if (indexPaths.count == 0) { return nil; }
    
    NSMutableArray *assets = [NSMutableArray arrayWithCapacity:indexPaths.count];
    for (NSIndexPath *indexPath in indexPaths) {
        if (indexPath.item < self.fetchResult.count) {
            UIImage *asset = self.fetchResult[indexPath.item];
            [assets addObject:asset];
        }
    }
    return assets;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateCachedAssets];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.fetchResult.count;
}

/**
 *显示集合内容Cell
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BSAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AssetCell" forIndexPath:indexPath];
    cell.tag = indexPath.item;
    cell.showsOverlayViewWhenSelected = self.imagePickerController.allowsMultipleSelection;
    ;
    // Image
    UIImage *image= self.fetchResult[indexPath.item];
    cell.imageView.image=image;

    cell.videoIndicatorView.hidden = YES;

    
    // Selection state
    if ([self.imagePickerController.selectedAssets containsObject:image]) {
        [cell setSelected:YES];
        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    BSLog(@"viewForSupplementaryElementOfKind");
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                  withReuseIdentifier:@"FooterView"
                                                                                         forIndexPath:indexPath];
        
        NSBundle *bundle = self.imagePickerController.assetBundle;
        // Number of assets
        UILabel *label = (UILabel *)[footerView viewWithTag:1];
        NSUInteger numberOfPhotos = self.fetchResult.count;
        
        NSString *key = (numberOfPhotos == 1) ? @"assets.footer.photo" : @"assets.footer.photos";
        NSString *format = NSLocalizedStringFromTableInBundle(key, @"BSImagePicker", bundle, nil);
        
        label.text = [NSString stringWithFormat:format, numberOfPhotos];
        return footerView;
    }

    return nil;
}


#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.imagePickerController.delegate respondsToSelector:@selector(imagePickerController:shouldSelectAsset:)]) {
        UIImage *asset = self.fetchResult[indexPath.item];
        return [self.imagePickerController.delegate imagePhotoPickerController:self.imagePickerController shouldSelectAsset:asset];
    }
    
    if ([self isAutoDeselectEnabled]) {
        return YES;
    }
    
    BSLog(@"shouldSelectItemAtIndexPath");
    return ![self isMaximumSelectionLimitReached];
}

/**
 *集合单元格操作
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSMutableOrderedSet *selectedAssets = imagePickerController.selectedAssets;
    
    UIImage *asset = self.fetchResult[indexPath.item];
    
    if (self.imagePickerController.allowsMultipleSelection) {//多选
        if ([self isAutoDeselectEnabled] && selectedAssets.count > 0) {
            // Remove previous selected asset from set
            [selectedAssets removeObjectAtIndex:0];
            
            // Deselect previous selected asset
            if (self.lastSelectedItemIndexPath) {
                [collectionView deselectItemAtIndexPath:self.lastSelectedItemIndexPath animated:NO];
            }
        }
        
        // Add asset to set
        [selectedAssets addObject:asset];
        
        self.lastSelectedItemIndexPath = indexPath;
        
        [self updateDoneButtonState];
        
        if (self.imagePickerController.showsNumberOfSelectedAssets) {
            [self updateSelectionInfo];
            
            if (selectedAssets.count == 1) {
                // Show toolbar
                [self.navigationController setToolbarHidden:NO animated:YES];
            }
        }
    } else {//单选
        //
        NSMutableArray *array=[NSMutableArray arrayWithArray:@[asset]];
        if ([imagePickerController.delegate respondsToSelector:@selector(imagePhotoPickerController:didFinishPickingAssets:)]) {
            [imagePickerController.delegate imagePhotoPickerController:imagePickerController didFinishPickingAssets:array];
        }
        
    }
    
    if ([imagePickerController.delegate respondsToSelector:@selector(imagePhotoPickerController:didSelectAsset:)]) {
        [imagePickerController.delegate imagePhotoPickerController:imagePickerController didSelectAsset:asset];
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.imagePickerController.allowsMultipleSelection) {
        return;
    }
    
    NSMutableOrderedSet *selectedAssets = imagePickerController.selectedAssets;
    
    UIImage *asset = self.fetchResult[indexPath.item];
    
    // Remove asset from set
    [selectedAssets removeObject:asset];
    
    self.lastSelectedItemIndexPath = nil;
    
    [self updateDoneButtonState];
    
    if (self.imagePickerController.showsNumberOfSelectedAssets) {
        [self updateSelectionInfo];
        
        if (selectedAssets.count == 0) {
            // Hide toolbar
            [self.navigationController setToolbarHidden:YES animated:YES];
        }
    }
    
    if ([imagePickerController.delegate respondsToSelector:@selector(imagePhotoPickerController:didDeselectAsset:)]) {
        [imagePickerController.delegate imagePhotoPickerController:imagePickerController didDeselectAsset:asset];
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout
//调整Cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger numberOfColumns;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        numberOfColumns = self.imagePickerController.numberOfColumnsInPortrait;
    } else {
        numberOfColumns = self.imagePickerController.numberOfColumnsInLandscape;
    }
    
    CGFloat width = (CGRectGetWidth(self.view.frame) - 2.0 * (numberOfColumns - 1)) / numberOfColumns;
    
    return CGSizeMake(width, width);
}


- (IBAction)backClick:(id)sender {
    //[self backClick];
}
@end
