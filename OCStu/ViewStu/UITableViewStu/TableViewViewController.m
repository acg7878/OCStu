//
//  TableViewViewController.m
//  OCStu
//
//  Created by Derek on 2026/01/02.
//

#import "TableViewViewController.h"
#import <Masonry/Masonry.h>

@interface TableViewViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *dataSource; // 简单数据源

@end

@implementation TableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"水果列表";
    self.dataSource = @[@"🍎 苹果", @"🍌 香蕉", @"🍐 梨子", @"🍉 西瓜", @"🍇 葡萄"];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    // numberOfRowsInSection、cellForRowAtIndexPath等方法需要实现，这里由自己实现了，所以设置代理为自己
    // dataSource同理
    // 如果需要可以单独抽出一个类
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 注册 Cell（使用复用机制）
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"FruitCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource（必须实现）

// 告诉 TableView 有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

// 配置每一行的 Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 从复用池取 Cell（如果没有会自动创建）
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FruitCell" forIndexPath:indexPath];
    
    // 配置 Cell 数据
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // 右箭头
    
    // 返回配置好的 Cell
    return cell;
}

#pragma mark - UITableViewDelegate（可选实现）

// 点击某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选中高亮（带动画）
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 获取点击的数据
    NSString *fruit = self.dataSource[indexPath.row];
    
    // 弹窗提示
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你选择了"
                                                                   message:fruit
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
    NSLog(@"点击了第 %ld 行：%@", (long)indexPath.row, fruit);
}

@end
