//
//  TaskDetailViewController.m
//  ToDo
//
//  Created by marwa on 02/04/2024.
//

#import "TaskDetailViewController.h"
#import "ProgressViewController.h"

@interface TaskDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *detailDescTF;
@property (weak, nonatomic) IBOutlet UITextField *detailDateTF;

@property (weak, nonatomic) IBOutlet UITextField *detailPriority;

@property (weak, nonatomic) IBOutlet UITextField *detailTitleTF;

@property (weak, nonatomic) IBOutlet UISegmentedControl *priortyBtn;


@end

@implementation TaskDetailViewController
- (IBAction)editAction:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _detailTitleTF.text = [_taskForDetails title];
    _detailDescTF.text = [_taskForDetails describtion];
    _detailDateTF.text =[_taskForDetails date];
    _detailPriority.text = [_taskForDetails taskPriority];
    
    if([[_taskForDetails taskPriority] isEqual:@"High"]){
        _priortyBtn.selectedSegmentIndex = 0;
        
    }else if([[_taskForDetails taskPriority] isEqual:@"Low"]){
        _priortyBtn.selectedSegmentIndex = 2;
    }else{
        _priortyBtn.selectedSegmentIndex = 1;
    }
   
   
}


- (IBAction)stateBtnAction:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            break;
        case 1:
        {
            
            
            // Retrieve the existing task array from UserDefaults or create a new one
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSArray *existingTasks = [defaults objectForKey:@"ProgressTasksArray"];
               
            
            //remove
               NSArray *existingTasksToDo = [defaults objectForKey:@"TasksArray"];
            
               NSMutableArray *existingTasksToDoMutable = existingTasksToDo ? [existingTasksToDo mutableCopy] : [NSMutableArray array];
            
            
            
               [existingTasksToDoMutable removeObject:[self dictionaryFromTask:_taskForDetails]];
              [defaults setObject:existingTasksToDoMutable forKey:@"TasksArray"];
              [_myProtocolDelete onClickDelete:[self dictionaryFromTask:_taskForDetails]];
            
           
            
            //
            
                NSMutableArray *tasksArray = existingTasks ? [existingTasks mutableCopy] : [NSMutableArray array];
                [tasksArray addObject:[self dictionaryFromTask:_taskForDetails]];
                [defaults setObject:tasksArray forKey:@"ProgressTasksArray"];
            
            
            
                [defaults synchronize];
          //  ProgressViewController *progVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProgressViewController"];
            
        //    [self.navigationController pushViewController:progVC animated:YES];
            [_myProtocolProgress onClick:[self dictionaryFromTask:_taskForDetails]];
            
        }
            break;
        case 2:
        {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSArray *existingTasks = [defaults objectForKey:@"DoneTasksArray"];
                NSMutableArray *tasksArray = existingTasks ? [existingTasks mutableCopy] : [NSMutableArray array];
                
            //remove
               NSArray *existingTasksToDo = [defaults objectForKey:@"TasksArray"];
            
               NSMutableArray *existingTasksToDoMutable = existingTasksToDo ? [existingTasksToDo mutableCopy] : [NSMutableArray array];
            
            
            
               [existingTasksToDoMutable removeObject:[self dictionaryFromTask:_taskForDetails]];
              [defaults setObject:existingTasksToDoMutable forKey:@"TasksArray"];
              [_myProtocolDelete onClickDelete:[self dictionaryFromTask:_taskForDetails]];
            
           
            
            //

                [tasksArray addObject:[self dictionaryFromTask:_taskForDetails]];
                [defaults setObject:tasksArray forKey:@"DoneTasksArray"];
                [defaults synchronize];
            
            
        }
            
            break;
        default:
            break;
    }
    
}
- (NSDictionary *)dictionaryFromTask:(Task *)task {
    return @{@"title": task.title,
             @"description": task.describtion,
         //    @"state": task.state,
             @"taskPriority": task.taskPriority,
             @"date": task.date};
}

- (IBAction)editBtnAction:(id)sender {
    /*
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *tasksArray = [[defaults objectForKey:@"TasksArray"] mutableCopy];
    
    NSInteger i = [tasksArray indexOfObjectPassingTest:^BOOL(NSDictionary *taskDict, NSUInteger idx, BOOL * _Nonnull stop) {
        return [taskDict[@"title"] isEqualToString:_taskForDetails.title]; // Assuming titles are unique
    }];
    
    
    _taskForDetails.title = _detailTitleTF.text;
    _taskForDetails.describtion = _detailDescTF.text;
    _taskForDetails.date = _detailDateTF.text; // Assuming you have a date text field
    
    [tasksArray replaceObjectAtIndex:i withObject:_taskForDetails];
    [defaults setObject:tasksArray forKey:@"TasksArray"];
    
   
     [self.navigationController popViewControllerAnimated:YES];
     */
}


- (Task *)taskFromDictionary:(NSDictionary *)dict {
    Task *task = [[Task alloc] init];
    task.title = dict[@"title"];
    task.describtion = dict[@"description"];
    //task.state = dict[@"state"];
    task.taskPriority = dict[@"taskPriority"];
    task.date = dict[@"date"];
    return task;
}


@end
