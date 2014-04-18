//
//  FeedItemsViewController.m
//  Appcatlan
//
//  Created by LADEMO on 1/30/14.
//  Copyright (c) 2014 LADEMO. All rights reserved.
//

#import "FeedItemsViewController.h"
#import "FESAcatlanRSSHelper.h"
#import "FESAcatlanRSSItem.h"
#import "RSSTableViewCell.h"

@interface FeedItemsViewController ()

@property (nonatomic, strong) NSArray *rssItems;

@end

@implementation FeedItemsViewController{
    
    FESAcatlanRSSHelper *fesAcatlanRSSHelper;
    
     __block NSMutableDictionary *thumbnails;
    
}


- (void)viewDidLoad{
    
    [super viewDidLoad];

    thumbnails = [NSMutableDictionary dictionary];
   
    fesAcatlanRSSHelper = [[FESAcatlanRSSHelper alloc] init];

    [fesAcatlanRSSHelper getFESAcatlanRSSWithCompletionBlock:^(BOOL success, NSArray *rss) {
        
        NSLog(@"Finished Downloading");
        
        self.rssItems = [NSArray arrayWithArray:rss];
        
        [self.tableView reloadData];
        
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.rssItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"RSSCell";
    
    RSSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    FESAcatlanRSSItem *rssItemAtIndex = [self.rssItems objectAtIndex:indexPath.row];
    
    cell.title.text = rssItemAtIndex.title;
    
    NSString *thumbnailKey = [NSString stringWithFormat:@"%d",indexPath.row];
    
    if ([thumbnails objectForKey:thumbnailKey]) {
        
        cell.thumbnail.image = thumbnails[thumbnailKey];
        
    }else{
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSURL *thumbnailURL = [NSURL URLWithString:[rssItemAtIndex.thumbnailsURLs lastObject]];
            
            __block NSData *thumbnailData;
            
            dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                thumbnailData = [NSData dataWithContentsOfURL:thumbnailURL];
                
                [thumbnails setObject:[UIImage imageWithData:thumbnailData] forKey:thumbnailKey];
                
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    cell.thumbnail.image = thumbnails[thumbnailKey];
                    
                });
            });
            
        });
    }
    
    

    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
