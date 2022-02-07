//复用
function _getd($i){return document.getElementById($i)}

//输出状态
function 输出状态($d, $i){
	_getd($d).innerHTML = '状态: '+ $i;
}

_1();
function _1(){
	//输出状态
	_getd('1_状态').innerHTML = '初始化: 转换为数组';
	
	//转换为数组, 根据换行或者回车进行识别
	var $输入 = _getd('1_输入').value.split(/[(\r\n)\r\n]+/);
	var $输入_新配置 = _getd('1_输入_新配置').value;
	var $存在独占一行的配置 = false;
	
	//获取配置行数量
	//var $新配置行数 = $输入_新配置.split(/\r?\n|\r/).length;
	var $旧配置行数 = $输入.length;
	//遍历数组
	for(var $i=0; $i<$旧配置行数; $i++){
		var $旧配置 = $输入[$i];
		
		//如果旧配置中存在注释, 且不是文件顶部说明
		if($旧配置.indexOf('#') != -1 && $旧配置.match(/(.+(?=#))/) != null){
			//删除旧配置中的注释
			var $旧配置_无注释 = $旧配置.match(/(.+(?=#))/)[1];
			//删除多余的空格
			var $旧配置_无注释 = $旧配置_无注释.replace(/^\s+|\s+$/g, "");
			var $旧配置 = $旧配置.replace(/^\s+|\s+$/g, "");
			
			//如果注释独占了一行
			if($旧配置_无注释 === ''){
				if($存在独占一行的配置 === false){
					var $输入_新配置 = "\r\n\r\n"+ $输入_新配置;
				}
				
				var $输入_新配置 = '    '+ $旧配置 +"\r\n"+ $输入_新配置;
				var $存在独占一行的配置 = true;
			}else{
				//在新配置中查找旧配置
				var $输入_新配置 = $输入_新配置.replace($旧配置_无注释, $旧配置);
			}
		}
		//_getd('1_状态').innerHTML = '状态: '+ $i +'/'+ $旧配置行数;
		输出状态('1_状态', $i +'/'+ $旧配置行数);
	}
	if($存在独占一行的配置 === true){
		var $输入_新配置 = "#存在独占一行的配置: \r\n"+ $输入_新配置;
	}
	//输出新配置
	_getd('1_输出').value = $输入_新配置;
	_getd('1_状态').innerHTML = '状态: 转换完成';
};



function _2($m){
	//防报错
	try{
		if($m === true){ //压缩
			var $i = _getd('2_输入').value;
			
			//删除注释
			var $reg = /("([^\\\"]*(\\.)?)*")|('([^\\\']*(\\.)?)*')|(\/{2,}.*?(\r|\n))|(\/\*(\n|.)*?\*\/)/g;
			var $i = $i.replace($reg, function($n){return /^\/{2,}/.test($n) || /^\/\*/.test($n) ? "" : $n});
			
			_getd('2_输出').value = JSON.stringify(JSON.parse($i));
		}else{ //格式化
			var $i = _getd('2_输出').value;
			var $i = JSON.parse($i); //字符串转对象
			_getd('2_输入').value = JSON.stringify($i, null, 4); //对象转字符串
		}
		_getd('2_状态').innerHTML = '状态: 转换完成';
	}
	catch(err){_getd('2_状态').innerHTML = '错误: '+ err.message} //输出错误
	finally{}
	
	
}