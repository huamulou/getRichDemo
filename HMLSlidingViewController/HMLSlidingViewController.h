/**
// Copyright (c) 2014 huamulou. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
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


@interface HMLSlidingViewController : UIViewController


//中间view的缩放大小
@property(nonatomic, assign) CGFloat centerZoomFactor;
//side view的缩放大小
@property(nonatomic, assign) CGFloat sideZoomFactor;
//
@property(nonatomic, assign) CGFloat sideAlpha;
//完成
@property(nonatomic, assign) CGFloat distanceToEdge;


@property(nonatomic, strong) UIViewController *center;
@property(nonatomic, strong) UIViewController *left;
@property(nonatomic, strong) UIViewController *right;

@property (nonatomic, strong) UIView *gestureView;
@property(nonatomic, strong) NSString *centerStoryboardId;
@property(nonatomic, strong) NSString *leftStoryboardId;
@property(nonatomic, strong) NSString *rightStoryboardId;
/**
The default duration of the view transition.
*/
@property(nonatomic, assign) NSTimeInterval defaultTransitionDuration;

- (void)updateWithRecognizer:(UIPanGestureRecognizer *)recognizer;

- (void)centerResetFromLeftWithAnimation:(BOOL)isAnimate time:(NSTimeInterval)time;

- (void)centerResetFromLeftWithAnimation:(BOOL)isAnimate;

- (void)centerResetFromRightWithAnimation:(BOOL)isAnimate time:(NSTimeInterval)time;

- (void)centerResetFromRightWithAnimation:(BOOL)isAnimate;

- (void)centerToRightWithAnimation:(BOOL)isAnimate time:(NSTimeInterval)time;

- (void)centerToRightWithAnimation:(BOOL)isAnimate;

- (void)centerToLeftWithAnimation:(BOOL)isAnimate time:(NSTimeInterval)time;

- (void)centerToLeftWithAnimation:(BOOL)isAnimate;
@end


typedef NS_ENUM(NSInteger, HMLSlidingViewControllerOperation) {
    /** The top view is not moving. */
            HMLSlidingViewControllerOperationNone,
    /** The top view is moving from center to left. */
            HMLSlidingViewControllerOperationAnchorLeft,
    /** The top view is moving from center to right. */
            HMLSlidingViewControllerOperationAnchorRight,
    /** The top view is moving from left to center. */
            HMLSlidingViewControllerOperationResetFromLeft,
    /** The top view is moving from right to center. */
            HMLSlidingViewControllerOperationResetFromRight
};


/**
These constants define the position of a sliding view controller's top view.
*/
typedef NS_ENUM(NSInteger, HMLSlidingViewControllerTopViewPosition) {
    /** The top view is on anchored to the left */
            HMLSlidingViewControllerTopViewPositionAnchoredLeft,
    /** The top view is on anchored to the right */
            HMLSlidingViewControllerTopViewPositionAnchoredRight,
    /** The top view is centered */
            HMLSlidingViewControllerTopViewPositionCentered
};
