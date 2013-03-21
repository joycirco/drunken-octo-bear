//
//  PDFViewController.h
//  QuickQuote
//
//  Created by Darin Raffety on 3/21/13.
//  Copyright (c) 2013 EngagedTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>

@interface PDFViewController : UIViewController <QLPreviewControllerDataSource, QLPreviewControllerDelegate>
{
}

@property(nonatomic,retain) NSURL *fileURL;

@end
