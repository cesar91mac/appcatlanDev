//
//  TwitterHelper.m
//  Appcatlan
//
//  Created by César Flores on 2/27/14.
//  Copyright (c) 2014 LADEMO. All rights reserved.
//

#import "TwitterHelper.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface TwitterHelper ()

@property (nonatomic) ACAccountStore *accountStore;

@property (nonatomic, strong) ACAccount *fesAcatlanAccount;

@end

@implementation TwitterHelper


- (id)init{
    
    self = [super init];
   
    if (self) {
        _accountStore = [[ACAccountStore alloc] init];
        
    }
    
    return self;
}

- (BOOL)userHasAccessToTwitter{
    
    return [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
}

- (void)fetchTimelineForUser:(NSString *)username{
    
    
    //  Step 0: Check that the user has local Twitter accounts
    //if ([self userHasAccessToTwitter]) {
        
        //  Step 1:  Obtain access to the user's Twitter accounts
        //ACAccountType *twitterAccountType = [self.accountStore accountTypeWithAccountTypeIdentifier: ACAccountTypeIdentifierTwitter];
    
        ACAccountType *twitterAccountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
        ACAccountCredential *fesAcatlanCredential = [[ACAccountCredential alloc] initWithOAuthToken:@"csrmc91" tokenSecret:@"r15-_91cs"];
    
        self.fesAcatlanAccount = [[ACAccount alloc] initWithAccountType:twitterAccountType];
    
        [self.fesAcatlanAccount setCredential:fesAcatlanCredential];
    
        [self.fesAcatlanAccount setUsername:@"csrmc91"];
    
        [self.accountStore saveAccount:self.fesAcatlanAccount withCompletionHandler:^(BOOL success, NSError *error) {
        
        NSLog(@"user registerd properly %@",self.fesAcatlanAccount.credential.oauthToken);
            
            [self.accountStore requestAccessToAccountsWithType:twitterAccountType options:NULL completion:^(BOOL granted, NSError *error) {
            
                    
                    //  Step 2:  Create a request
                    NSArray *twitterAccounts = [self.accountStore accountsWithAccountType:twitterAccountType];
                    
                    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com@/1.1/statuses/user_timeline.json"];
                    
                    NSDictionary *params = @{@"screen_name" : username,
                                             @"include_rts" : @"0",
                                             @"trim_user" : @"1",
                                             @"count" : @"10"};
                    
                    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:url parameters:params];
                    
                    //  Attach an account to the request
                
                if ([twitterAccounts lastObject]) {
                    
                    [request setAccount:[twitterAccounts lastObject]];
                    
                }else{
                    
                    NSLog(@"no existe");
                }
                
                
                    
                    
                    //[request setAccount:self.fesAcatlanAccount];
                    
                    //  Step 3:  Execute the request
                    [request performRequestWithHandler: ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                        
                        if (responseData) {
                            
                            if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
                                
                                NSError *jsonError;
                                
                                NSArray *timelineData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&jsonError];
                                
                                if (timelineData) {
                                    
                                    NSLog(@"Timeline Response: %@\n", timelineData);
                                    
                                }else {
                                    
                                    // Our JSON deserialization went awry
                                    NSLog(@"JSON Error: %@", [jsonError localizedDescription]);
                                    
                                }
                                
                            }else {
                                
                                // The server did not respond ... were we rate-limited?
                                NSLog(@"The response status code is %d", urlResponse.statusCode);
                                
                            }
                        }else{
                            
                            NSLog(@"No response");
                            
                        }
                    }];

            }];

         }];
    //}
}
@end
