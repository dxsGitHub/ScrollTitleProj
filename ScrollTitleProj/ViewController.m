//
//  ViewController.m
//  ScrollTitleProj
//
//  Created by dxs on 2017/6/30.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import "ViewController.h"

#import "TitleContentView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *tipLab;
@property (nonatomic, strong) TitleContentView *titleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _titleView = [[TitleContentView alloc] init];
    NSArray *array = @[@"NBA", @"CBA", @"体育", @"新闻", @"头条", @"数码", @"手机"];
    [_titleView titleContentViewWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 45) contentView:self.view sourceArray:array];
    __block UILabel *lab = _tipLab;
    _titleView.selectItemBlock = ^(NSInteger index) {
        lab.text = [NSString stringWithFormat:@"提示：你选中了%@", array[index]];
    };
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_titleView didSelectNextItem];
//    [_titleView didSelectPrefixItem];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
