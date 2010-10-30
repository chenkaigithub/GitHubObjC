//
//  GitHubLabelFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/30/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubLabelFactory.h"

@implementation GitHubLabelFactory

#pragma mark -
#pragma mark Delegate protocol implementation
#pragma mark - NSXMLParserDelegate

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
  
  if ([elementName isEqualToString:@"label"]) {
    
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

+(GitHubLabelFactory *)labelFactoryWithDelegate:
(id<GitHubServiceGotNameDelegate>)delegate {

    return [[[GitHubLabelFactory alloc] initWithDelegate:delegate] autorelease];
}

#pragma mark - Instance

-(void)requestLabelsForUser:(NSString *)user
                 repository:(NSString *)repository {

  [self makeRequest:[NSString
                     stringWithFormat:
                     @"%@/api/v2/xml/issues/labels/%@/%@",
                     [GitHubBaseFactory serverAddress],
                     user, repository]];
}

@end
