//
//  FESAcatlanRSSItem.m
//  Appcatlan
//
//  Created by César Flores on 4/17/14.
//  Copyright (c) 2014 LADEMO. All rights reserved.
//

#import "FESAcatlanRSSItem.h"

@implementation FESAcatlanRSSItem

-(instancetype)initWithTitle:(NSString *)title Description:(NSString *)description Content:(NSString *)content Link:(NSString *)link PubDate:(NSString *)pubDate AndThumbnailsURLs:(NSArray*)thumbnailsURLs{
    
    if (self = [super init]) {
        
        _title = title;
        
        _description = description;
        
        _content = content;
        
        _link = link;
        
        _pubDate = pubDate;
        
        _thumbnailsURLs = thumbnailsURLs;
        
        return self;
    }
    
    return nil;
}

@end
