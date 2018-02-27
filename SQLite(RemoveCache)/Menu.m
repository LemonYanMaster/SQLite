//
//  Menu.m
//  SQLite(RemoveCache)
//
//  Created by pengpeng yan on 16/2/16.
//  Copyright © 2016年 peng yan. All rights reserved.
//

#import "Menu.h"
#import "SQLiteManager.h"

@implementation Menu

- (NSMutableArray *)steps{
    if (!_steps) {
        _steps = [NSMutableArray array];
    }
    return _steps;
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.menuID = dict[@"id"];
        self.title = dict[@"title"];
        self.tags = dict[@"tags"];
        self.ingredients = dict[@"ingredients"];
        self.imtro = dict[@"imtro"];
        self.burden = dict[@"burden"];
        self.albums = dict[@"albums"];
        NSArray *stepsArray = dict[@"steps"];
        for (NSDictionary *dic in stepsArray) {
            Steps *step = [[Steps alloc] initWithDict:dic];
            //存储数据到数据库
            [[SQLiteManager shareSQLiteManager] saveData:step];
            
            [self.steps addObject:step];
        }
    }

    return self;
}

@end

@implementation Steps

-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.img = dict[@"img"];
        self.step = dict[@"step"];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.img forKey:@"img"];
    [aCoder encodeObject:self.step forKey:@"step"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.img = [aDecoder decodeObjectForKey:@"img"];
        self.step = [aDecoder decodeObjectForKey:@"step"];
    }
    return self;
}





@end