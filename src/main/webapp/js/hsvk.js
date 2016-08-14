var go = function(url, $replace){
	if($replace == undefined) $replace = false;
	
	if($replace){
		location.replace(url);
	}else{
		location.href = url;
	}
}