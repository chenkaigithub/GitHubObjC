//
//  GitHubUserSearchFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubUserSearchFactory.h"
#import "GitHubServiceGotNameDelegate.h"
#import "GitHubServiceDelegate.h"

@implementation GitHubUserSearchFactory

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
   attributes:(NSDictionary *)attributeDict {
  
  self.currentStringValue = [NSMutableString stringWithCapacity:100];
}

-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName {
  
  if ([elementName isEqualToString:@"name"]) {
    
    [(id<GitHubServiceGotNameDelegate>)self.delegate
     gitHubService:self
     gotName:self.currentStringValue];
    
  } else if ([elementName isEqualToString:@"error"]) {
    
    [self.parser abortParsing];
  }
  
  self.currentStringValue = nil;
}

-(void)searchUsersByName:(NSString *)name {
  
  [self makeRequest:[NSString
                     stringWithFormat:@"%@/api/v2/xml/user/search/%@",
                     [GitHubBaseFactory serverAddress], name]];
}

+(GitHubUserSearchFactory *)userSearchFactoryWithDelegate:
(id<GitHubServiceGotNameDelegate>)delegate {
  
  return [[[GitHubUserSearchFactory alloc]
           initWithDelegate:delegate] autorelease]; 
}

-(void)dealloc {
  
  self.currentStringValue = nil;
  [super dealloc];
}

@end
