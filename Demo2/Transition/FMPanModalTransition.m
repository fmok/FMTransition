//
//  FMPanModalTransition.m
//  Demo2
//
//  Created by fm on 2017/5/11.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMPanModalTransition.h"

@implementation FMPanModalTransition

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    if (toVC.isBeingPresented) {
        [containerView addSubview:toVC.view];
        
        toVC.view.transform = CGAffineTransformMakeTranslation(fromVC.view.frame.size.width, 0);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toVC.view.transform = CGAffineTransformIdentity;
            fromVC.view.transform = CGAffineTransformMakeTranslation(-fromVC.view.frame.size.width * 0.5, 0);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    
    if (fromVC.isBeingDismissed) {
        [containerView insertSubview:toVC.view belowSubview:fromVC.view];
        
        toVC.view.transform = CGAffineTransformMakeTranslation(-fromVC.view.frame.size.width * 0.5, 0);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            toVC.view.transform = CGAffineTransformIdentity;
            fromVC.view.transform = CGAffineTransformMakeTranslation(fromVC.view.frame.size.width, 0);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}


@end
