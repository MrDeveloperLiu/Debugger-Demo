//
//  ViewController.m
//  Demo
//
//  Created by 刘杨 on 2019/1/5.
//  Copyright © 2019年 liu. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () <EDJListObjectDelegate>
@property (nonatomic, strong) DeJavaScriptCore *jvm;
@property (nonatomic, strong) DeAppWindow *app;

@property (nonatomic, strong) EDJTableListView *listView;
@property (nonatomic, strong) EDJSingleListDatasource *listDs;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Main";
    [self.view addSubview:self.listView];
    
    NSData *d = [NSData dataInBundle:@"res" name:@"main.json"];
    NSArray *datas = [NSJSONSerialization JSONObjectWithData:d options:0 error:nil];
    self.listDs.datas = [datas indexMap:^id(id object, id container, NSUInteger idx, BOOL *stop) {
        EDJListObject *list = [EDJListObject mappingObjectWithContent:object];
        if (idx == 0) {
            EDJListObjectAction *insertAction = [EDJListObjectAction new];
            insertAction.Id = @"ins";
            insertAction.title = @"添加";
            
            EDJListObjectAction *deleteAction = [EDJListObjectAction new];
            deleteAction.Id = @"del";
            deleteAction.title = @"删除";
            deleteAction.style = UITableViewCellEditingStyleDelete;
            deleteAction.rowStyle = UITableViewRowActionStyleDestructive;
            deleteAction.actionStyle = UIContextualActionStyleDestructive;
            
            list.actions = @[insertAction, deleteAction];
        }
        list.UIDelegate = self;
        return list;
    }];
}

- (void)listObject:(EDJListObject *)object performSelector:(NSString *)selector userinfo:(id)userinfo{
    
}

- (void)listObject:(EDJListObject *)object performAction:(NSString *)Id action:(EDJListObjectAction *)action{

}

- (EDJTableListView *)listView{
    if (!_listView) {
        _listView = [[EDJTableListView alloc] initWithFrame:kContentRect style:UITableViewStyleGrouped];
        _listDs = [[EDJSingleListDatasource alloc] initWithTableView:_listView delegate:nil];
        _listDs.option = EDJBaseListDatasourceOptionSelectUsingBlock;
        [_listDs setSelectBlock:^(EDJBaseListDatasource *ds, NSIndexPath *indexPath) {
            id item = [ds itemAtIndexPath:indexPath];
            NSLog(@"tap: %@", item);
        }];
    }
    return _listView;
}

- (void)showApp{
    _jvm = [DeJavaScriptCore new];
    
    DeLogger *log = [[DeLogger alloc] initWithName:@"Console"];
    [_jvm.jsContext registerInstance:@"console" instance:log];
    [_jvm.jsContext loadJsFile:@"JSApplication.js" inBundle:nil];
    
            
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor redColor];
    DeAppWindow *app = [[DeAppWindow alloc] initWithRootViewController:vc];
    app.jvm = _jvm;
    [app show];
    _app = app;
}
@end
