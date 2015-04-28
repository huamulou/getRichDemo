//
//  Constants.h
//  getrich
//
//  Created by huamulou on 14-10-12.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import <Foundation/Foundation.h>



#define IOS_SYS_VERSION [UIDevice currentDevice].systemVersion.floatValue

#define IOS7PLUS (IOS_SYS_VERSION >= 7.0f)
#define IOS6PLUS (IOS_SYS_VERSION >= 6.0f)
#define IOS7TO7_1 (IOS_SYS_VERSION >= 7.0f && IOS_SYS_VERSION < 7.1f)


#pragma mark - 屏幕相关配置
#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH  SCREEN_BOUNDS.width
#define SCREEN_ORGIN_HEIGHT  SCREEN_BOUNDS.height
#define STATUS_BAR_HEIGHT  20
#define SCREEN_HEIGHT  (IOS7PLUS ? SCREEN_BOUNDS.height  : (SCREEN_BOUNDS.height -STATUS_BAR_HEIGHT))
#define SCREEN_START_Y  (IOS7PLUS ? STATUS_BAR_HEIGHT : 0)


#define  BIGGER_SCREEN (SCREEN_ORGIN_HEIGHT > 480 )
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


#define POINTOFFLOAT @"."
#define PERCENT @"%"


#define DEFAULT_RADIUS 1.5f