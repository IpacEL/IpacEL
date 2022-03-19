//复用
function _getd($i){return document.getElementById($i)};

//检测文件
var $oInput = document.getElementById('inp');
$oInput.onchange = function(){
	if(this.value != ''){
		//文件名称
		_getd('fileName').innerHTML = '已选择: '+ this.files[0].name;
		
		//检查文件
		var $cFile = $oInput.files;
		// 512KB
		if($cFile[0].size > 524288 || $cFile[0].type != 'image/png' && $cFile[0].type != 'image/x-png'){
			_getd('fileName').innerHTML = '选择的文件过大或不受支持';
			_getd('upBtn').style.display = 'none';
		}else{
			//通过
			_getd('result').innerHTML = '这里会显示生成的指令';
			_getd('result').style.display = 'none';
			_getd('upBtn').style.display = 'block';
		}
	}
};

//输出
var $url = window.location.href + ';';
if(RegExp(/result/).exec($url)){
	var $res = $url.match(/result=(\S*);/)[1];
	history.pushState('', '', "/array/skin/");//修改URL
	if($res.indexOf("Null") != -1){
		var $result = '选择的文件过大或不受支持';
	}else{
		var $result = '/skin url https://ipacamod.cc/Array/skin/BliCTy/' + $res;
		_getd('fileName').innerHTML = '完成';
		_getd('result').style.display = 'block';
		_getd('upBtn').style.display = 'none';
	}
	_getd('result').innerHTML = $result;
};