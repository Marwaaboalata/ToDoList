//
//  AddTaskViewController.m
//  ToDo
//
//  Created by marwa on 02/04/2024.
//

#import "AddTaskViewController.h"
#import "Task.h"
#import "MyProtocol.h"
@interface AddTaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *addTaskTitleTF;

@property (weak, nonatomic) IBOutlet UITextField *addTaskDescTF;


@end

@implementation AddTaskViewController
{
    NSString *priority ;
}
- (IBAction)priorityBtn:(id)sender {
   
    
    switch ([sender selectedSegmentIndex]) {
        case 0:
            priority = @"High";
            break;
        case 1:
            priority = @"Medium";
            break;
        case 2:
            priority = @"Low";
            break;
        default:
            break;
    }
    
}


- (IBAction)addTaskBtn:(id)sender {
    Task *taskobj1 =[Task new];
    [taskobj1 setTitle:_addTaskTitleTF.text];
    [taskobj1 setDescribtion:_addTaskDescTF.text];
    
    
   
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"Current date and time: %@", dateString);
    
    
    
    [taskobj1 setDate:dateString];
    [taskobj1 setTaskPriority:priority];
    //[_myProtocol onClick:taskobj1];
    
    
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *existingTasks = [defaults objectForKey:@"TasksArray"];
        NSMutableArray *tasksArray = existingTasks ? [existingTasks mutableCopy] : [NSMutableArray array];
        
        [tasksArray addObject:[self dictionaryFromTask:taskobj1]];

        [defaults setObject:tasksArray forKey:@"TasksArray"];
        [defaults synchronize];
    
    [_myProtocol onClick:[self dictionaryFromTask:taskobj1]];
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    priority =nil;

    }

- (NSDictionary *)dictionaryFromTask:(Task *)task {
    return @{@"title": task.title,
             @"description": task.describtion,
         //    @"state": task.state,
             @"taskPriority": task.taskPriority,
             @"date": task.date};
}





@end
