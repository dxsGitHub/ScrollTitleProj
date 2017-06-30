# ScrollTitleProj

1，导入文件,创建TitleContentView的实例对象，务必使这个实例对象为成员变量

2，传入数据，设置位置，调用：
- (void)titleContentViewWithFrame:(CGRect)frame contentView:(UIView *)view sourceArray:(NSArray *)array;

3，设置 代理 或 block，填写点击每个item的业务逻辑
- (void)itemDidClickReactionWithDictionary:(NSDictionary *)dictionary;
(或)
selectItemBlock（）；

4，如果在控制器view上点击，可以实现item的向左或向右选中，类似于网易的左右swipe手势
- (void)didSelectNextItem;
- (void)didSelectPrefixItem;
