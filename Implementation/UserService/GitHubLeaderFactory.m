//
//  GitHubLeaderFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubLeaderFactory.h"
#import "GitHubServiceGotNameDelegate.h"
#import "GitHubServiceDelegate.h"


@implementation GitHubLeaderFactory


-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName {
  
  if ([elementName isEqualToString:@"user"]) {
    
    [(id<GitHubServiceGotNameDelegate>)self.delegate
     gitHubService:self
     gotName:self.currentStringValue];
    
  } else if ([elementName isEqualToString:@"error"]) {
    
    [self.parser abortParsing];
  }
  self.currentStringValue = nil;
}

-(void)requestLeadersOfUser:(NSString *)name {
  
  [self makeRequest:[NSString
                     stringWithFormat:@"%@/api/v2/xml/user/show/%@/following",
                     [GitHubBaseFactory serverAddress], name]];
}

+(GitHubLeaderFactory *)leaderFactoryWithDelegate:
(id<GitHubServiceGotNameDelegate>)delegate {
  
  return [[[GitHubLeaderFactory alloc] initWithDelegate:delegate] autorelease]; 
}

-(void)dealloc {
  
  self.currentStringValue = nil;
  [super dealloc];
}

@end
