//
//  EstimatedClass.m
//  QuickQuote
//
//  Created by Steven Tuckness on 3/21/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import "EstimatedClass.h"

@implementation EstimatedClass

+ (float) getEstClass:(float)density
{
    float estClass = 0;
    
    if(density >= 50 )
    {
        estClass = 50;
    }
    else if(density >= 35 && density < 50 )
    {
        estClass = 55;
    }
    else if(density >= 30 && density < 35 )
    {
        estClass = 60;
    }
    else if(density >= 22.5 && density < 30 )
    {
        estClass = 65;
    }
    else if(density >= 15 && density < 22.5 )
    {
        estClass = 70;
    }
    else if(density >= 13 && density < 15 )
    {
        estClass = 77.5;
    }
    else if(density >= 12 && density < 50 )
    {
        estClass = 85;
    }
    else if(density >= 10.5 && density < 50 )
    {
        estClass = 92.5;
    }
    else if(density >= 9 && density < 50 )
    {
        estClass = 100;
    }
    else if(density >= 8 && density < 50 )
    {
        estClass = 110;
    }
    else if(density >= 7 && density < 50 )
    {
        estClass = 125;
    }
    else if(density >= 6 && density < 50 )
    {
        estClass = 150;
    }
    else if(density >= 5 && density < 50 )
    {
        estClass = 175;
    }
    else if(density >= 4 && density < 50 )
    {
        estClass = 200;
    }
    else if(density >= 3 && density < 50 )
    {
        estClass = 250;
    }
    else if(density >= 2 && density < 50 )
    {
        estClass = 300;
    }
    else if(density >= 1 && density < 50 )
    {
        estClass = 400;
    }
    else if(density > 0 && density < 50 )
    {
        estClass = 500;
    }
    
    return estClass;
}

@end
