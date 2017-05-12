//
//  FMPanModalTransition.m
//  Demo2
//
//  Created by fm on 2017/5/12.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMPushInteractiveTransition.h"

@implementation FMPushInteractiveTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    [containerView addSubview:toView];
    toView.transform = CGAffineTransformMakeTranslation(fromView.frame.size.width, 0);
    
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toVC];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromView.transform = CGAffineTransformMakeTranslation(-toViewFinalFrame.size.width*0.5, 0);
        toView.transform = CGAffineTransformMakeTranslation(toViewFinalFrame.origin.x, toViewFinalFrame.origin.y);
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}

@end
