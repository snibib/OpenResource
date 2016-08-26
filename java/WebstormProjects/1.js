function DMHelpPage(page) {

    var Nav = com.dmall.Navigator;
    var  pageData = {
        title : "标题2",
        list : [
                {type:1,text:"客服电话",tel:"1010-0818",time:"08:00-21:00"},
                {type:2,text:"支付方式"},
                {type:2,text:"配送方式"},
                {type:2,text:"售后服务"},
                {type:2,text:"常见问题"}
                ]
    };
    page.listView.setTableSeparatorStyle('123');
    page.populate(pageData);
    page.onCellClick=function(data){
        log(data);
        Nav.forward('up://Dmall/Pages/DMHelpDetailPage.xml');
    }

}