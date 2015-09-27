//
//  ViewController.m
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 26/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import "ViewController.h"
#import "NetworkHelper.h"
#import "TableViewArrayDataSource.h"
#import "OfferCell.h"

static NSString *show_embeb_tableview = @"embedOffersTableView";
static float tableview_cell_size = 85.0;

@interface ViewController ()
<
    UITableViewDelegate
>

@property (strong, nonatomic) UITableViewController *tableViewController;
@property (strong, nonatomic) TableviewArrayDataSource *datasource;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (strong, nonatomic) NSArray *itemsArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableViewController.tableView.contentInset = UIEdgeInsetsZero;
    _tableViewController.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableViewController.tableView.rowHeight = UITableViewAutomaticDimension;
    _tableViewController.tableView.estimatedRowHeight = tableview_cell_size;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshOffersList) forControlEvents:UIControlEventValueChanged];
    [self.tableViewController.tableView addSubview:self.refreshControl];
    
    _datasource.arrayItems = self.itemsArray;
    
    [self refreshOffersList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Private methods

- (void)refreshOffersList
{
    [[NetworkHelper sharedManager] getOffersWithCompletion:^(NSArray *array, NSError *error) {
        if (!error) {
            if ([array count] > 0) {
                [self showTableViewWithOffers:array];
                return;
            }
            [self showAlertWithDescription:@"No offers"];
            return;
        }
        [self showAlertWithDescription:[[error userInfo] objectForKey:NSLocalizedDescriptionKey]];
    }];
}

- (void)showTableViewWithOffers:(NSArray *)offers
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.datasource.arrayItems = offers;
        
        [self.tableViewController.tableView reloadData];
        [self.refreshControl endRefreshing];
    });
}

- (void)showAlertWithDescription:(NSString *)description
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Fyber" message:description preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:alertAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:show_embeb_tableview])
    {
        self.tableViewController = segue.destinationViewController;
        self.datasource = [TableviewArrayDataSource datasourceWithArray:_itemsArray
                                    dictionaryWithItemClassesAndCellIds:@{@"Offer"  : @"OfferCell"
                                                                          }
                                                     configureCellBlock:^(UITableViewCell *cell, id item) {
                                                         if ([item isKindOfClass:[Offer class]]) {
                                                             OfferCell *offerCell = (OfferCell *)cell;
                                                             [offerCell setupWithOffer:item];
                                                         }
                                                     }];
        self.tableViewController.tableView.dataSource = self.datasource;
        self.tableViewController.tableView.delegate = self;
    }
}

#pragma mark - UITableViewDelegate methods

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return tableview_cell_size;
//}

- (void)dealloc
{
    self.refreshControl = nil;
    self.tableViewController = nil;
    self.datasource = nil;
    self.itemsArray = nil;
}

@end
