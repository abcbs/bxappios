//
//  LOProductCatalogueDetailViewController.m
//  KTAPP
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOProductCatalogueDetailViewController.h"
#import "LOProductCatalogueMaintainViewController.h"

@implementation LOProductCatalogueDetailViewController

@dynamic productCatalogue;
@dynamic comment;
@dynamic code;
@dynamic statusValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self display];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    self.productCatalogue=nil;
    self.comment.text=nil;
    self.code.text=nil;
    self.statusValue.text=nil;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //MaintainCatalogue
    LOProductCatalogueMaintainViewController *edit = (LOProductCatalogueMaintainViewController *)segue.destinationViewController;
    edit.editDelegate = self;
    edit.productCatalogue = self.productCatalogue;;
}

-(void)modifiedStyle{
   
    if (self.productCatalogue) {
        
        [self.code setEnabled: NO];
        [self.statusValue setEnabled:NO];
        [self.comment setEnabled:NO];
    }else{
        self.navigationItem.rightBarButtonItems=nil;
        
    }
}
-(void)display{
    
    if (self.productCatalogue) {
        self.code.text=self.productCatalogue.code;
        self.comment.text=self.productCatalogue.comment;
        self.statusValue.text=self.productCatalogue.status;
    }
    
}

-(void)editedProductCatalogue:(ProductCatalogue *)catalogue{
    self.productCatalogue =catalogue ;
    
    [_browseDelegate editedProductCatalogue:self.productCatalogue];
    [self display];
}

- (void)addProductCatalogue:(ProductCatalogue *) catalogue{
    self.productCatalogue=catalogue;
    [_browseDelegate addProductCatalogue:self.productCatalogue];
    [self display];
}

@end
