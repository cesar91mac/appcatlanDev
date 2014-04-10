//
//  FESAcatlanRSSHelper.m
//  Appcatlan
//
//  Created by César Flores on 4/10/14.
//  Copyright (c) 2014 LADEMO. All rights reserved.
//

#import "FESAcatlanRSSHelper.h"
#import "GDataXMLNode.h"

@implementation FESAcatlanRSSHelper

+(void)getFESAcatlanRSS{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *xmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.acatlan.unam.mx/json"]];
        
        NSError *error;
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
        
        NSArray *channels = [doc.rootElement elementsForName:@"channel"];
        
        NSLog(@"Channels %d",channels.count);
        
        
        for (GDataXMLElement *channel in channels) {
            
            NSArray *items = [channel elementsForName:@"item"];
            
            for (GDataXMLElement *item in items) {
                
                GDataXMLElement *title = [[item elementsForName:@"title"] lastObject];
                
                GDataXMLElement *description = [[item elementsForName:@"description"] lastObject];
                
                GDataXMLElement *contentEncoded = [[item elementsForName:@"content:encoded"] lastObject];
                
                GDataXMLElement *link = [[item elementsForName:@"link"] lastObject];
                
                GDataXMLElement *pubDate = [[item elementsForName:@"pubDate"] lastObject];
                
                NSLog(@"%@\n%@\n%@\n%@\n%@\n",title.stringValue,description.stringValue,contentEncoded.stringValue,link.stringValue,pubDate.stringValue);
                
            }
            
            
        }
        
    });

}
@end
