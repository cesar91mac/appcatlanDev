//
//  FESAcatlanRSSHelper.h
//  Appcatlan
//
//  Created by César Flores on 4/10/14.
//  Copyright (c) 2014 LADEMO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FESAcatlanRSSHelper : NSObject




-(void)getFESAcatlanRSSWithCompletionBlock:(void (^)(BOOL success, NSArray *rss))completionBlock;

@end
