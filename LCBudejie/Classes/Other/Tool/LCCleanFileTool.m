//
//  LCCleanFileTool.m
//  LCBudejie
//
//  Created by admin on 16/3/14.
//  Copyright © 2014年 LC. All rights reserved.
//

#import "LCCleanFileTool.h"

@implementation LCCleanFileTool


+ (void)removeDirectoryPath:(NSString *)directoryPath
{
    NSFileManager *magr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [magr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory)
    {
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"需要传入文件夹路径,并且路径要存在" userInfo:nil];
        [excp raise];
    }
    NSArray *subPaths = [magr subpathsOfDirectoryAtPath:directoryPath error:nil];
    for (NSString *subPath in subPaths)
    {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        [magr removeItemAtPath:filePath error:nil];
    }
}
/**
 *  获得文件大小
 *
 */
+ (void)getFileSizeWithFileName:(NSString *)directoryPath completion:(void(^)( NSInteger totalSize))completion
{
   //1. 获得文件中所有的子文件
    
    NSFileManager *magr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [magr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory)
    {
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"需要传入文件夹路径,并且路径要存在" userInfo:nil];
        [excp raise];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSArray *subPaths = [magr subpathsOfDirectoryAtPath:directoryPath error:nil];
        NSInteger totalSize = 0;
        //2.遍历所有子文件,算出其大小
        for (NSString *subPath in subPaths)
        {
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            if ([filePath containsString:@".DS"]) continue;
            
            BOOL isDirectory;
            BOOL isExist = [magr fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExist || isDirectory) continue;
            //  获取每个文件大小
            NSInteger fileSize = [[magr attributesOfItemAtPath:filePath error:nil] fileSize];
            totalSize += fileSize;
        }
 
    //3. 累加, 返回
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if (completion)
            {
                completion(totalSize);
            }
        });
        
    });
}
@end
