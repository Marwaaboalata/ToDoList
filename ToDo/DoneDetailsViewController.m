//
//  DoneDetailsViewController.m
//  ToDo
//
//  Created by marwa on 03/04/2024.
//

#import "DoneDetailsViewController.h"

@interface DoneDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *doneTitleTF;
@property (weak, nonatomic) IBOutlet UITextField *donePriorityTF;

@property (weak, nonatomic) IBOutlet UITextField *doneDescTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priorityBtn;
@property (weak, nonatomic) IBOutlet UITextField *doneDateTF;




@end

@implementation DoneDetailsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _doneTitleTF.text = [_taskForDetailsDone title];
    _doneDescTF.text = [_taskForDetailsDone describtion];
    _doneDateTF.text =[_taskForDetailsDone date];
    _donePriorityTF.text = [_taskForDetailsDone taskPriority];
    
    if([[_taskForDetailsDone taskPriority] isEqual:@"High"]){
        _priorityBtn.selectedSegmentIndex = 0;
        
    }else if([[_taskForDetailsDone taskPriority] isEqual:@"Low"]){
        _priorityBtn.selectedSegmentIndex = 2;
    }else{
        _priorityBtn.selectedSegmentIndex = 1;
    }
   
   
}





@end
