function bgm_auto_set_on_room_start(){
	var _bgm = undefined;
	
	switch(room){
		case rm_fase_1: _bgm = undefined; break;	
		case rm_menu:	_bgm = undefined; break;	
		case rm_mapa:	_bgm = undefined; break;	
	}
	
	if(_bgm != undefined) bgm_play(_bgm, true);
}