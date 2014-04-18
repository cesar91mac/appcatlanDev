//
//  FESAcatlanRSSItem.h
//  Appcatlan
//
//  Created by César Flores on 4/17/14.
//  Copyright (c) 2014 LADEMO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FESAcatlanRSSItem : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *description;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *link;

@property (nonatomic, strong) NSString *pubDate;

@property (nonatomic, strong) NSArray *thumbnailsURLs;

-(instancetype)initWithTitle:(NSString *)title Description:(NSString *)description Content:(NSString *)content Link:(NSString *)link PubDate:(NSString *)pubDate AndThumbnailsURLs:(NSArray*)thumbnailsURLs;


@end
