//
//  Task.h
//  ToDo
//
//  Created by marwa on 02/04/2024.
//

#import <Foundation/Foundation.h>


@interface Task : NSObject <NSCoding>

@property NSString *title;
@property NSString *describtion;
//@property NSString *state;
@property NSString *taskPriority;
@property NSString *date;

@end
