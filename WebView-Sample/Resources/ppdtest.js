ppd.ready(function(){
    // 注册方法，让Native层调用
    ppd.registerHandler("functionInJs", function(data, responseCallback) {
        document.getElementById("show").innerHTML = ("data from Java: = " + data);
        var responseData = "from js callback.";
        responseCallback(responseData);
    });
});

var ppdTest = {};

//h5首页
ppdTest.h5HomePage = function() {
	ppd.call('openWin', {
		url:"ppdai://page.ppd/webvc?url=https://m.ppdai.com"
	});
}

//h5首页
ppdTest.urlPage = function() {
	ppd.call('openWin', {
		url:"https://m.ppdai.com"
	});
}

//pushWindow
ppdTest.pushWindow = function() {
	ppd.call('openWin', {
		url:"ppdai://page.ppd/orderlist",
		params:{
			orderType:100
		}
	});
}

//popWindow
ppdTest.popWindow = function() {
	ppd.call('closeWin');
}

ppdTest.titleBar = function(){
        ppd.call('titleBar', {
            visible:1, //控制整个标题栏是否可见，默认为1可见
            title:"this is a title",
            backIcon:{
                visible:1, //是否显示返回按钮, 默认为1显示
                onClick:'jTest.pageBack' //点击事件
            },
            shareIcon:{
                visible:1, //是否显示分享按钮, 默认为1显示
                title: "J标题",
                content: "J内容",
                moment: "朋友圈",
                sina:"",
                linkUrl: "http://www.baidu.com",
                imgUrl: "https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=988553887,3280974760&fm=80", // 分享图标
                hide:["SinaWeibo"]
            },
            msgIcon:1, //是否显示消息图标
            cartIcon:1,
            reportIcon:1,
            editIcon:1
        });
    }

//登录
ppdTest.userLogin = function() {
    var data = {
        success:function(res){
            alert("success:"+ res.data.name);
        },
        complete:function(res){
            alert("complete:" + res.data.name);
        },
        fail:function(res){
            alert("fail:" + res.data.name + "____" + res.msg);
        }
    };
	ppd.call('userLogin', data);
}
