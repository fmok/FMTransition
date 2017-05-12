//
//  NavFormViewController.m
//  Demo2
//
//  Created by fm on 2017/5/12.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "NavFromViewController.h"
#import "NavToViewController.h"

@interface NavFromViewController ()

@property (nonatomic, strong) UIButton *pushBtn;

@end

@implementation NavFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.f green:arc4random_uniform(255)/255.f blue:arc4random_uniform(255)/255.f alpha:1];
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.pushBtn];
    [self.pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
}

#pragma mark - Events
- (void)pushAction:(UIButton *)sender
{
    NavToViewController *vc = [[NavToViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter & setter
- (UIButton *)pushBtn
{
    if (!_pushBtn) {
        _pushBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_pushBtn setTitle:@"push" forState:UIControlStateNormal];
        _pushBtn.backgroundColor = [UIColor yellowColor];
        [_pushBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_pushBtn addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushBtn;
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
