//
//  GitHubWatcherFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubWatcherFactory.h"
#import "GitHubServiceGotNameDelegate.h"
#import "GitHubServiceDelegate.h"

@implementation GitHubWatcherFactory

-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName {
  
  if ([elementName isEqualToString:@"watcher"]) {
    
    [(id<GitHubServiceGotNameDelegate>)self.delegate
     gitHubService:self
     gotName:self.currentStringValue];
    
  } else if ([elementName isEqualToString:@"error"]) {
    
    [self.parser abortParsing];
  }
  self.currentStringValue = nil;
}

-(void)requestWatchersByName:(NSString *)name
                        user:(NSString *)user {
  
  [self makeRequest:
   [NSString stringWithFormat:@"%@/api/v2/xml/repos/show/%@/%@/watchers",
    [GitHubBaseFactory serverAddress], user, name]];
}

+(GitHubWatcherFactory *)watcherFactoryWithDelegate:
(id<GitHubServiceGotNameDelegate>)delegate {
  
  return [[[GitHubWatcherFactory alloc] initWithDelegate:delegate] autorelease];   
}

-(void)dealloc {
  
  self.currentStringValue = nil;
  [super dealloc];
}

@end
