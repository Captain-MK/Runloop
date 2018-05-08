//
//  ProgressConfig.h
//  RLDemo
//
//  Created by MK on 2018/5/7.
//  Copyright © 2018年 MK. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ConfigModel;
typedef ConfigModel *(^configToString)(NSString *str);
typedef ConfigModel *(^ShowConfig)(void);
typedef ConfigModel *(^ShowConfig)(void);
@interface ConfigModel : NSObject
@property (nonatomic , copy , readonly ) configToString Title;
@property (nonatomic , copy , readonly ) configToString Content;
@property (nonatomic , copy , readonly ) ShowConfig show;
@end

@interface ProgressConfig : NSObject
@property (nonatomic , strong ) ConfigModel *config;
@end
