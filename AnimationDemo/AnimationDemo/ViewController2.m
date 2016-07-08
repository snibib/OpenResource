//
//  ViewController2.m
//  AnimationDemo
//
//  Created by 杨涵 on 16/1/4.
//  Copyright © 2016年 yanghan. All rights reserved.
//

#import "ViewController2.h"
#import "UIScrollView+DMRefresh.h"
#import "DMRefreshDefaultHeader.h"
#import "DMRefreshDefaultFooter.h"

#import "StoreObject.h"

typedef void(^myBlock)();

@interface ViewController2 ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *table;
    NSInteger testCnt;//用于测试普通block捕获全局变量的问题,总结：自身block使用自身的全局变量会导致循环引用
}

@property(nonatomic, assign)    NSInteger       count;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor greenColor];
    
    self.count = 15;
    
    __block NSInteger cnt = 10;
//    self.block = ^() {
//        cnt = 20;
//    };
    self.block();
    
    for (NSDictionary *dic in self.blocks) {
        void (^block)() = [dic objectForKey:@"block"];
        block();
    }
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.clipsToBounds = YES;
    [self.view addSubview:table];
    
    table.tableFooterView = [[UIView alloc] init];
    
    __weak typeof(table) welkTable = table;
    __weak typeof(self) weakSelf = self;
   
    DMRefreshDefaultHeader *header = [table addDefaultHeaderWithRefreshingBlock:^{
        weakSelf.count = 15;
        weakSelf.titleStr = @"33";
        welkTable.footer.state = DMRefreshFooterStateIdle;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC*0.5)), dispatch_get_main_queue(), ^{
            [welkTable.header endRefresing];
            [welkTable reloadData];
            
            if (weakSelf.block) {
                weakSelf.block();
            }
        });
    }];
    UIImage *image3 = [UIImage imageNamed:@"add_ico"];
    UIImage *image4 = [UIImage imageNamed:@"add_select"];
    header.refreshingImages = @[image4,image3];
    header.stateHidden = YES;
    header.updatedTimeHidden = YES;

    DMRefreshDefaultFooter *footer = [table addDefaultFooterWithRefreshingBlock:^{
        weakSelf.count += 15;
        if (weakSelf.count > 45) {
            weakSelf.count = 45;
            welkTable.footer.state = DMRefreshFooterStateNoMoreData;
            return;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC*0.01)), dispatch_get_main_queue(), ^{
            [welkTable.footer endRefresing];
            [welkTable reloadData];
        });
        
    }];
    UIImage *image1 = [UIImage imageNamed:@"add_ico"];
    UIImage *image2 = [UIImage imageNamed:@"add_select"];
    footer.refreshingImages = @[image1,image2];
    footer.stateHidden = YES;
    
    StoreObject *object = [[StoreObject alloc] init];
    object.number = 123;
    object.name = @"michael";
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:object] forKey:@"storeobject"];
    StoreObject *old = (StoreObject *)[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"storeobject"]];
    NSLog(@"storeObject:%@",old);
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"# row:%ld",(long)indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"size:%@",NSStringFromCGSize(scrollView.contentSize));
//    NSLog(@"offset:%@",NSStringFromCGPoint(scrollView.contentOffset));
//    NSLog(@">>>>>>>>>>>>>>>>>>>>>");
//    NSLog(@"top_offsetY:%f",-scrollView.contentInset.top);
//    NSLog(@"bottom_offsetY:%f",scrollView.contentSize.height+scrollView.contentInset.bottom-scrollView.frame.size.height);
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
