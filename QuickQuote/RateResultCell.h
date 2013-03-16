//
//  RateResultCell.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/16/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RateResultCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UILabel *carrierName;
@property (weak, nonatomic) IBOutlet UILabel *transitDays;
@property (weak, nonatomic) IBOutlet UILabel *totalCarrierCharges;
@property (weak, nonatomic) IBOutlet UILabel *transitMode;
@property (weak, nonatomic) IBOutlet UILabel *serviceMode;
@property (weak, nonatomic) IBOutlet UILabel *distance;

@end
