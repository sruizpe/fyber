//
//  OfferCell.m
//  fyberChallenge
//
//  Created by Sergio Ruiz Pérez on 27/09/15.
//  Copyright © 2015 Fyber. All rights reserved.
//

#import "OfferCell.h"
#import "Offer.h"
#import "NetworkHelper.h"

@interface OfferCell()

@property (weak, nonatomic) IBOutlet UILabel *lblOfferTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblOfferTeaser;
@property (weak, nonatomic) IBOutlet UILabel *lblOfferPayout;
@property (weak, nonatomic) IBOutlet UIImageView *imgOfferThumbnail;

@property (weak, nonatomic) Offer *offer;

@end

@implementation OfferCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.lblOfferTitle.text = nil;
    self.lblOfferTeaser.text = nil;
    self.lblOfferPayout.text = nil;
    self.imgOfferThumbnail.image = nil;
}

- (void)setupWithOffer:(Offer *)offer
{
    self.offer = offer;
    
    self.lblOfferTitle.text = offer.offerTitle;
    self.lblOfferTeaser.text = offer.offerTeaser;
    self.lblOfferPayout.text = offer.offerPayoutTime.offerPayoutAmountReadable;
    
    NSString *imageUrl = offer.offerThumbnail.offerThumbnailLowres;
    if ([imageUrl length] > 0) {
        [[NetworkHelper sharedManager] getImageUrl:imageUrl completion:^(id object, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.offer.offerId isEqualToNumber:offer.offerId]) {
                    [self.imgOfferThumbnail setImage:object];
                }
            });
        }];
    }
}

@end
