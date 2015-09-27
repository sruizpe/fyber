//
//  OfferCell.h
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 27/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Offer;

@interface OfferCell : UITableViewCell

- (void)setupWithOffer:(Offer *)offer;

@end
