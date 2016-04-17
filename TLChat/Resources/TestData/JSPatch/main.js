// main.js

var key = 'JSPatch_ShowDBCrashAlert2';

defineClass("TLAppDelegate : UIResponse <UIAlertViewDelegate>", {
	p__urgentMethod : function() {
		var title = 'JSPatch提示';
		var message = '因近期对部分数据库模型修改，在表情和群模块可能会出现异常，这时请将应用从手机/模拟器上删除，然后重新运行代码即可恢复正常。（P.S. 现在支持从网络下载表情了哦，可到“我的”-“表情”体验。）';
		var needShowAlert = require('NSUserDefaults').standardUserDefaults().objectForKey(key);
		if (needShowAlert == 0) {
			var alert = require('UIAlertView').alloc().initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles(title, message, self, '不再提示', '确定', null);
			alert.setTag(1001);
			alert.show();
		}
	},
	alertView_clickedButtonAtIndex : function(alertView, buttonIndex) {
		if (alertView.tag() == 1001) {
			if (buttonIndex == 0) {	// 不再提示
				require('NSUserDefaults').standardUserDefaults().setObject_forKey('YES', key);
			}
		};
	}
})