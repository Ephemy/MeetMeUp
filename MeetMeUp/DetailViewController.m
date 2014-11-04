//
//  DetailViewController.m
//  MeetMeUp
//
//  Created by Jonathan Chou on 11/3/14.
//  Copyright (c) 2014 Jonathan Chou. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rsvpLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property NSDictionary *dictionaryOfData;
@property NSArray *resultsOfData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.results.name;
        self.rsvpLabel.text = [NSString stringWithFormat:@"%@",self.results.rsvpCount];
        self.groupNameLabel.text = self.results.hostingGroup;
        self.descriptionLabel.text = self.results.eventDescription; //use as webview html formatting
    [self anotherJSONCall];
    
    // Do any additional setup after loading the view.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //    NSArray *arrayOfData = self.dictionaryOfData [@"results"];
    //    if(self.defaultView){
    NSDictionary *dataContainer = self.resultsOfData[indexPath.row];
    
    cell.textLabel.text = dataContainer[@"member_name"];
    cell.detailTextLabel.text = dataContainer[@"comment"];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultsOfData.count;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
    WebViewController *webVC = segue.destinationViewController;
    NSURL *url = [NSURL URLWithString:self.results.eventURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webVC.request = request; //TODO: pass NSString instead of NSURLRequest.
}



//TODO: Make this method gooder.
-(void)anotherJSONCall
{
    NSString *eventID = self.resultsID;
    NSString *searchURL = [NSString stringWithFormat:@"https://api.meetup.com/2/event_comments.json?event_id=%@&key=a25646c7539111e1d1c7a25b3e2b23", eventID];
    
    NSURL *url = [NSURL URLWithString:searchURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if(connectionError)
         {
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error error!" message:connectionError.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
             [alert addAction:okButton];
             [self presentViewController:alert animated:YES completion:nil];
         }
         else
         {
             self.dictionaryOfData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             self.resultsOfData = self.dictionaryOfData[@"results"];
             //             NSLog(@"%@", self.resultsOfData);
             [self.tableView reloadData];
             
             //member name
             //time
             //comment
             
         }
         
         
     }];

}




@end
