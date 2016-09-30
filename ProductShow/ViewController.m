//
//  ViewController.m
//  AppleProduct
//
//  Created by runlin on 16/9/28.
//  Copyright © 2016年 gavin. All rights reserved.
//

#import "ViewController.h"
#import "Product.h"


@interface ViewController () <NSTableViewDataSource, NSTableViewDelegate>
{
    NSMutableArray *_storeArray;
}

@property (weak) IBOutlet NSTableView *cityStoreTableview;
@property (weak) IBOutlet NSTableView *detailedTableview;




@end


@implementation ViewController 


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [Product getProductList:nil Success:^(NSURLSessionDataTask *task, NSArray *result) {
        
//        NSLog(@"%@",result);
        _storeArray = [[NSMutableArray alloc] initWithArray:result];
        
        [self.cityStoreTableview reloadData];
        [self.detailedTableview reloadData];
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}



#pragma mark - TableView DataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    if (tableView == self.cityStoreTableview) {
        return _storeArray.count;
    }else if(tableView == self.detailedTableview){
        return _storeArray.count;
    } else{
        return 0;
    }
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if (tableView == self.cityStoreTableview) {
        
        Product *product = _storeArray[row];
        return product.storeName;
        
    }else if(tableView == self.detailedTableview){
        
        if ([tableColumn.identifier isEqualToString:@"Monitoring"]) {
            return @(YES);
            
        }else if ([tableColumn.identifier isEqualToString:@"Model"]){
            return @"Model";
            
        }else if([tableColumn.identifier isEqualToString:@"Product"]){
            return @"Product";
            
        }else if([tableColumn.identifier isEqualToString:@"Capacity"]){
            return @"Capacity";
            
        }else if([tableColumn.identifier isEqualToString:@"Status"]){
            return @"Status";
            
        }else {
            return nil;
        }
        
        return @"2";
    }else {
        return nil;
    }
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSLog(@"%@",object);
}

- (IBAction)cityStoreTableviewAction:(NSTableView *)sender {
    NSLog(@"%zd",sender.selectedRow);
}

- (IBAction)detailedTableviewAction:(NSTableView *)sender {
     NSLog(@"%zd",sender.selectedRow);
}


@end
