//
//  FreightItemCell.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/21/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreightItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblhandlingUnits;
@property (weak, nonatomic) IBOutlet UILabel *lblFreightClass;
@property (weak, nonatomic) IBOutlet UILabel *lblWeight;
@property (weak, nonatomic) IBOutlet UILabel *lblDimensions;
@property (weak, nonatomic) IBOutlet UILabel *lblNMFC;
@property (weak, nonatomic) IBOutlet UILabel *lblStackable;
@property (weak, nonatomic) IBOutlet UILabel *lblFreightDescription;

@end
