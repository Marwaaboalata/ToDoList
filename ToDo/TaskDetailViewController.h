//
//  TaskDetailViewController.h
//  ToDo
//
//  Created by marwa on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "MyProtocolDelete.h"
#import "MyProtocol.h"
@interface TaskDetailViewController : UIViewController
@property Task *taskForDetails;
@property id<MyProtocolDelete> myProtocolDelete;

@property id<MyProtocol> myProtocolProgress;


@end
