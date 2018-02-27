//
//  SQLiteManager.m
//  SQLite(RemoveCache)
//
//  Created by pengpeng yan on 16/2/16.
//  Copyright © 2016年 peng yan. All rights reserved.
//

#import "SQLiteManager.h"
#import "FMDB.h"
#import "Menu.h"

@interface SQLiteManager ()

@property(nonatomic,strong)FMDatabase *dataBase;

@end

@implementation SQLiteManager

+ (instancetype)shareSQLiteManager{
    static SQLiteManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SQLiteManager alloc] init];
    });
    return manager;

}


- (instancetype)init{
    self = [super init];
    if (self) {
        //拼接文件路径
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *pathString = [path stringByAppendingPathComponent:@"data.sqlite"];
        //初始化数据库
        self.dataBase = [FMDatabase databaseWithPath:pathString];
        //打开数据库
        [self.dataBase open];
        
        if ([self.dataBase open]) {
            //建表
          //  NSString *create = @"CREATE TABLE IF NOT EXISTS t_step(id integer PRIMARY KEY,step blob NOT NULL);";
            [self.dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_step(id integer PRIMARY KEY,step blob NOT NULL);"];
        }
    }
    return self;
}

#pragma mark - 从数据库读取数据 解档
- (NSArray *)readFormSql{
    
    FMResultSet *result = [self.dataBase executeQuery:@"SELECT * FROM t_step"];
    NSMutableArray *array = [NSMutableArray array];
    while (result.next) {
        NSData *data = [result objectForColumnName:@"step"];
        Steps *step = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [array addObject:step];
    }
    return array;
}


#pragma mark - 保存数据到数据库 归档
- (void)saveData:(Steps *)step{
    
    //打成二进制数据流
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:step];
    [self.dataBase executeUpdateWithFormat:@"INSERT INTO t_step(step) VALUES (%@);",data];
}









@end
