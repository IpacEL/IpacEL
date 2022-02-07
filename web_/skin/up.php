<?php
// 允许上传的图片后缀
$temp = explode(".", $_FILES["file"]["name"]);
//echo $_FILES["file"]["type"];
$extension = end($temp);//获取文件后缀名
if ((($_FILES["file"]["type"] == "image/x-png")
|| ($_FILES["file"]["type"] == "image/png"))
&& ($_FILES["file"]["size"] < 524288) //512KB
&& in_array($extension, array('png'))){
	
	if ($_FILES["file"]["error"] > 0){
		$cca = "Null";
	}else{
		//通过检查
		$fileName = md5_file($_FILES["file"]["tmp_name"]).'.png';//以文件MD5为文件名
		move_uploaded_file($_FILES["file"]["tmp_name"], "BliCTy/".$fileName);//移动文件并修改文件名称
		$cca = $fileName;
	}
	
}
else{$cca = "Null";}
header("location: index.html?result=".$cca);
?>