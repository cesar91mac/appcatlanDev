//
//  FESAcatlanRSSHelper.m
//  Appcatlan
//
//  Created by César Flores on 4/10/14.
//  Copyright (c) 2014 LADEMO. All rights reserved.
//

#import "FESAcatlanRSSHelper.h"
#import "GDataXMLNode.h"
#import "FESAcatlanRSSItem.h"
@implementation FESAcatlanRSSHelper




-(void)getFESAcatlanRSSWithCompletionBlock:(void (^)(BOOL success, NSArray *rss))completionBlock{

   __block NSMutableArray *tempRSS = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *xmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.acatlan.unam.mx/json"]];
        
        NSError *error;
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
        
        NSArray *channels = [doc.rootElement elementsForName:@"channel"];
        

        
        for (GDataXMLElement *channel in channels) {
            
            NSArray *items = [channel elementsForName:@"item"];
            
            for (GDataXMLElement *item in items) {
                
                    
                GDataXMLElement *title = [[item elementsForName:@"title"] lastObject];
     
                GDataXMLElement *description = [[item elementsForName:@"description"] lastObject];
                    
                GDataXMLElement *contentEncoded = [[item elementsForName:@"content:encoded"] lastObject];
                    
                GDataXMLElement *link = [[item elementsForName:@"link"] lastObject];
                
                GDataXMLElement *pubDate = [[item elementsForName:@"pubDate"] lastObject];
                
                
                
                
                
                FESAcatlanRSSItem *rssItem = [[FESAcatlanRSSItem alloc] initWithTitle:title.stringValue
                                                                          Description:[self stringFromParsedHTMLInGDataXMLElement:description] Content:[self stringFromParsedHTMLInGDataXMLElement:contentEncoded] Link:link.stringValue PubDate:pubDate.stringValue];
                
//                NSDictionary *rssElement = @{@"title": title.stringValue,
//                                             @"description":[self stringFromParsedHTMLInGDataXMLElement:description],
//                                             @"content":[self stringFromParsedHTMLInGDataXMLElement:contentEncoded],
//                                             @"link":link.stringValue,
//                                             @"pubDate":pubDate.stringValue};

                
            
                [tempRSS addObject:rssItem];
                  
            }
        
            
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completionBlock(YES,tempRSS);
        
        });
        
    });

}

-(NSString *)stringFromParsedHTMLInGDataXMLElement:(GDataXMLElement*)htmlElement{
    
    NSString *structuredContent = [NSString stringWithFormat:@"<div>%@</div>",htmlElement.stringValue];
    
    NSString *noBreakPointsContent = [structuredContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSString *pXpathQueryString = @"//p";
    
    NSError *error = nil;
    
    GDataXMLDocument *docFromElement = [[GDataXMLDocument alloc] initWithXMLString:noBreakPointsContent options:0 error:&error];
    
    
    if (error) {
        
        NSLog(@"Couldn`t create element");
    }
    
    NSArray *pObjects = [docFromElement.rootElement nodesForXPath:pXpathQueryString error:nil];
    
    NSString *htmlContent = @"";
    
    for (GDataXMLElement *element in pObjects) {
        
        if (![element.stringValue isEqualToString:@""]) {
            
            htmlContent = [htmlContent stringByAppendingString:[NSString stringWithFormat:@" %@",element.stringValue]];
            
        }
        
        
    }
    
    return htmlContent;
}

@end
