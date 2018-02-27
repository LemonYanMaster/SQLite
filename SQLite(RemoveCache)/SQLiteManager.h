//
//  SQLiteManager.h
//  SQLite(RemoveCache)
//
//  Created by pengpeng yan on 16/2/16.
//  Copyright © 2016年 peng yan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Steps;

@interface SQLiteManager : NSObject

+ (instancetype)shareSQLiteManager;

- (void)saveData:(Steps *)step;

- (NSArray *)readFormSql;

@end
