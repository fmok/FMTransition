//
//  ModalViewController.m
//  Demo2
//
//  Created by fm on 2017/5/11.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ModalToViewController.h"

@interface ModalToViewController ()

@property (nonatomic, strong) FMPanModalTransition *transition;
@property (nonatomic, strong) UIButton *dismissBtn;

@end

@implementation ModalToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.f green:arc4random_uniform(255)/255.f blue:arc4random_uniform(255)/255.f alpha:1];
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.dismissBtn];
    [self.dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
}

#pragma mark - Events
- (void)dismissAction:(UIButton *)sender
{
    [self.transition dismissViewController:self animated:YES completion:nil];
}

#pragma mark - getter & setter
- (UIButton *)dismissBtn
{
    if (!_dismissBtn) {
        _dismissBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_dismissBtn setTitle:@"dismiss" forState:UIControlStateNormal];
        _dismissBtn.backgroundColor = [UIColor yellowColor];
        [_dismissBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_dismissBtn addTarget:self action:@selector(dismissAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissBtn;
}

- (FMPanModalTransition *)transition
{
    if (!_transition) {
        _transition = [FMPanModalTransition new];
    }
    return _transition;
}


- (void)dealloc
{
    NSLog(@"\n*** %@ ** %s ***\n", self.class, __func__);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"\n *** %@ ** %s ***\n", self.class, __func__);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"\n *** %@ ** %s ***\n", self.class, __func__);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"\n *** %@ ** %s ***\n", self.class, __func__);
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"\n *** %@ ** %s ***\n", self.class, __func__);
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
