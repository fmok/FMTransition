//
//  FMNavgationController.m
//  Demo2
//
//  Created by fm on 2017/5/12.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMNavgationController.h"
#import <objc/runtime.h>
#import "FMPushInteractiveTransition.h"
#import "FMPopInteractiveTransition.h"

static NSString * PushSegueIdentifier = @"push segue identifier";

@interface FMNavgationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>
{
    BOOL isHandling;
}
//******************************************************************************************************************
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *fullscreenPopGestureRecognizer;

//******************************************************************************************************************
@property (nonatomic, strong) FMPushInteractiveTransition *mPushTransition;
@property (nonatomic, strong) FMPopInteractiveTransition *mPopTransition;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *mInteractiveTransition;
@property (nonatomic, strong) UIViewController *popVC;

@end

@implementation FMNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//******************************************************************************************************************
//    [self fullScreenPop];
//******************************************************************************************************************
    self.delegate = self;
}

//******************************************************************************************************************
#pragma mark - Private methods
- (void)addGes:(UIViewController *)toVC
{
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [toVC.view addGestureRecognizer:self.panGestureRecognizer];
}

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer
{
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    static CGFloat beginX;
    CGFloat currentX = [gestureRecognizer translationInView:window].x;
    CGFloat percent = (currentX - beginX) / CGRectGetWidth(window.bounds);
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            isHandling = YES;
            beginX = [gestureRecognizer translationInView:window].x;
            [self.popVC.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            [self.mInteractiveTransition updateInteractiveTransition:percent];
            break;
        case UIGestureRecognizerStateEnded:
            isHandling = NO;
            if (percent > 0.5) {
                [self.mInteractiveTransition finishInteractiveTransition];
            } else {
                [self.mInteractiveTransition cancelInteractiveTransition];
            }
            break;
        default:
            break;
    }
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    self.popVC = toVC;
    [self addGes:self.popVC];
    if (operation == UINavigationControllerOperationPush) {
        return self.mPushTransition;
    } else if (operation == UINavigationControllerOperationPop) {
        [self.mInteractiveTransition updateInteractiveTransition:0];
        return self.mPopTransition;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if (isHandling && animationController == self.mPopTransition) {
        return self.mInteractiveTransition;
    }
    return nil;
}

#pragma mark - getter & setter
- (FMPushInteractiveTransition *)mPushTransition
{
    if (!_mPushTransition) {
        _mPushTransition = [FMPushInteractiveTransition new];
    }
    return _mPushTransition;
}

- (FMPopInteractiveTransition *)mPopTransition
{
    if (!_mPopTransition) {
        _mPopTransition = [FMPopInteractiveTransition new];
    }
    return _mPopTransition;
}

- (UIPercentDrivenInteractiveTransition *)mInteractiveTransition
{
    if (!_mInteractiveTransition) {
        _mInteractiveTransition = [UIPercentDrivenInteractiveTransition new];
    }
    return _mInteractiveTransition;
}



//********************************************************************************************************************
#pragma mark - Private methods
- (void)fullScreenPop
{
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.fullscreenPopGestureRecognizer]) {
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.fullscreenPopGestureRecognizer];
        NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        self.fullscreenPopGestureRecognizer.delegate = self;
        [self.fullscreenPopGestureRecognizer addTarget:internalTarget action:internalAction];
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}

#pragma mark - getter & setter
- (UIPanGestureRecognizer *)fullscreenPopGestureRecognizer
{
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    if (!panGestureRecognizer) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGestureRecognizer;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
