/// SETUP MACROS AND GLOBALS FOR THE GAME

/// --- Globais editaveis ----

global.options = {
	sound_master : 1,					/// The master sound of the game
	sound_sfx : 1,						/// SFX base audio volume
	sound_bgm : 1,						/// BGM base audio volume
	sound_normal_collect : true,		/// Can play the normal collect sfx
	sound_special_collect : true,		/// Can play the special collect sfx
	fullscreen : false,					/// Starts fullscreen or not
	already_see_intro : true,			/// Player already have seen the intro
	game_finished : false,				/// If the player already beated the game at least once
	language : LANGUAGE_PORTUGUESE,		/// The current language
	lang_locale : LANGUAGE_PORTUGUESE,	/// Case it uses the os language system
	savetime : date_datetime_string(date_current_datetime()), /// The time this save as created
}

global.game_blackboard = {
	start_game_on_stage_select : false,
	device_pos_x : 0,
	device_pos_y : 0,
	font_title : "spr_font_galindo",
	font_common : "spr_font_itim",
	input_click : false,
	input_holding_click : false,
}

#macro blackboard global.game_blackboard
#macro UPSCALING_SHADER false

#region ROOM TRANSITION

function room_goto_ext(rm){
	with(obj_button_generic) button_kill();
	
	instance_destroy(obj_room_transition);
	var i = instance_create(obj_room_transition);
	i.setup_room_transition(rm);
}

#endregion

#region LANGUAGE - Macros
function game_language_change(new_lang, force = false){
	if(new_lang == global.options.language && !force) return;
	
	global.options.language = new_lang;
	lexicon_language_set(new_lang);

	var _font_title = LANGUAGE_FONT_LATIN_TITLE;
	var _font_commom = LANGUAGE_FONT_LATIN_COMMOM;
	
	if(_font_title != blackboard.font_title){
		blackboard.font_title = _font_title;
		blackboard.font_common = _font_commom;
		scribble_font_set_default(_font_commom);
		scribble_flush_everything();
	}
	
	mailpost_delivery(MESSAGE_LANGUAGE_CHANGE_SETUP, new_lang);
}

#macro LANGUAGE_CSV "locale.csv"
#macro LANGUAGE_ENGLISH "English"
#macro LANGUAGE_PORTUGUESE "Portuguese_Brazil"

#macro LANGUAGE_FONT_LATIN_TITLE "spr_font_galindo"
#macro LANGUAGE_FONT_LATIN_COMMOM "spr_font_itim"

#endregion

#region TAGS
#endregion

#region DEPTHS
#macro DEPTH_FRONT_ALL -100
#macro DEPTH_FRONT_ARROW -5
#endregion

#region MESSAGE MACROS (FOR MAILPOST USAGE)
#macro MESSAGE_NORMAL_COLLECT "Normal"
#macro MESSAGE_SPECIAL_COLLECT "Special"
#macro MESSAGE_COLLECT_ALL_ELEMENTS "GameEnd"
#macro MESSAGE_COLLECT_FINISH_GAME "FinishGame"

#macro MESSAGE_FULLSCREEN_CHANGE "FullScreen"
#macro MESSAGE_BUTTON_CLICK "ButtonClick"
#macro MESSAGE_BUTTON_CLICK_DISABLE "ButtonClickDisable"
#macro MESSAGE_BUTTON_ENTER "ButtonEnter"
#macro MESSAGE_BUTTON_LEAVE "ButtonLeave"
#macro MESSAGE_SAVE_GAME "SaveGame"
#macro MESSAGE_LOAD_GAME "LoadGame"
#macro MESSAGE_LAYER_CREATE "OverlayNormalCreate"
#macro MESSAGE_OVERLAYER_CREATE "OverlayCreate"
#macro MESSAGE_OVERLAYER_DESTROY "OverlayDestroy"
#macro MESSAGE_OVERLAYER_DESTROY_ALL "OverlayDestroyAll"

#macro MESSAGE_TIMELINE_ACTION_END "TimelineActionEnd"
#macro MESSAGE_TIMELINE_ACTION_START "TimelineActionStart"

#macro MESSAGE_BGM_VOLUME_CHANGE "BGMVolumeChange"
#macro MESSAGE_SFX_VOLUME_CHANGE "SFXVolumeChange"
#macro MESSAGE_MASTER_VOLUME_CHANGE "MasterVolumeChange"

#macro MESSAGE_LANGUAGE_CHANGE "LanguageChange"
#macro MESSAGE_LANGUAGE_CHANGE_SETUP "LanguageSetup"

#macro MESSAGE_CLIENTE_FOI_EMBORA "ClienteFoiEmbora"
#endregion

#region BOOTING THE GAME

#endregion

#region Debugger functions

#macro DESTROY_EXIT instance_destroy() exit

//// Debugger - Delete all save files
function debugger_reset_all_save_files(){
	file_delete_default(SAVE_GAME_FILE);
	
	global.options.already_see_intro = false;
	global.options.game_finished = false;
	collectable_save_system_init();
	
	save_game();
}

/// Debugger - Fixes old save files
function __load_game_fixes(){
	var _arr = tag_get_asset_ids(TAG_ROOM_COLLECT, asset_room);
	for(var i = 0; i < array_length(_arr); i++){
		var _name = room_get_name(_arr[i]);
		if(global.collectables_data[$ _name] == undefined){
			global.collectables_data[$ _name] = new __collectable_data();
			print("ID 2 <<->> Room adicionada nos arquivos de save:", _name);
		}
	}
}
#endregion

#region MACROS CONFIG + TARGET 

#macro SHOW_MESSAGE show_message
#macro DEBUG_MODE false

#macro ON_STEAM false
#macro ON_DESKTOP false
#macro ON_SMARTPHONE false

#macro Steam:ON_STEAM true
#macro Steam:ON_DESKTOP true
#macro Steam:DEBUG_MODE true

#macro Smartphone:ON_SMARTPHONE true
#macro Smartphone:SHOW_MESSAGE show_message_async

#macro DESTROY_INSTANCE_NOT_DESKTOP if(!ON_DESKTOP) instance_destroy()
#macro DESTROY_INSTANCE_ON_SMARTPHONE if(ON_SMARTPHONE) instance_destroy()
#macro DESTROY_INSTANCE_NOT_SMARTPHONE if(!ON_SMARTPHONE) instance_destroy()

#endregion