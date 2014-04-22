//
// Mikael Bartlett [mikael@nixonnixon.se] / NIXON NIXON
// Date: 22/04/14 22:01
//

#import "MEAboveAnimationController.h"

@interface MEAboveAnimationController ()
@property (nonatomic, copy) void (^coordinatorAnimations)(id<UIViewControllerTransitionCoordinatorContext>context);
@property (nonatomic, copy) void (^coordinatorCompletion)(id<UIViewControllerTransitionCoordinatorContext>context);
@end

@implementation MEAboveAnimationController
{

}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
	return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
	UIViewController *topViewController = [transitionContext viewControllerForKey:ECTransitionContextTopViewControllerKey];
	UIViewController *underLeftViewController = [transitionContext viewControllerForKey:ECTransitionContextUnderLeftControllerKey];
	UIView *containerView = [transitionContext containerView];
	CGRect topViewInitialFrame = [transitionContext initialFrameForViewController:topViewController];
	CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:underLeftViewController];

	topViewController.view.frame = topViewInitialFrame;

	underLeftViewController.view.frame = [transitionContext initialFrameForViewController:underLeftViewController];
	[containerView insertSubview:underLeftViewController.view aboveSubview:topViewController.view];

	NSTimeInterval duration = [self transitionDuration:transitionContext];
	[UIView animateWithDuration:duration animations:^{
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		if (self.coordinatorAnimations) self.coordinatorAnimations((id<UIViewControllerTransitionCoordinatorContext>)transitionContext);
		underLeftViewController.view.frame = toViewFinalFrame;
	} completion:^(BOOL finished) {
		if ([transitionContext transitionWasCancelled]) {
			underLeftViewController.view.frame = [transitionContext initialFrameForViewController:underLeftViewController];
		}

		if (self.coordinatorCompletion) self.coordinatorCompletion((id<UIViewControllerTransitionCoordinatorContext>)transitionContext);
		[transitionContext completeTransition:finished];
	}];
}

#pragma mark - ECSlidingViewControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)slidingViewController:(ECSlidingViewController *)slidingViewController animationControllerForOperation:(ECSlidingViewControllerOperation)operation topViewController:(UIViewController *)topViewController
{
	return self;
}

- (id <ECSlidingViewControllerLayout>)slidingViewController:(ECSlidingViewController *)slidingViewController layoutControllerForTopViewPosition:(ECSlidingViewControllerTopViewPosition)topViewPosition
{
	return self;
}

#pragma mark - ECSlidingViewControllerLayout

- (CGRect)slidingViewController:(ECSlidingViewController *)slidingViewController frameForViewController:(UIViewController *)viewController topViewPosition:(ECSlidingViewControllerTopViewPosition)topViewPosition
{
	if (topViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight && viewController == slidingViewController.topViewController) {
		return [self topViewAnchoredRightFrame:slidingViewController];
	} else if (topViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight) {
		return [self topViewAnchoredRightFrame:slidingViewController];
	}
	else if (topViewPosition == ECSlidingViewControllerTopViewPositionCentered && viewController == slidingViewController.topViewController) {
		return [self topViewAnchoredRightFrame:slidingViewController];
	} else if (topViewPosition == ECSlidingViewControllerTopViewPositionCentered) {
		return [self underViewAnchoredRightFrame:slidingViewController];
	}
	return CGRectInfinite;
}

#pragma mark - Private

- (CGRect)topViewAnchoredRightFrame:(ECSlidingViewController *)slidingViewController {
	CGRect frame = slidingViewController.view.bounds;

	frame.origin.x    = 0;
	frame.size.width  = frame.size.width;
	frame.size.height = frame.size.height;
	frame.origin.y    = 0;

	return frame;
}

- (CGRect)underViewAnchoredRightFrame:(ECSlidingViewController *)slidingViewController {
	CGRect frame = slidingViewController.view.bounds;

	frame.origin.x    = -frame.size.width;
	frame.size.width  = frame.size.width;
	frame.size.height = frame.size.height;
	frame.origin.y    = 0;

	return frame;
}

@end