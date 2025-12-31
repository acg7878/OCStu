//
//  MeViewController.m
//  OCStu
//
//  Created by Derek on 2025/12/30.
//

#import "MeViewController.h"
#import <Masonry/Masonry.h>

@interface MeViewController ()

@property (nonatomic, strong) UIImageView *avatarImageView;  // 头像
@property (nonatomic, strong) UILabel *nameLabel;            // 名字
@property (nonatomic, strong) UIView *actionButtonsView;     // 操作按钮容器
@property (nonatomic, strong) UIScrollView *scrollView;      // 滚动视图

@end

@implementation MeViewController

// 视图加载调用
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.85 green:0.82 blue:0.78 alpha:1.0];
    self.title = @"我";
    [self setupUI];
}

- (void)setupUI {
    
    [self setAvatarImageView];
    [self setNameLabel];
    
    // 操作按钮容器
    self.actionButtonsView = [[UIView alloc] init];
    [self.view addSubview:self.actionButtonsView];
    
    [self.actionButtonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(320);
    }];
    
    [self setupActionButtons];
    
    // 滚动视图（电话号码列表）
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.actionButtonsView.mas_bottom).offset(30);
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 20, 0, 20));
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-20);
    }];
    
    [self setupPhoneList];
}

- (void)setAvatarImageView {
    // 头像
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    self.avatarImageView.layer.cornerRadius = 100; // 圆形
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.image = [UIImage systemImageNamed:@"person.crop.circle.fill"];
    self.avatarImageView.tintColor = [UIColor whiteColor];
    [self.view addSubview:self.avatarImageView];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(40);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
}


- (void)setNameLabel {
    // 名字标签
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"咔咔咔";
    self.nameLabel.font = [UIFont boldSystemFontOfSize:32];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 20, 0, 20));
    }];
}


// 设置操作按钮（消息/电话/视频/邮件）
- (void)setupActionButtons {
    NSArray *icons = @[@"message.fill", @"phone.fill", @"video.fill", @"envelope.fill"];
    NSInteger count = icons.count;
    CGFloat buttonSize = 60;
    CGFloat spacing = (320 - buttonSize * count) / (count + 1);
    
    for (NSInteger i = 0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        btn.layer.cornerRadius = buttonSize / 2;
        btn.tintColor = [UIColor whiteColor];
        
        UIImage *icon = [UIImage systemImageNamed:icons[i]];
        [btn setImage:icon forState:UIControlStateNormal];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.actionButtonsView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.actionButtonsView);
            make.left.equalTo(self.actionButtonsView).offset(spacing + i * (buttonSize + spacing));
            make.size.mas_equalTo(CGSizeMake(buttonSize, buttonSize));
        }];
    }
}

// 设置电话号码列表
- (void)setupPhoneList {
    NSArray *phones = @[@"+86 175 7684 1926", @"+86 136 7608 6610", @"+86 153 1374 6652"];
    UIView *lastView = nil;
    
    for (NSString *phone in phones) {
        UIView *phoneCard = [self createPhoneCardWithNumber:phone];
        [self.scrollView addSubview:phoneCard];
        
        [phoneCard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.scrollView);
            make.width.equalTo(self.scrollView);
            make.height.mas_equalTo(80);
            
            if (lastView) {
                make.top.equalTo(lastView.mas_bottom).offset(10);
            } else {
                make.top.equalTo(self.scrollView);
            }
        }];
        
        lastView = phoneCard;
    }
    
    // 设置滚动视图内容大小
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.scrollView);
    }];
}

// 创建电话号码卡片
- (UIView *)createPhoneCardWithNumber:(NSString *)phone {
    UIView *card = [[UIView alloc] init];
    card.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.5];
    card.layer.cornerRadius = 12;
    
    UILabel *typeLabel = [[UILabel alloc] init];
    typeLabel.text = @"iPhone";
    typeLabel.font = [UIFont systemFontOfSize:16];
    typeLabel.textColor = [UIColor whiteColor];
    [card addSubview:typeLabel];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = phone;
    phoneLabel.font = [UIFont systemFontOfSize:18];
    phoneLabel.textColor = [UIColor whiteColor];
    [card addSubview:phoneLabel];
    
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(card).offset(15);
        make.left.equalTo(card).offset(20);
    }];
    
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typeLabel.mas_bottom).offset(5);
        make.left.equalTo(card).offset(20);
    }];
    
    return card;
}

@end
