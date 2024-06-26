//
//  ViewController.m
//  ToDo
//
//  Created by marwa on 02/04/2024.
//

#import "ViewController.h"
#import "Task.h"
#import "TaskDetailViewController.h"
#import "AddTaskViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *firstTV;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;

@end

@implementation ViewController
{
    NSMutableArray *tasksArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstTV.delegate=self;
    self.firstTV.dataSource=self;
    
    _tasksList = [NSMutableArray new];
    
    Task *taskobj1 =[Task new];
    [taskobj1 setTitle:@"study"];
    [taskobj1 setDescribtion:@"studyyyy"];
    [taskobj1 setDate:@"date"];
    [_tasksList addObject:taskobj1];
    
    
    // Retrieve the existing task array from UserDefaults or create a new one
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *existingTasks = [defaults objectForKey:@"TasksArray"];
         tasksArray = existingTasks ? [existingTasks mutableCopy] : [NSMutableArray array];
    
    
    
    
    [self.firstTV reloadData];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [self.firstTV reloadData];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tasksArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellFirst" forIndexPath:indexPath];
    
    UILabel *cllLabel=[cell viewWithTag:3];
    
    UIImageView *img = [cell viewWithTag:2];

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
    
    TaskDetailViewController *detail =[self.storyboard instantiateViewControllerWithIdentifier:@"TaskDetailViewController"];
    
    NSDictionary *taskDic = tasksArray[indexPath.row];
    Task *currentTask = [self taskFromDictionary:taskDic];
   // [detail setTaskForDetails:[Task new]];
    [detail setTaskForDetails:currentTask];
    
    
    detail.myProtocolDelete = self;
   
    [self.navigationController pushViewController:detail animated:YES];
    
}
- (IBAction)addBtn:(id)sender {
    AddTaskViewController *addTaskVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddTaskViewController"];
        addTaskVC.myProtocol = self;

        [self.navigationController pushViewController:addTaskVC animated:YES];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tasksArray removeObject:tasksArray[indexPath.row]];
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setObject:tasksArray forKey:@"TasksArray"];
    [defaults synchronize];
    
    [self.firstTV reloadData];
}

- (void)onClick:(NSDictionary *)task{
    [tasksArray addObject:task];
    [self.firstTV reloadData];
    
}
- (void)onClickDelete:(NSDictionary *)task{
    [tasksArray removeObject:task];
    [self.firstTV reloadData];
    
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

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *existingTasks = [[defaults objectForKey:@"TasksArray"] mutableCopy];
        tasksArray = existingTasks ? [existingTasks mutableCopy] : [NSMutableArray array];
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@", searchText];
        NSArray *filteredTasks = [tasksArray filteredArrayUsingPredicate:predicate];
        
        tasksArray = [NSMutableArray arrayWithArray:filteredTasks];
    }
    
    [self.firstTV reloadData];
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
    NSArray *existingTasks = [[defaults objectForKey:@"TasksArray"] mutableCopy];
    tasksArray = existingTasks ? [existingTasks mutableCopy] : [NSMutableArray array];
  
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"taskPriority == %@", priority];
    NSArray *filteredTasks = [tasksArray filteredArrayUsingPredicate:predicate];
    
    tasksArray = [NSMutableArray arrayWithArray:filteredTasks];
    
  
    [self.firstTV reloadData];
}


@end
