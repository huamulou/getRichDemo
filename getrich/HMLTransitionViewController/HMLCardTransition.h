/**
// Copyright (c) 2014 huamulou. All rights reserved.

 * //                       _oo0oo_
 * //                      o8888888o
 * //                      88" . "88
 * //                      (| -_- |)
 * //                      0\  =  /0
 * //                    ___/`---'\___
 * //                  .' \\|     |// '.
 * //                 / \\|||  :  |||// \
 * //                / _||||| -:- |||||- \
 * //               |   | \\\  -  /// |   |
 * //               | \_|  ''\---/''  |_/ |
 * //               \  .-\__  '-'  ___/-. /
 * //             ___'. .'  /--.--\  `. .'___
 * //          ."" '<  `.___\_<|>_/___.' >' "".
 * //         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
 * //         \  \ `_.   \_ __\ /__ _/   .-` /  /
 * //     =====`-.____`.___ \_____/___.-`___.-'=====
 * //                       `=---='
 * //     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * //
 * //               佛祖保佑         永无BUG
 */


//

#import <Foundation/Foundation.h>
#import "HMLTransitionViewController.h"
#import "HMLPercentDrivenInteractiveTransition.h"
#import "HMLInteractiveTransition.h"


@interface HMLCardTransition :  HMLInteractiveTransition <UIViewControllerAnimatedTransitioning, HMLTansitionViewControllerDelegate, UIViewControllerInteractiveTransitioning>


/**
The default duration of the view transition.

动画的长度
*/
@property (nonatomic, assign) NSTimeInterval defaultTransitionDuration;

@end