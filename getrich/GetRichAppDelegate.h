//
//  AppDelegate.h
//  getrich
//
//  Created by huamulou on 14-9-24.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XHDrawerController;

@interface GetRichAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) XHDrawerController *drawerController;

@end
