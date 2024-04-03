//
//  DoneViewController.m
//  ToDo
//
//  Created by marwa on 02/04/2024.
//

#import "DoneViewController.h"
#import "Task.h"
#import "DoneDetailsViewController.h"

@interface DoneViewController ()


@property (weak, nonatomic) IBOutlet UITableView *doneTableView;

@end

@implementation DoneViewController

{
    NSMutableArray *tasksArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.doneTableView.delegate=self;
    self.doneTableView.dataSource=self;
    
 
    
    // Retrieve 
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *existingTasks = [defaults objectForKey:@"DoneTasksArray"];
         tasksArray = existingTasks ? [existingTasks mutableCopy] : [NSMutableArray array];
    
    
    
    
    [self.doneTableView reloadData];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [self.doneTableView reloadData];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tasksArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellDone" forIndexPath:indexPath];
    
    UILabel *cllLabel=[cell viewWithTag:6];
    
    UIImageView *img = [cell viewWithTag:7];

  //  cllLabel.text= [_tasksList[indexPath.row] title];
    
    if ([tasksArray count] > 0 && indexPath.row < [tasksArray count]) {
        NSDictionary *taskDic = tasksArray[indexPath.row];
        Task *currentTask = [self taskFromDictionary:taskDic];
        cllLabel.text = [currentTask title];
        
        if ([currentTask.taskPriority isEqualToString:@"High"]) {
            img.image = [UIImage imageNamed:@"h"];
        } else if ([currentTask.taskPriority isEqualToString:@"Low"]) {
            img.image = [UIImage imageNamed:@"l"];
        } else if ([currentTask.taskPriority isEqualToString:@"Medium"]) {
            img.image = [UIImage imageNamed:@"m"];
        } else {
            img.image = [UIImage imageNamed:@"non"];
        }
    } else {
        cllLabel.text = @"";
        img.image = nil;
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DoneDetailsViewController *detail =[self.storyboard instantiateViewControllerWithIdentifier:@"DoneDetailsViewController"];
    
    NSDictionary *taskDic = tasksArray[indexPath.row];
    Task *currentTask = [self taskFromDictionary:taskDic];
    [detail setTaskForDetailsDone:currentTask];
    
   
    [self.navigationController pushViewController:detail animated:YES];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.0; }
- (IBAction)filtration:(id)sender {

    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            [self filterTasksByPriority:@"High"];
            break;
            
        case 1:
            [self filterTasksByPriority:@"Medium"];
            break;
            
        case 2:
            [self filterTasksByPriority:@"Low"];
            break;
            
        default:
            break;
    }
}

- (void)filterTasksByPriority:(NSString *)priority {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *existingTasks = [[defaults objectForKey:@"DoneTasksArray"] mutableCopy];
    tasksArray = existingTasks ? [existingTasks mutableCopy] : [NSMutableArray array];
  
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"taskPriority == %@", priority];
    NSArray *filteredTasks = [tasksArray filteredArrayUsingPredicate:predicate];
    
    tasksArray = [NSMutableArray arrayWithArray:filteredTasks];
    
  
    [self.doneTableView reloadData];
}


@end
