//
//  ViewController.h
//  ToDo
//
//  Created by marwa on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "MyProtocol.h"
#import "MyProtocolDelete.h"
@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,MyProtocol,MyProtocolDelete,UISearchBarDelegate>

@property NSMutableArray *tasksList;

@end

