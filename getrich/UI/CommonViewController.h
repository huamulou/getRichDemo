//
//  CommonViewController.h
//  getrich
//
//  Created by huamulou on 14-9-28.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RingView.h"

@class XHDrawerController;

@interface CommonViewController : UIViewController


@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;


@property(nonatomic, retain) NSString *xhDrawerControllerStoryboardId;
@end
