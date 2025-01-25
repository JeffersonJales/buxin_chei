#macro ROOM_AFTER_BOOT rm_fase_1

function game_boot_instances(){
	instance_create(obj_game_overlay);
	instance_create(obj_async_handler);
	instance_create(obj_game_fullscreen);
}

function game_boot_game_start(){	
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	
	lexicon_index_declare_from_csv(LANGUAGE_CSV);
	lexicon_index_fallback_language_set(LANGUAGE_PORTUGUESE);
}

function game_language_set(){
	if(global.options.language == undefined){
		lexicon_locale_set(lexicon_get_os_locale());
		global.options.language = __LEXICON_STRUCT.language == "unknow" ? LANGUAGE_PORTUGUESE : __LEXICON_STRUCT.language;
	}
	else 
		game_language_change(global.options.language, true);
}

function game_boot_first_time(){
	viewports_auto_setup();
	game_language_set();
	room_goto(ROOM_AFTER_BOOT);
}

function game_boot_normal(){
	viewports_auto_setup();
	game_language_set();
	room_goto(ROOM_AFTER_BOOT);
}
