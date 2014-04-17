//
//  FeedSourcesViewController.m
//  Appcatlan
//
//  Created by LADEMO on 1/30/14.
//  Copyright (c) 2014 LADEMO. All rights reserved.
//

#import "FeedSourcesViewController.h"
#import "TwitterHelper.h"
#import "FESAcatlanRSSHelper.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface FeedSourcesViewController ()

@property (nonatomic, strong) NSArray *sources;



@end



@implementation FeedSourcesViewController{

    FESAcatlanRSSHelper *fesAcatlanRSSHelper;

}


- (void)viewDidLoad{

    [super viewDidLoad];
    
    fesAcatlanRSSHelper = [[FESAcatlanRSSHelper alloc] init];
    
    self.sources = @[@[@"Acatlán Oficial",@"Facebook",@"Twitter",@"Instagram",@"Youtube"],@[@"Noticias",@"Avisos",@"Deportes",@"Difusión Cultural"]];
    
        
    [fesAcatlanRSSHelper getFESAcatlanRSSWithCompletionBlock:^(BOOL success, NSArray *rss) {
        
        NSLog(@"Finished Downloading\n %@ ",rss);
    }];

    
//    TwitterHelper *twitterHelper = [[TwitterHelper alloc] init];
//    
//    [twitterHelper fetchTimelineForUser:@"csrmc91"];
    
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
