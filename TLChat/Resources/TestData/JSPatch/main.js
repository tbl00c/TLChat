// main.js

var key = 'JSPatch_ShowDBCrashAlert';

defineClass("TLAppDelegate : UIResponse <UIAlertViewDelegate>", {
	p__urgentMethod : function() {
		var title = 'JSPatch提示';
		var message = '因近期有频繁的数据库模型修改，如在IM界面出现显示异常或者崩溃现象，请删除应用后重新安装。';
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