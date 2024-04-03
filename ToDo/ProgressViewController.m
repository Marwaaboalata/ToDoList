//
//  ProgressViewController.m
//  ToDo
//
//  Created by marwa on 02/04/2024.
//

#import "ProgressViewController.h"
#import "Task.h"
#import "TaskDetailViewController.h"
#import "ProgressDtailsViewController.h"

@interface ProgressViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myProgressTableView;

@end

@implementation ProgressViewController

{
    NSMutableArray *tasksArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myProgressTableView reloadData];
    self.myProgressTableView.delegate=self;
    self.myProgressTableView.dataSource=self;
    
 
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *existingTasks = [defaults objectForKey:@"ProgressTasksArray"];
         tasksArray = existingTasks ? [existingTasks mutableCopy] : [NSMutableArray array];
    
    
    
    
    [self.myProgressTableView reloadData];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [self.myProgressTableView reloadData];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tasksArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellSecond" forIndexPath:indexPath];
    
    UILabel *cllLabel=[cell viewWithTag:5];
    
    UIImageView *img = [cell viewWithTag:4];

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
    
    ProgressDtailsViewController *detail =[self.storyboard instantiateViewControllerWithIdentifier:@"ProgressDtailsViewController"];
    
    NSDictionary *taskDic = tasksArray[indexPath.row];
    Task *currentTask = [self taskFromDictionary:taskDic];
    [detail setTaskForDetailsProgress:currentTask];
    
   //detail.
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


- (void)onClick:(NSDictionary *)task{
    [tasksArray addObject:task];
    [self.myProgressTableView reloadData];
}

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
    NSArray *existingTasks = [[defaults objectForKey:@"ProgressTasksArray"] mutableCopy];
    tasksArray = existingTasks ? [existingTasks mutableCopy] : [NSMutableArray array];
  
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"taskPriority == %@", priority];
    NSArray *filteredTasks = [tasksArray filteredArrayUsingPredicate:predicate];
    
    tasksArray = [NSMutableArray arrayWithArray:filteredTasks];
    
  
    [self.myProgressTableView reloadData];
}
@end
