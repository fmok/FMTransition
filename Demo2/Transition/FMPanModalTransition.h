//
//  FMPanModalTransition.h
//  Demo2
//
//  Created by fm on 2017/5/11.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//********************************************************************************************

@interface FMPercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;

- (void)wireToViewController:(UIViewController*)viewController;

@end

//********************************************************************************************

@interface FMPanModalTransition : NSObject<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) FMPercentDrivenInteractiveTransition *mPercentDrivenInteractiveTransition;

@end
