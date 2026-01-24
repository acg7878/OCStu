//
//  HomeViewController.m
//  OCStu
//
//  Created by Derek on 2025/12/30.
//

#import "HomeViewController.h"
#import "MasonryViewController.h"
#import "DelegateStu.h"
#import "TableViewViewController.h"
#import "WaterFallDemoViewController.h"

// 匿名拓展
@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary *> *menuItems;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    
    // 菜单数据
    self.menuItems = @[
        @{@"title": @"Masonry 布局练习", @"subtitle": @"学习手写 UI 布局", @"controller": @"MasonryViewController"},
        @{@"title": @"UIScrollView 代理练习", @"subtitle": @"滚动与代理回调", @"controller": @"UIScrollViewController"},
        @{@"title": @"UITableView 练习", @"subtitle": @"列表视图系统学习", @"controller": @"TableViewViewController"},
        @{@"title": @"瀑布流布局练习", @"subtitle": @"自定义 CollectionView 布局", @"controller": @"WaterFallDemoViewController"}
    ];
    
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *item = self.menuItems[indexPath.row];
    cell.textLabel.text = item[@"title"];
    cell.textLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    cell.detailTextLabel.text = item[@"subtitle"];
    cell.detailTextLabel.textColor = [UIColor secondaryLabelColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *item = self.menuItems[indexPath.row];
    NSString *controllerName = item[@"controller"];
    
    if ([controllerName isEqualToString:@"MasonryViewController"]) {
        MasonryViewController *vc = [[MasonryViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([controllerName isEqualToString:@"UIScrollViewController"]) {
        UIScrollViewController *vc = [[UIScrollViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([controllerName isEqualToString:@"TableViewViewController"]) {
        TableViewViewController *vc = [[TableViewViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([controllerName isEqualToString:@"WaterFallDemoViewController"]) {
        WaterFallDemoViewController *vc = [[WaterFallDemoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
