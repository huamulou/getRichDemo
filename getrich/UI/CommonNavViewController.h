//
//  CommonNavViewController.h
//  getrich
//
//  Created by huamulou on 14-10-13.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonNavViewController : UINavigationController<UIGestureRecognizerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITabBarItem *tabItem;

@end
