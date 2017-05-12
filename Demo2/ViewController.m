//
//  ViewController.m
//  Demo2
//
//  Created by fm on 2017/5/11.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *typeArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class cls = NSClassFromString(self.typeArr[indexPath.row]);
    UIViewController *vc = [[cls alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.typeArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.typeArr[indexPath.row];
    return cell;
}

#pragma mark - getter & setter
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

- (NSMutableArray *)typeArr
{
    if (!_typeArr) {
        _typeArr = [[NSMutableArray alloc] initWithObjects:@"ModalFromViewController", @"NavFromViewController", nil];
    }
    return _typeArr;
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


@end
