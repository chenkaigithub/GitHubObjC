//
//  GitHubBlobFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/29/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubBlobFactory.h"

@implementation GitHubBlobFactory

#pragma mark -
#pragma mark Memory and member management

//Retain
@synthesize blob;

-(void)cleanUp {
  
  self.blob = nil;
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
  
  if ([elementName isEqualToString:@"blob"]) {
    
    self.blob = [GitHubBlobImp blob];
  }
  self.currentStringValue = [NSMutableString stringWithCapacity:100];
}

-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName {
  
  if ([elementName isEqualToString:@"blob"]) {
    
    [(id<GitHubServiceGotBlobDelegate>)self.delegate
     gitHubService:self
     gotBlob:self.blob];
    
  } else if ([elementName isEqualToString:@"name"]) {
    
    self.blob.name = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"sha"]) {
    
    self.blob.sha = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"mode"]) {
    
    self.blob.mode = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"mime-type"]) {
    
    self.blob.mime = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"data"]) {
    
    self.blob.data = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"size"]) {
    
    self.blob.size = [self.currentStringValue intValue];
    
  } else if ([elementName isEqualToString:@"error"]) {
    
    [self handleErrorWithCode:GitHubServerServerError];
  }
  self.currentStringValue = nil;
}

#pragma mark -
#pragma mark Interface implementation
#pragma mark - Class

+(GitHubBlobFactory *)blobFactoryWithDelegate:
(id<GitHubServiceGotBlobDelegate>)delegate {
  
  return [[[GitHubBlobFactory alloc] initWithDelegate:delegate] autorelease]; 
}

#pragma mark - Instance

-(void)requestBlobByTreeSha:(NSString *)sha
                       user:(NSString *)user
                 repository:(NSString *)repository
                       path:(NSString *)path {
  
  [self makeRequest:[NSString
                     stringWithFormat:
                     @"%@/api/v2/xml/blob/show/%@/%@/%@/%@?meta=1",
                     [GitHubBaseFactory serverAddress],
                     user, repository, sha, path]];
}

-(void)requestBlobWithDataByTreeSha:(NSString *)sha
                               user:(NSString *)user
                         repository:(NSString *)repository
                               path:(NSString *)path {
  
  [self makeRequest:[NSString
                     stringWithFormat:@"%@/api/v2/xml/blob/show/%@/%@/%@/%@",
                     [GitHubBaseFactory serverAddress],
                     user, repository, sha, path]];
}

@end
