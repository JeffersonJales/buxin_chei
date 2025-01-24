#macro SAVE_GAME_FILE "data.sav"

function __save_data_to_string(){
	global.options.savetime = date_datetime_string(date_current_datetime());
	
	var _json = {
		options : global.options,
	}
	
	return json_stringify(_json);
}


/// Save the game options and collectables
function save_game(){
	var _str = __save_data_to_string();
	var _buff = buffer_create(string_byte_length(_str) + 1, buffer_fixed, 1);
	buffer_write(_buff, buffer_string, _str);
	buffer_save_compress_async(_buff, SAVE_GAME_FILE, __save_game_finish,, true);
}

/// Load the game options and collectables, only in the game start
function load_game(){
	buffer_load_compress_async(SAVE_GAME_FILE, __load_game_finish,, true);
}

/// When games finishing save
function __save_game_finish(buffer_data){
	mailpost_delivery(MESSAGE_SAVE_GAME, buffer_data);
}

function __load_game_data_json(json_data){
	__load_game_struct_foreach(json_data.options, "options");
	__load_game_fixes();
	mailpost_delivery(MESSAGE_LOAD_GAME);
}


/// WHen games finishes loading
function __load_game_finish(buffer_data){
	if(buffer_data.__async_event_status){
		var _buff = buffer_data.__buffer_id;
		var _str = buffer_read(_buff, buffer_string);
		var _json = json_parse(_str);
		__load_game_data_json(_json);
	}
	else{
		game_boot_first_time();
	}
}

function __load_game_struct_foreach(struct_to_overwrite, global_struct_pointer){
	if(!variable_global_exists(global_struct_pointer)) return;
	
	var _global = variable_global_get(global_struct_pointer);
	var _names = variable_struct_get_names(struct_to_overwrite);
	for (var i = 0; i < array_length(_names); ++i) {
		_global[$ _names[i]] = struct_to_overwrite[$ _names[i]];
	}
}


