//
//  GitHubFollowersFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubFollowerFactory.h"

@implementation GitHubFollowerFactory

#pragma mark -
#pragma mark Delegate protocol implementation
#pragma mark - NSXMLParserDelegate

-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName {
  
  if ([elementName isEqualToString:@"user"]) {
    
    [(id<GitHubServiceGotNameDelegate>)self.delegate
     gitHubService:self
     gotName:self.currentStringValue];
    
  } else if ([elementName isEqualToString:@"error"]) {
    
    [self handleErrorWithCode:GitHubServerServerError];
  }
  self.currentStringValue = nil;
}

#pragma mark -
#pragma mark Interface implementation
#pragma mark - Class

+(GitHubFollowerFactory *)followerFactoryWithDelegate:
(id<GitHubServiceGotNameDelegate>)delegate {
  
  return [[[GitHubFollowerFactory alloc]
           initWithDelegate:delegate] autorelease]; 
}

#pragma mark - Instance

-(void)requestFollowersOfUser:(NSString *)name {
  
  [self makeRequest:[NSString 
                    stringWithFormat:@"%@/api/v2/xml/user/show/%@/followers",
                     [GitHubBaseFactory serverAddress], name]];
}

@end
