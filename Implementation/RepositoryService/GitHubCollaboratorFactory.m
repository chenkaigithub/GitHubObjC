//
//  GitHubCollaboratorFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubCollaboratorFactory.h"
#import "GitHubServiceGotNameDelegate.h"
#import "GitHubServiceDelegate.h"

@implementation GitHubCollaboratorFactory

-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName {
  
  if ([elementName isEqualToString:@"collaborator"]) {
    
    [(id<GitHubServiceGotNameDelegate>)self.delegate
     gitHubService:self
     gotName:self.currentStringValue];
    
  } else if ([elementName isEqualToString:@"error"]) {
    
    [self.parser abortParsing];
  }
  self.currentStringValue = nil;
}

-(void)requestCollaboratorsByName:(NSString *)name
                             user:(NSString *)user {
  
  [self makeRequest:
   [NSString stringWithFormat:@"%@/api/v2/xml/repos/show/%@/%@/collaborators",
    [GitHubBaseFactory serverAddress], user, name]];
}

+(GitHubCollaboratorFactory *)collaboratorFactoryWithDelegate:
(id<GitHubServiceGotNameDelegate>)delegate {
  
  return [[[GitHubCollaboratorFactory alloc]
           initWithDelegate:delegate] autorelease]; 
}

@end
