# ScanningByZBar

  - ScanView
  
	1.用ZbarSDK做的二维码扫面View,支持自定义扫描图层
	
	2.用法:
	
	- 支持用xib，直接将一个View改变成ScanView，在VC中加入回调代码即可:
	
			    //扫描二维码
   				 self.scanVIew.callBack = ^(id data) {
   				 	//data即扫描得到的字符串
     				 NSLog(@"hello:%@", data);
   				};
	
 - RecognizeViewController
 
   1.用ZbarSDK做的二维码识别VC,暂不支持汉字二维码识别
   
   2.用法:
   
   - 在你的VC中,继承RecognizeViewController即可，加入回调代码:
   
   			    //识别二维码
    			self.callBack = ^(id data) {
      				NSLog(@"%@", data);
    			};
