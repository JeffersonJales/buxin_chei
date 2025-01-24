// Script Desc 

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

/// Call this from an instance, set the xscale and yscale with the given scale
function image_scale(scale){
	image_xscale = scale;
	image_yscale = scale;
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
	
function array_foreach(arr, func){
	for (var i = 0; i < array_length(arr); ++i) {
		func(arr[i]);
	}
}

function deactive_all_layers(){
	var _arr_layers = layer_get_all();
	for (var i = 0; i < array_length(_arr_layers); ++i) {
		layer_set_visible(_arr_layers[i], false)
	}
}