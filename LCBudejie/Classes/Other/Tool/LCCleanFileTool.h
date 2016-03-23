//
//  LCCleanFileTool.h
//  LCBudejie
//
//  Created by admin on 16/3/14.
//  Copyright © 2014年 LC. All rights reserved.
//  处理文件缓存

#import <Foundation/Foundation.h>


/*
 业务类:以后开发中用来专门处理某件事情,网络处理,缓存处理
 */


@interface LCCleanFileTool : NSObject
/**
 *  移除缓存文件
 *
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

/**
 *  获取文件夹下文件大小
 *
 */
+ (void)getFileSizeWithFileName:(NSString *)directoryPath completion:(void(^)( NSInteger totalSize))completion;

@end
