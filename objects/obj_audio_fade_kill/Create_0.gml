/// @description 
audio_id = undefined;

configurar = function(audio, tempo){
	audio_id = audio;
	audio_sound_gain(audio, 0, tempo);
	call_later(tempo, time_source_units_seconds, function(){
		audio_stop_sound(audio_id);
		instance_destroy();	
	}, false);
}