//
//  FMPopInteractiveTransition.m
//  Demo2
//
//  Created by fm on 2017/5/12.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMPopInteractiveTransition.h"

@implementation FMPopInteractiveTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    [containerView insertSubview:toView belowSubview:fromView];
    toView.transform = CGAffineTransformMakeTranslation(-fromView.frame.size.width*0.5, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromView.transform = CGAffineTransformMakeTranslation(toView.frame.size.width, 0);
        toView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}

@end
