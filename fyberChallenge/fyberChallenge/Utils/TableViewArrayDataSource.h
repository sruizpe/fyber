//
//  TableviewArrayDataSource.h
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 26/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 Block type to modify the UITableView cell style. It contains a cell and an item for this cell.
 @author Sergio Ruiz
 */
typedef void (^ConfigureCellBlock)(UITableViewCell *cell, id item);

/**
 Datasource for an UITableview with an array of items for its rows and no sections.
 @author Sergio Ruiz
 */
@interface TableviewArrayDataSource : NSObject
<
    UITableViewDataSource
>


/********************************************************/
#pragma mark - Properties
/********************************************************/


/**
 Block to configure the cell.
 @author Sergio Ruiz
 */
@property (nonatomic, copy) ConfigureCellBlock configureCellBlock;

/**
 Array of items that will be represented in the UITableview rows..
 @author Sergio Ruiz
 */
@property (nonatomic, strong) NSArray   *arrayItems;

/**
 Identifier for the cell. You must register a class/nib for a UITableViewCell cell with this identifier.
 @author Sergio Ruiz
 */
@property (nonatomic, strong) NSString  *cellIdentifier;

/**
 Dictionary with a relation ship between classes and cells. Each key/value corresponds to an item class / cell class.
 @author Sergio Ruiz
 */
@property (nonatomic, strong) NSDictionary *dictionaryOfClassesAndCellIdentifiers;


/********************************************************/
#pragma mark - Methods
/********************************************************/


/**
 Returns an instance of TableViewArrayDataSource type. You must configure the array and the cell identifier properties. Also, you must register a class/nib for a UITableViewCell cell with this identifier.
 @author Sergio Ruiz
 */
+ (instancetype)datasource;

/**
 Returns an instance of TableViewArrayDataSource type with an array of items for the UITableView object. You mut configure the cell identifier property. Also, you must register a class/nib for a UITableViewCell cell with this identifier.
 @author Sergio Ruiz
 */
+ (instancetype)datasourceWithArray:(NSArray *)arrayItems;

/**
 Returns an instance of TableViewArrayDataSource type with an array of items for the UITableView object and a block to configure the cells.
 @author Sergio Ruiz
 */
+ (instancetype)datasourceWithArray:(NSArray *)arrayItems configureCellBlock:(ConfigureCellBlock)configureCellBlock;

/**
 Returns an instance of tableViewArrayDataSource type with an array of items, a relationship between items and registered cells, and a block to configure the cells.
 @author Sergio Ruiz
 */
+ (instancetype)datasourceWithArray:(NSArray *)arrayItems dictionaryWithItemClassesAndCellIds:(NSDictionary *)dictionary configureCellBlock:(ConfigureCellBlock)configureCellBlock;


@end




