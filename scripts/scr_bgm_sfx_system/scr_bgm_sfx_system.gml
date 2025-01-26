/// BGM SYSTEM

#macro AUDIO_PRIORITY_BGM 100
#macro AUDIO_PRIORITY_COLLECT 98
#macro AUDIO_PRIORITY_SFX_HINT 95
#macro AUDIO_PRIORITY_SFX_BASIC 90

#macro AUDIO_BGM_CROSS_FADE_GAIN_MICROSECS 2000
#macro AUDIO_BGM_CROSS_FADE_LOSS_MICROSECS 2000
#macro AUDIO_BGM_CROSS_FADE_DESTROY_SECONDS 2
#macro __BGM global.__audio_system.bgm

global.__audio_system = {
	bgm : {
		current : noone,				/// The current audio is playing, it will save the asset reference
		bgm_playing : ds_list_create(),	/// a list with audio ids, they are playing right now
		bgm_stoping : ds_list_create(), /// a list with audio ids, they are about to be stoped
		time_source : time_source_create(time_source_game, AUDIO_BGM_CROSS_FADE_DESTROY_SECONDS, time_source_units_seconds, __bgm_kill, [], 1, 1), /// It will try to kill all bgms that are stoping playing
	},
}

function bgm_play(audio_asset, stop_all = true){
	if(__BGM.current == audio_asset) return;
	if(stop_all) bgm_stop_all();
	
	__BGM.current = audio_asset
	
	var _audio_id = audio_play_sound(audio_asset, AUDIO_PRIORITY_BGM, true, 0);
	audio_sound_gain(_audio_id, bgm_get_volume(), AUDIO_BGM_CROSS_FADE_GAIN_MICROSECS);
	ds_list_add(__BGM.bgm_playing, _audio_id);
	
	return _audio_id;
}

function bgm_stop_all(){
	
	for(var i = 0; i < ds_list_size(__BGM.bgm_playing); i++){
		var _audio_id = __BGM.bgm_playing[| i];
		ds_list_add(__BGM.bgm_stoping, _audio_id);
		audio_sound_gain(_audio_id, 0, AUDIO_BGM_CROSS_FADE_LOSS_MICROSECS);
	}
	
	ds_list_clear(__BGM.bgm_playing);

	/// SETUP TIMESOURCE TO DESTROY MUSIC
	var _ts = __BGM.time_source;
	switch(time_source_get_state(_ts)){
		case time_source_state_initial: break;
		default: 
			time_source_reconfigure(_ts, AUDIO_BGM_CROSS_FADE_DESTROY_SECONDS, time_source_units_seconds, __bgm_kill,[], 1, 1);
	}
	
	time_source_start(_ts); 
}

function __bgm_kill(){
	for(var i = 0; i < ds_list_size(__BGM.bgm_stoping); i++){
		audio_stop_sound(__BGM.bgm_stoping[| i]);
	}
	
	ds_list_clear(__BGM.bgm_stoping);
}

/// OVERWRITE this macros or functions
#macro AUDIO_SYSTEM_GET_SFX_VOLUME with(global.options){ return sound_master * sound_sfx }
#macro AUDIO_SYSTEM_GET_BGM_VOLUME with(global.options){ return sound_master * sound_bgm }

function bgm_get_volume(){ AUDIO_SYSTEM_GET_BGM_VOLUME } /// Get the bgm volume
function sfx_get_volume(){ AUDIO_SYSTEM_GET_SFX_VOLUME } /// Get the sfx volume 

function bgm_on_volume_change(){ 
	for(var i = 0; i < ds_list_size(__BGM.bgm_playing); i++){
		audio_sound_gain(__BGM.bgm_playing[| i], bgm_get_volume(), 0);
	}	
}
function sfx_on_volume_change(){}


function sfx_play(audio, loop = false, gain = 1, offset = 0, pitch = 1, priority = AUDIO_PRIORITY_SFX_BASIC){
	return audio_play_sound(audio, priority, loop, gain * sfx_get_volume(), offset, pitch);
}

function sfx_play_simple(audio, gain = 1, priority = AUDIO_PRIORITY_SFX_BASIC, _offset = 0){
	return audio_play_sound(audio, priority, false, gain * sfx_get_volume(), _offset);
}


function sfx_play_exists(audio, gain = 1, priority = AUDIO_PRIORITY_SFX_BASIC, _offset = 0){
	if(audio != undefined)
		return audio_play_sound(audio, priority, false, gain * sfx_get_volume(), _offset);

	return undefined;
}