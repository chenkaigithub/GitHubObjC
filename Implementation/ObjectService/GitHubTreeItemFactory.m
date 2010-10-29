//
//  GitHubTreeItemFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/29/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubTreeItemFactory.h"


@implementation GitHubTreeItemFactory

#pragma mark -
#pragma mark Memory and member management

//Retain
@synthesize treeItem;

-(void)cleanUp {
  
  self.treeItem = nil;
  [super cleanUp];
}

-(void)dealloc {
  
  [self cleanUp];
  [super dealloc];
}

#pragma mark -
#pragma mark Delegate protocol implementation
#pragma mark - NSXMLParserDelegate

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
   attributes:(NSDictionary *)attributeDict {
  
  if ([elementName isEqualToString:@"tree"]) {
    
    self.treeItem = [GitHubTreeItemImp treeItem];
  }
  self.currentStringValue = [NSMutableString stringWithCapacity:100];
}

-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName {
  
  if ([elementName isEqualToString:@"tree"]) {
    
    if (self.treeItem.name) {
      
      [(id<GitHubServiceGotTreeItemDelegate>)self.delegate
       gitHubService:self
       gotTreeItem:self.treeItem];
    }
  } else if ([elementName isEqualToString:@"name"]) {
    
    self.treeItem.name = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"sha"]) {
    
    self.treeItem.sha = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"mode"]) {
    
    self.treeItem.mode = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"mime-type"]) {
    
    self.treeItem.mime = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"type"]) {
    
    self.treeItem.type = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"size"]) {
    
    self.treeItem.size = [self.currentStringValue intValue];
    
  } else if ([elementName isEqualToString:@"error"]) {
    
    [self handleErrorWithCode:GitHubServerServerError];
  }
  self.currentStringValue = nil;
}

#pragma mark -
#pragma mark Interface implementation
#pragma mark - Class

+(GitHubTreeItemFactory *)treeItemFactoryWithDelegate:
(id<GitHubServiceGotTreeItemDelegate>)delegate {
  
  return [[[GitHubTreeItemFactory alloc] initWithDelegate:delegate] autorelease]; 
}

#pragma mark - Instance

-(void)requestTreeItemsByTreeSha:(NSString *)sha
                            user:(NSString *)user
                      repository:(NSString *)repository {
  
  [self makeRequest:[NSString
                     stringWithFormat:@"%@/api/v2/xml/tree/show/%@/%@/%@",
                     [GitHubBaseFactory serverAddress],
                     user, repository, sha]];
}

@end
