/// 
function bgm_auto_set_on_room_start(){
	var _bgm = undefined;
	
	switch(room){
		case rm_fase_1: _bgm = BGM_buxim_xei_stage_1; break;	
		case rm_menu:	_bgm = undefined; break;	
		case rm_mapa:	_bgm = undefined; break;	
	}
	
	if(_bgm != undefined) bgm_play(_bgm, true);
}

function audio_stop_sound_fade(audio_id, tempo_milisegundos = 500){
	var obj_audio_kill = instance_create_depth(0, 0, 0, obj_audio_fade_kill);
	obj_audio_kill.configurar(audio_id, tempo_milisegundos)
}

function audio_stop_sound_exists(audio_id){
	if(audio_exists(audio_id) || audio_is_playing(audio_id))
		audio_stop_sound(audio_id);
}