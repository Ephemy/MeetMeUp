//
//  ViewController.m
//  MeetMeUp
//
//  Created by Jonathan Chou on 11/3/14.
//  Copyright (c) 2014 Jonathan Chou. All rights reserved.
//

#import "ViewController.h"
#import "Results.h"
#import "DetailViewController.h"

#define kURL @"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=a25646c7539111e1d1c7a25b3e2b23"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSDictionary *dictionaryOfData;
@property NSArray *resultsOfData;
@property (weak, nonatomic) IBOutlet UITextField *searchBarText;
@property NSArray *resultsObjectArray;
@property BOOL defaultView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad]; //wow so clean
    [self loadEventsWithSearchQuery: @"Mobile"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultsOfData.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //    NSArray *arrayOfData = self.dictionaryOfData [@"results"];
//    if(self.defaultView){
        NSDictionary *dataContainer = self.resultsOfData[indexPath.row]; //meetup dictionary
        NSDictionary *dataContainer2 = dataContainer[@"venue"]; //venue dictionary
        
        cell.textLabel.text = dataContainer[@"name"];
        cell.detailTextLabel.text = dataContainer2[@"address_1"];
//    }
//
//    else{
//        
//        NSDictionary *dataContainer = self.resultsOfData[indexPath.row];
//        NSDictionary *dataContainer2 = dataContainer[@"organizer"];
//        
//        cell.textLabel.text = dataContainer2[@"name"];
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",dataContainer2[@"member_id"]];
//        
//    }
//    
    return cell;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)cell
{
    
    DetailViewController *detailVC = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *dataContainer = self.resultsOfData[indexPath.row]; //data container names
    NSDictionary *dataContainer2 = dataContainer[@"venue"];
    NSDictionary *dataContainer3 = dataContainer[@"group"];
    
    
    Results *passedData = [[Results alloc] init]; //represents an Event/Meetup add a convenience initializer
    passedData.name = dataContainer2[@"name"];
    passedData.rsvpCount = dataContainer[@"yes_rsvp_count"];
    passedData.hostingGroup = dataContainer3[@"name"];
    passedData.eventDescription = dataContainer[@"description"];
    passedData.eventURL = dataContainer[@"event_url"];
    detailVC.resultsID = dataContainer[@"id"];
    NSLog(@"%@", dataContainer[@"id"]);
//    passedData.objectID = dataContainer[@"id"];

//    NSLog(@"%@", dataContainer[@"id"]);
    
    detailVC.results = passedData;
    
    
    
    
    
    
}

- (IBAction)onButtonPressedSearch:(UIBarButtonItem *)barButton
{
    [self loadEventsWithSearchQuery:self.searchBarText.text];
}

- (void)loadEventsWithSearchQuery:(NSString *)searchQuery

{

    NSString *topic = searchQuery;
        NSString *searchURL = [NSString stringWithFormat: @"https://api.meetup.com/2/open_events.json?zip=60604&text=%@&time=,1w&key=a25646c7539111e1d1c7a25b3e2b23", topic];
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
             
         }
         
         
     }];
    
}

@end
