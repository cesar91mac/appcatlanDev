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
        
        int i = 0;
        
        for (GDataXMLElement *channel in channels) {
            
            NSArray *items = [channel elementsForName:@"item"];
            
            for (GDataXMLElement *item in items) {
                
              
                if (i == 0) {
                    
//                    GDataXMLElement *title = [[item elementsForName:@"title"] lastObject];
//                    
//                    GDataXMLElement *description = [[item elementsForName:@"description"] lastObject];
                    
                    GDataXMLElement *contentEncoded = [[item elementsForName:@"content:encoded"] lastObject];
                    
                    NSLog(@"%@",contentEncoded.stringValue);
                    
//                    GDataXMLElement *link = [[item elementsForName:@"link"] lastObject];
//                    
//                    GDataXMLElement *pubDate = [[item elementsForName:@"pubDate"] lastObject];
                    
                    
                    
                    
                    
//                    NSString *pXpathQueryString = @"//Player";
//                
//                    
//                    
                    NSError *error = nil;
                
                    
                    GDataXMLElement *element = [[GDataXMLElement alloc] initWithXMLString:@"<p style=\"text-align:center;\"><img src=\"http://www.acatlan.unam.mx/imagenes/3244.jpg\" alt=\"\" width=\"300\" height=\"136\" />hola</p>" error:&error];
                    
                    if (error) {
                        
                        NSLog(@"Couldn`t create element");
                    }
                    
                    NSLog(@"%@",element.stringValue);
                    
//                    NSArray *pObjects = [element nodesForXPath:pXpathQueryString error:nil];
//                    
//                    NSLog(@"%@",pObjects);

                    
                }
                
                i++;
                //NSLog(@"%@\n%@\n%@\n%@\n%@\n",title.stringValue,description.stringValue,contentEncoded.stringValue,link.stringValue,pubDate.stringValue);
                
            }
            
            
        }
        
    });

}
@end
