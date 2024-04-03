//
//  ProgressDtailsViewController.m
//  ToDo
//
//  Created by marwa on 03/04/2024.
//

#import "ProgressDtailsViewController.h"

@interface ProgressDtailsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleDetailProgTF;
@property (weak, nonatomic) IBOutlet UITextField *priorityDetailProgTF;
@property (weak, nonatomic) IBOutlet UITextField *descDetailProgTF;

@property (weak, nonatomic) IBOutlet UISegmentedControl *priorityBtn;


@property (weak, nonatomic) IBOutlet UITextField *dateDetailProgTF;


@end

@implementation ProgressDtailsViewController


- (IBAction)addProgTaskToDoneAction:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *existingTasks = [defaults objectForKey:@"DoneTasksArray"];
    NSMutableArray *tasksArray = existingTasks ? [existingTasks mutableCopy] : [NSMutableArray array];
    

    [tasksArray addObject:[self dictionaryFromTask:_taskForDetailsProgress]];
    [defaults setObject:tasksArray forKey:@"DoneTasksArray"];
    [defaults synchronize];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _titleDetailProgTF.text = [_taskForDetailsProgress title];
    _descDetailProgTF.text = [_taskForDetailsProgress describtion];
    _dateDetailProgTF.text =[_taskForDetailsProgress date];
    _priorityDetailProgTF.text = [_taskForDetailsProgress taskPriority];
    
    if([[_taskForDetailsProgress taskPriority] isEqual:@"High"]){
        _priorityBtn.selectedSegmentIndex = 0;
        
    }else if([[_taskForDetailsProgress taskPriority] isEqual:@"Low"]){
        _priorityBtn.selectedSegmentIndex = 2;
    }else{
        _priorityBtn.selectedSegmentIndex = 1;
    }
   
   
}


- (IBAction)stateBtnAction:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
        {
            // Retrieve
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSArray *existingTasks = [defaults objectForKey:@"ProgressTasksArray"];
                NSMutableArray *tasksArray = existingTasks ? [existingTasks mutableCopy] : [NSMutableArray array];
                
             
                [tasksArray addObject:[self dictionaryFromTask:_taskForDetailsProgress]];
               [defaults setObject:tasksArray forKey:@"ProgressTasksArray"];
                [defaults synchronize];
        }
            break;
        case 1:
        {
            // Retrieve
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSArray *existingTasks = [defaults objectForKey:@"DoneTasksArray"];
                NSMutableArray *tasksArray = existingTasks ? [existingTasks mutableCopy] : [NSMutableArray array];
                
              
                [tasksArray addObject:[self dictionaryFromTask:_taskForDetailsProgress]];
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



@end
