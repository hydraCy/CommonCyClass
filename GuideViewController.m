//
//  GuideViewController.m
//
//
//  Created by cy on 17/6/14.
//  Copyright © 2017年 cy. All rights reserved.
//

#import "GuideViewController.h"
#import "FLLoginController.h"

#define WIDTH (NSInteger)self.view.bounds.size.width
#define HEIGHT (NSInteger)self.view.bounds.size.height

@interface GuideViewController ()<UIScrollViewDelegate>
{
    // 创建页码控制器
    UIPageControl *pageControl;
    // 判断是否是第一次进入应用
    BOOL flag;
    
    int pageNumber;
}
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //控制图片数量
    pageNumber = 3;
    
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    for (int i=0; i<pageNumber; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"guide3.4%d.png",i]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, HEIGHT)];
        // 在最后一页创建按钮
        if (i == (pageNumber-1)) {
            // 必须设置用户交互 否则按键无法操作
            imageView.userInteractionEnabled = YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(0, 0, 110*ScaleWidth, 35*ScaleHeight);
            button.center = CGPointMake(self.view.center.x, 550*ScaleHeight);
            button.layer.borderColor = getColor(@"f51c5e").CGColor;
            button.layer.borderWidth = 0.5;
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 5;
            [button setTitle:@"立即体验" forState:UIControlStateNormal];
            [button setTitleColor:getColor(@"f51c5e") forState:UIControlStateNormal];
            [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
        imageView.image = image;
        [myScrollView addSubview:imageView];
    }
    myScrollView.bounces = NO;
    myScrollView.pagingEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(WIDTH * pageNumber, HEIGHT);
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
//    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(WIDTH / 3, HEIGHT * 15 / 16, WIDTH / 3, HEIGHT / 16)];
    // 设置页数
    pageControl.numberOfPages = pageNumber;
    // 设置页码的点的颜色
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    // 设置当前页码的点颜色
    pageControl.currentPageIndicatorTintColor = getColor(@"00c2c4");
    
    [self.view addSubview:pageControl];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 计算当前在第几页
    pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
}

// 点击按钮保存数据并切换根视图控制器
- (void) go:(UIButton *)sender{
    flag = YES;
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    // 保存用户数据
    [useDef setBool:flag forKey:@"notFirst"];
    [useDef synchronize];
    // 切换根视图控制器
    FLLoginController *vc = [[FLLoginController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    //    [UINavigationBar appearance].barTintColor=[UIColor grayColor];
    self.view.window.rootViewController = nav;
}
@end
