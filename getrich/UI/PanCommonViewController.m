#import "PanCommonViewController.h"
#import "UIViewController+ECSlidingViewController.h"


@interface PanCommonViewController ()
@end

@implementation PanCommonViewController

@synthesize commonGestureRecognizer = _commonGestureRecognizer;
@synthesize isPassingPanGesture = _isPassingPanGesture;

- (UIGestureRecognizer *)commonGestureRecognizer {
    if (!_commonGestureRecognizer) {
       _commonGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doingPan:)];

    }
    return _commonGestureRecognizer;
}


- (void)doingPan:(UIPanGestureRecognizer *)recognizer {
    CGFloat translationX = [recognizer translationInView:self.view].x;
    CGFloat translationY = [recognizer translationInView:self.view].y;

    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            if (abs(translationY) <= abs(translationX)) {
                _isPassingPanGesture = true;
            } else {
                _isPassingPanGesture = false;
            }

        }
            default:
            break;
    }
    if (_isPassingPanGesture) {
        [self.slidingViewController detectPanGestureRecognizer:recognizer];
    } else {
        [self doGesture:recognizer];
    }

}

- (void)doGesture:(UIPanGestureRecognizer *)recognizer {
    //do nothing
}


@end