//
//  DetailViewController.h
//  MeetMeUp
//
//  Created by Jonathan Chou on 11/3/14.
//  Copyright (c) 2014 Jonathan Chou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Results.h"

@interface DetailViewController : UIViewController
@property Results *results;
@property NSString *resultsID;

@end
