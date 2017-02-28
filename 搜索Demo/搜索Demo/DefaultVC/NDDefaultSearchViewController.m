//
//  NDDefaultSearchViewController.m
//  搜索Demo
//
//  Created by 华美赛佳 on 2017/2/24.
//  Copyright © 2017年 JonesCxy. All rights reserved.
//

#import "NDDefaultSearchViewController.h"


@interface NDDefaultSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>



@property(strong,nonatomic)UISearchBar *searchBar;

@property(strong,nonatomic)NSMutableArray *dataSource;

@property(strong,nonatomic)NSMutableArray *searchDataSource;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;
@property (nonatomic, strong) UIImageView *fuzzyView;

@property (nonatomic, strong) UIView *adviceView;

@end

@implementation NDDefaultSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.tableHeaderView = self.searchBar;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    if (self.tableView == tableView) {
        
        
        NSLog(@"---%ld",self.dataSource.count);
        return self.dataSource.count;
    }
    
    return self.searchDataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{



    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:ID];
    }
    
    NDSearchStockModel *model;
    if (self.tableView == tableView) {
        
        model = self.dataSource[indexPath.row];
    }else{
    
        model = self.searchDataSource[indexPath.row];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",model.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",model.code];
    
    return cell;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    self.searchDataSource = (NSMutableArray *)[[NDSearchTool tool]searchWithFieldArray:@[@"name",@"pingyin",@"code"] inputString:searchText inArray:self.dataSource];

    [self.searchDisplayController.searchResultsTableView reloadData];
}

-(NSMutableArray *)dataSource{

    if (_dataSource) {
        
        return _dataSource;
    }

    _dataSource = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"stockList" ofType:@"plist"];
    
    NSArray *fileArray = [NSArray arrayWithContentsOfFile:path];
    
    NSLog(@"---%@",fileArray);
    
    for (NSDictionary *dict in fileArray) {
        NDSearchStockModel *model = [[NDSearchStockModel alloc]init];
        model.name = dict[@"name"];
        model.pingyin = dict[@"pingyin"];
        model.code = dict[@"code"];
        [_dataSource addObject:model];
    }
    return _dataSource;
}

-(UISearchBar *)searchBar{


    if (_searchBar) {
        return _searchBar;
    }
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
    _searchBar.placeholder = @"您可以通过股票名称,简拼或代码进行查询";
    _searchBar.delegate = self;
    
    return _searchBar;
}

-(UISearchDisplayController *)searchDisplayController{

    if (_searchDisplayController) {
        return _searchDisplayController;
    }

    _searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    _searchDisplayController.searchResultsTableView.dataSource = self;
    _searchDisplayController.searchResultsTableView.delegate = self;
    
    return _searchDisplayController;
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
