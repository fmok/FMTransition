//
//  ModalFromViewController.m
//  Demo2
//
//  Created by fm on 2017/5/11.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ModalFromViewController.h"
#import "ModalToViewController.h"

@interface ModalFromViewController ()

@property (nonatomic, strong) FMPanModalTransition *transition;
@property (nonatomic, strong) UIButton *presentBtn;

@end

@implementation ModalFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.f green:arc4random_uniform(255)/255.f blue:arc4random_uniform(255)/255.f alpha:1];
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.presentBtn];
    [self.presentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
}

#pragma mark - Events
- (void)presentAction:(UIButton *)sender
{
    ModalToViewController *vc = [[ModalToViewController alloc] init];
    self.transition = [[FMPanModalTransition alloc] init];
    vc.transitioningDelegate = self.transition;
    [self.transition.mPercentDrivenInteractiveTransition wireToViewController:vc];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - getter & setter
- (UIButton *)presentBtn
{
    if (!_presentBtn) {
        _presentBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_presentBtn setTitle:@"prersent" forState:UIControlStateNormal];
        _presentBtn.backgroundColor = [UIColor yellowColor];
        [_presentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_presentBtn addTarget:self action:@selector(presentAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _presentBtn;
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
