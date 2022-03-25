//复用
function _getd($i){return document.getElementById($i)}



function _1(){
	//输入数据
	var $oldConfig = _getd('oldConfigInput').value.split(/[(\r\n)\r\n]+/); //根据换行转换为数组
	var $newConfig = _getd('newConfigInput').value; //直接输入
	
	//独占一行的注释
	var $outErr = '';
	
	//遍历旧配置数组
	var $oldConfigLength = $oldConfig.length;
	for(var $i = 0;    $i < $oldConfigLength;    $i++){
		var $old = $oldConfig[$i];
		
		//如果存在 "#"
		if($old.indexOf('#') !== -1){
			//截取第一个 "#" 前面的字符. 删除首尾空格
			var $old_c = $old.substring(0, $old.indexOf('#')).replace(/(^\s*)|(\s*$)/g, '');
			//截取第一个 "#" 及后面的字符
			var $old_n = $old.substring($old.indexOf('#'));
			
			if($old_c !== ''){
				//将新配置中的一行配置替换为旧配置+注释
				$newConfig = $newConfig.replace($old_c, $old_c +' '+ $old_n);
			}else{
				//错误输出
				$outErr += '    '+ $old_n +"\r\n";
			}
		}
	}
	
	//输出 outConfigInput
	//独占一行的注释
	if($outErr !== '') $outErr = "独占一行的注释: \r\n"+ $outErr +"\r\n\r\n";
	//输出到输入框
	_getd('outConfigInput').value = $outErr + $outData;
	
	_getd('_1status').innerHTML = '状态: 转换完成';
};



function _2($m){
	//防报错
	try{
		if($m === true){ //压缩
			var $i = _getd('JSONInput').value;
			
			//删除注释
			var $reg = /("([^\\\"]*(\\.)?)*")|('([^\\\']*(\\.)?)*')|(\/{2,}.*?(\r|\n))|(\/\*(\n|.)*?\*\/)/g;
			var $i = $i.replace($reg, function($n){return /^\/{2,}/.test($n) || /^\/\*/.test($n) ? "" : $n});
			
			_getd('outJSONInput').value = JSON.stringify(JSON.parse($i));
		}else{ //格式化
			var $i = _getd('outJSONInput').value;
			var $i = JSON.parse($i); //字符串转对象
			_getd('JSONInput').value = JSON.stringify($i, null, 4); //对象转字符串
		}
		_getd('_2status').innerHTML = '状态: 转换完成';
	}
	catch(err){_getd('_2status').innerHTML = '错误: '+ err.message} //输出错误
	finally{}
}





