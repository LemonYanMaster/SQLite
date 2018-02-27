//
//  MenuTableViewController.m
//  SQLite(RemoveCache)
//
//  Created by pengpeng yan on 16/2/16.
//  Copyright © 2016年 peng yan. All rights reserved.
//

#import "MenuTableViewController.h"
#import "Menu.h"
#import "MenuCell.h"
#import "AFNetworking.h"
#import "SQLiteManager.h"
#import "UIImageView+WebCache.h"

@interface MenuTableViewController ()<UIAlertViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MenuTableViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"瞅瞅吧";
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"清理" style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonAction:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.tableView.rowHeight = 180;
    
    //加载数据
    [self getData];
}
#pragma mark - rightButtonAction清除点击
- (void)rightButtonAction:(UIBarButtonItem *)rightButton{
   //使用SDImageCache获取缓存文件大小
     //字节大小
     int byteSize = (int)[[SDImageCache sharedImageCache] getSize];
    CGFloat cacheSize = byteSize / 1000.0 / 1000.0;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清理缓存" message:[NSString stringWithFormat:@"缓存大小%.1fM",cacheSize] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //清理
        [[SDImageCache sharedImageCache] clearDisk];
    }
}

#pragma mark - getData 加载数据
- (void)getData{
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] init];
    
    NSURL *url = @"http://apis.juhe.cn/cook/queryid";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = self.menuID;
    params[@"key"] = self.appKey;
    params[@"dtype"] = self.dtype;
    
    //从数据看获取信息，有则加载数据库的信息
    NSArray *array = [[SQLiteManager shareSQLiteManager] readFormSql];
    if (array.count) {
        self.dataArray = [NSMutableArray arrayWithArray:array];
    }else{
        //否则从服务器加载数据
        [sessionManager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *result = responseObject[@"result"];
            NSArray *data = result[@"data"];
            for (NSDictionary *dic in data) {
                Menu *menu = [[Menu alloc] initWithDict:dic];
                _dataArray  = menu.steps;
            }
            [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"----%@",error);
        }];
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    Steps *step =(Steps *)self.dataArray[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:step.img] placeholderImage:nil];
    cell.stepLabel.text = step.step;
    
    return cell;
}






@end
