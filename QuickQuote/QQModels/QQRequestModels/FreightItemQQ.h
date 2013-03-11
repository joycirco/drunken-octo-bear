//
//  FreightItem.h
//  ModelClasses
//
//  Created by Darin Raffety on 1/19/13.
//
//

#import <Foundation/Foundation.h>

@class Accessorial;

@interface FreightItemQQ : NSObject
{
    NSString* _NMFC;
    NSDecimalNumber* _freightClass;
    int _handlingUnits;
    int _handlingUnitType;
    
    NSDecimalNumber* _weight;
    NSString* _weightUOM;
    
    NSDecimalNumber* _length;
    NSDecimalNumber* _width;
    NSDecimalNumber* _height;
    NSString* _dimUOM;
    
    BOOL _isStackable;
    
    NSMutableArray* _accessorials;
    
    NSString* _freightDescription;
}

@property (nonatomic,retain) NSString* NMFC;
@property (nonatomic,retain) NSDecimalNumber* freightClass;
@property (nonatomic,assign) int handlingUnits;
@property (nonatomic,assign) int handlingUnitType;

@property (nonatomic,retain) NSDecimalNumber* weight;
@property (nonatomic,retain) NSString* weightUOM;

@property (nonatomic,retain) NSDecimalNumber* length;
@property (nonatomic,retain) NSDecimalNumber* width;
@property (nonatomic,retain) NSDecimalNumber* height;
@property (nonatomic,retain) NSString* dimUOM;

@property (nonatomic,assign) BOOL isStackable;

@property (nonatomic,retain) NSMutableArray* accessorials;

@property (nonatomic, retain) NSString* freightDescription;

- (id) init;
- (id) initWithDefaults;

-(void)addAccessorial:(Accessorial *)objAcc;
-(void)addAccessorials:(NSMutableArray *)objAccs;
-(void)removeAccessorial:(Accessorial *)objAcc;
-(void)clearAccessorials;


@end
