// Script Desc 
#macro ROOM_SPEED game_get_speed(gamespeed_fps)

/// Literaly doing nothing
function do_nothing(){}

/// Returning true, only that
function return_true(){ return true; }

/// Returning false, only that
function return_false(){ return false; }

/// Creating a instance of the given object 
function instance_create(obj){
	return instance_create_depth(0, 0, 0, obj);
}

function instance_create_case_not_exist(obj){
	if(!instance_exists(obj)) instance_create(obj);
}

function instance_destroy_exists(obj){
	if(instance_exists(obj)) instance_destroy(obj);
}

function instance_set_sprite(spr, img_index = 0, img_speed = 1){
	sprite_index = spr;
	image_index = img_index;
	image_speed = img_speed;
}


function instance_find_all(obj){
	var num = instance_number(obj);
	var arr = array_create(num);
	for(var i = 0; i < num; i++){
		arr[i] = instance_find(obj, i);	
	}
	
	return arr;
}

/// Call this from an instance, set the xscale and yscale with the given scale
function image_scale(scale){
	image_xscale = scale;
	image_yscale = scale;
}

function tween_scale_base_init(){
	__tween_scale = undefined;
	__xscale_base = image_xscale;
	__yscale_base = image_yscale;
}

function tween_scale_base_exec(xscale = image_xscale + 0.1, yscale = image_yscale + 0.1){
	TweenDestroySafe(__tween_scale);
	__tween_scale = TweenEasyScale(xscale, yscale, __xscale_base, __yscale_base, 0, 15, EaseInOutBack, 0);
}

/// Print an message in the output window
function print(){
	var _str = "";
	for(var i = 0; i < argument_count; i++){
		_str += string(argument[i]) + " ";
	}
	
	show_debug_message(_str);
}

/// Show a message in the dialog window and the output window	. 
function show(){
	var _str = "";
	for(var i = 0; i < argument_count; i++){
		_str += string(argument[i]) + " ";
	}
	
	show_debug_message(_str);
	SHOW_MESSAGE(_str);
}

function array_get_random(array){
	return array[irandom(array_length(array) - 1)];	
}

function ds_list_get_random(list){
	return list[| irandom(ds_list_size(list) - 1)];	
}

/// Getting the last index of the array
/// @return {Any,Undefined}
function array_last(arr){
	var _len = array_length(arr);
	if(_len == 0) 
		return undefined;
	
	return arr[_len - 1];
}
	
function array_include(arr, value){
	for(var i = 0; i < array_length(arr); i++){
		if(arr[i] == value)
			return true;
	}
	
	return false;
}
/// Getting all instances of the given layer
/// @return {Array.Id}
function layer_instance_get_instances(layer_id){
	var _arr = layer_get_all_elements(layer_id);
	for(var i = 0; i < array_length(_arr); i++){
		_arr[i] = layer_instance_get_instance(_arr[i]);
	}
	
	return _arr;
}

function string_concat(sep = " "){
	var _str = "";
	for(var i = 1; i < argument_count; i++){
		_str += string(argument[i]) + sep;
	}
	
	return _str;
}
	
//function array_foreach(arr, func){
//	for (var i = 0; i < array_length(arr); ++i) {
//		func(arr[i]);
//	}
//}

function deactive_all_layers(){
	var _arr_layers = layer_get_all();
	for (var i = 0; i < array_length(_arr_layers); ++i) {
		layer_set_visible(_arr_layers[i], false)
	}
}