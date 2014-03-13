//
//  FeedSourcesViewController.m
//  Appcatlan
//
//  Created by LADEMO on 1/30/14.
//  Copyright (c) 2014 LADEMO. All rights reserved.
//

#import "FeedSourcesViewController.h"
#import "TwitterHelper.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface FeedSourcesViewController ()

@property (nonatomic, strong) NSArray *sources;

@end





@implementation FeedSourcesViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"euqpeurpqo");
    
    self.sources = @[@[@"Acatlán Oficial",@"Facebook",@"Twitter",@"Instagram",@"Youtube"],@[@"Noticias",@"Avisos",@"Deportes",@"Difusión Cultural"]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        //NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.acatlan.unam.mx/JSON"]];
        
       /* NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://sulisu.co/rss/"]];
        
        NSLog(@"%@",data);
        
        NSError *error;
        
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        
        NSLog(@"%@",jsonData);*/
    });
    

 /*   NSURL *url = [[NSURL alloc] initWithString:@"http://sulisu.co/rss/"];
 
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            
        } else {
            
            NSError *error;
            
            NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            NSLog(@"%@",parsedObject);
        }
    }];*/
    
    
    TwitterHelper *twitterHelper = [[TwitterHelper alloc] init];
    
    [twitterHelper fetchTimelineForUser:@"csrmc91"];
    

}


- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.sources.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *sectionSources = [self.sources objectAtIndex:section];
    
    return sectionSources.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"FeedSourceCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = [[self.sources objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.textColor = UIColorFromRGB(0x0A214F);
                break;
            case 1:
                cell.textLabel.textColor = UIColorFromRGB(0x3B5998);
                break;;
            case 2:
                cell.textLabel.textColor = UIColorFromRGB(0x00ACED);
                break;
            case 3:
                cell.textLabel.textColor = UIColorFromRGB(0x517FA4);
                break;
            case 4:
                cell.textLabel.textColor = UIColorFromRGB(0xBB0000);
            default:
                break;
        }
    }else{
        
        switch (indexPath.row) {
        case 0:
            cell.textLabel.textColor = UIColorFromRGB(0x3B5998);
            break;
        case 1:
            cell.textLabel.textColor = UIColorFromRGB(0x3B5998);
            break;;
        case 2:
            cell.textLabel.textColor = UIColorFromRGB(0x3B5998);
            break;
        case 3:
            cell.textLabel.textColor = UIColorFromRGB(0x3B5998);
            break;
        default:
            break;
        }

    }
    
    
    return cell;
    
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return @"Fuentes";
    }
    
    return @"Categorías";
}



#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
