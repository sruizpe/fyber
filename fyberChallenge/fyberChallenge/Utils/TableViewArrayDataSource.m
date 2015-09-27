//
//  TableviewArrayDataSource.m
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 26/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//


#import "TableviewArrayDataSource.h"

/*
 + (instancetype)datasourceWithArray:(NSArray *)arrayItems configureCellIdentifier:(NSString *)identifier block:(void(^)(UITableView **cell))configureCellBlock;
 */


@interface TableviewArrayDataSource()


@end


@implementation TableviewArrayDataSource


- (void)dealloc
{
    self.arrayItems = nil;
    self.cellIdentifier = nil;
    self.cellIdentifier = nil;
}


- (instancetype)init
{
    if(self = [super init])
    {
        _arrayItems = [NSArray array];
        _configureCellBlock = nil;
        _cellIdentifier = @"cell";
    }
    return self;
}


+ (instancetype)datasource
{
    return [[TableviewArrayDataSource alloc] init];
}


+ (instancetype)datasourceWithArray:(NSArray *)arrayItems
{
    TableviewArrayDataSource *datasource = [TableviewArrayDataSource datasource];
    
    datasource.arrayItems = arrayItems;
    
    return datasource;
}


+ (instancetype)datasourceWithArray:(NSArray *)arrayItems configureCellBlock:(ConfigureCellBlock)configureCellBlock
{
    TableviewArrayDataSource *datasource = [TableviewArrayDataSource datasourceWithArray:arrayItems];
    
    datasource.configureCellBlock   = configureCellBlock;
    
    return datasource;
}


+ (instancetype)datasourceWithArray:(NSArray *)arrayItems dictionaryWithItemClassesAndCellIds:(NSDictionary *)dictionary configureCellBlock:(ConfigureCellBlock)configureCellBlock
{
    TableviewArrayDataSource *datasource = [TableviewArrayDataSource datasourceWithArray:arrayItems];
    
    datasource.dictionaryOfClassesAndCellIdentifiers    = dictionary;
    datasource.configureCellBlock                       = configureCellBlock;
    
    return datasource;
}


- (void)_configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    if(self.configureCellBlock) {
        self.configureCellBlock(cell, self.arrayItems[indexPath.row]);
    }
}


- (NSString *)_cellIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = self.cellIdentifier;
    
    if (self.dictionaryOfClassesAndCellIdentifiers) {
        
        id item = self.arrayItems[indexPath.row];
        NSString *key = NSStringFromClass([item class]);
        cellIdentifier = [self.dictionaryOfClassesAndCellIdentifiers objectForKey:key];
        NSAssert(cellIdentifier, @"You must register this class (item object) in the dictionary with a cell identifier.");
    }
    
    return cellIdentifier;
}


#pragma mark - UITableview Delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(!self.arrayItems) {
        return 0;
    }
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [self _cellIdentifierForIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    }
    
    [self _configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

@end




