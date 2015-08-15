//
//  ESSBeaconIssue.h
//  KTAPP
//
//

#import <Foundation/Foundation.h>
#import "ESSEddystone.h"

@class ESSBeaconIssue;


@protocol ESSBeaconIssueDelegate <NSObject>

@required

- (NSData *)sendingData:(ESSBeaconIssue *)issue;

@end


@interface ESSBeaconIssue : NSObject

@property(nonatomic, weak) id<ESSBeaconIssueDelegate> delegate;

@property(nonatomic, assign) NSTimeInterval onLostTimeout;

-(void)setupService;

- (void)startIssue;

- (void)stopIssue;

- (BOOL)fixBeaconData;

- (BOOL)didBeaconData:(NSData *)value;


@end
