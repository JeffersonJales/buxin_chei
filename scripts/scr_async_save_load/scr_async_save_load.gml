/// Script Handle async events with callbacks 
global.async_save_load_map = ds_map_create();
global.async_save_load_pack_map = ds_map_create();



/*
	This functions will help to handle async save and load buffers!
	First, put the obj_async_handler on the first room of your game.
	Now you can use the buffer_save_async_ext and buffer_load_async_ext for normal buffers
	or buffer_save_compress_async and buffer_load_compress_async for compressed buffers (For save files, use the compressed version!)
	
	When the async event finishes, it will call the callBacDone function, passing only a struct as argument.
	See __buffer_async_data to check the struct variables.
*/

/// REMEMBER!!! USE ASYNC SAVE/LOAD to save your game data! It will works on consoles and pc!

#region ----- SIMPLE BUFFER SAVE AND LOAD - COMPRESSED OR NOT
/// @desc With this function you will save the given buffer asyncronously to a given file. You can also set a callback when it finish saving.
/// @param {Id.Buffer} buffer						The buffer index
/// @param {String} filename				The filename to save the buffer
/// @param {Function} callBacDone		This callback will be called when the save finishs
/// @param {Array} callBackArgs			An array index with arguments that will be passed to the callback.
/// @param {Bool} deleteBuffer			A flag to check if it can destroy the buffer when the save complete
/// @param {Real} offset						The offset within the buffer to save from (in bytes).
/// @return N/A
function buffer_save_async_ext(buffer, filename, callBackDone = do_nothing, callBackArgs = [], deleteBuffer = true, offset = 0){
	var _id = buffer_save_async(buffer , filename, offset, buffer_get_size(buffer));
	global.async_save_load_map[? _id] = new __buffer_async_data(_id, filename, buffer, callBackDone, callBackArgs, deleteBuffer);
}

/// @desc With this function you can load the given file aynscronously. You can also set a callback when it finish loading.
/// @param {String} filename				The filename path it will load
/// @param {Function} callBackDone	When finish loading the buffer, this function will be called
/// @param {Array} callBackArgs			An array index with arguments that will be passed to the callback.
/// @param {Bool} deleteBuffer			A flag to check if it can destroy the buffer when the save complete
/// @param {Real} offset						The offset within the buffer to save from (in bytes).
/// @return N/A
function buffer_load_async_ext(filename, callBackDone, callBackArgs = [], deleteBuffer = true,  offset = 0){
	var _buffer = buffer_create(1, buffer_grow, 1);
	var _id = buffer_load_async(_buffer, filename, offset, -1);
	global.async_save_load_map[? _id] = new __buffer_async_data(_id, filename, _buffer, callBackDone, callBackArgs, deleteBuffer);
}

/// @desc With this function you will save the given buffer asyncronously to a given file. You can also set a callback when it finish saving.
///	With will also compress the save data before saving
/// @param {Id.Buffer} buffer						The buffer index
/// @param {String} filename				The filename to save the buffer
/// @param {Function} callBacDone		This callback will be called when the save finishs
/// @param {Array} callBackArgs			An array index with arguments that will be passed to the callback.
/// @param {Bool} deleteBuffer			A flag to check if it can destroy the buffer when the save complete
/// @param {Real} offset						The offset within the buffer to save from (in bytes).
/// @return N/A
function buffer_save_compress_async(buffer, filename, callbackDone = do_nothing, callbackArgs = [], deleteBuffer = true, offset = 0){
	
	buffer_seek(buffer, buffer_seek_start, 0);
	var _buffer_compress = buffer_compress(buffer, offset, buffer_get_size(buffer));
	
	var _id = buffer_save_async(_buffer_compress, filename, offset, buffer_get_size(buffer));
	global.async_save_load_map[? _id] = new __save_buffer_compress_async_data(_id, filename, buffer, _buffer_compress, callbackDone, callbackArgs, deleteBuffer);
}

/// @desc With this function you can load the given file aynscronously. You can also set a callback when it finish loading. Use this to load compressed buffers
/// @param {String} filename				The filename path it will load
/// @param {Function} callBackDone	When finish loading the buffer, this function will be called
/// @param {Array} callBackArgs			An array index with arguments that will be passed to the callback.
/// @param {Bool} deleteBuffer			A flag to check if it can destroy the buffer when the save complete
/// @param {Real} offset						The offset within the buffer to save from (in bytes).
/// @return N/A
function buffer_load_compress_async(filename, callbackDone = do_nothing, callbackArgs = [], deleteBuffer = true, offset = 0){
	var _buffer = buffer_create(1, buffer_grow, 1);
	var _id = buffer_load_async(_buffer, filename, offset, -1);
	global.async_save_load_map[? _id] = new __load_buffer_compress_async_data(_id, filename, _buffer, callbackDone, callbackArgs, deleteBuffer);
}
#endregion

#region ----- PACK BUFFERS SAVE AND LOAD - COMPRESSED OR NOT 
/// SIMILAR TO GROUP LOADING BUT WITHOUT THE GROUP_NAME HORROR 
/// IT WILL TRIGGER THE CALLBACK 

function __buffer_pack_data (pack_id, length_pack, array_files, callback, callback_args, delete_buffers) constructor {
	__pack_id = pack_id;
	__length_pack = length_pack;
	__current_lenght_pack = length_pack;
	
	__array_files = array_files;
	__array_async_data = array_create(length_pack);
	
	__callback = callback;
	__callback_args = callback_args;
	__delete_buffers = delete_buffers;
	
	static buffer_load_done = function(buffer_async_data){
		__array_async_data[--__current_lenght_pack] = buffer_async_data;
		if(__current_lenght_pack <= 0){
			__callback(self);
			buffers_destroy();
			ds_map_delete(global.async_save_load_pack_map, __pack_id);
		}
	} 
	
	static buffers_destroy = function(){
		if(__delete_buffers){
			array_foreach(__array_async_data, function(item){
				item.__buffer_delete = true;
				item.buffer_destroy();
			})
		}
	}
}

function buffer_pack_load_async(pack_id, array_filepaths, callback, callback_args = [], delete_buffers = true){
	buffer_pack_load(pack_id, array_filepaths, callback, callback_args, delete_buffers, buffer_load_async_ext);
} 

function buffer_pack_load_compressed_async(pack_id, array_filepaths, callback, callback_args = [], delete_buffers = true){
	buffer_pack_load(pack_id, array_filepaths, callback, callback_args, delete_buffers, buffer_load_compress_async);
}

function buffer_pack_load(pack_id, array_filepaths, callback, callback_args, delete_buffers, buffer_load_method){
	if(global.async_save_load_pack_map[? pack_id] != undefined) return;

	var _len = array_length(array_filepaths);
	var _buffer_load_pack_data = new __buffer_pack_data(pack_id, _len, array_filepaths, callback, callback_args, delete_buffers);
	
	for(var i = 0; i < _len; i++){
		var _method = method(_buffer_load_pack_data, _buffer_load_pack_data.buffer_load_done)
		buffer_load_method(array_filepaths[i], _method,,false);
	}
	
	global.async_save_load_pack_map[? pack_id] = _buffer_load_pack_data;
}



#endregion


#region SAVE_LOAD_ASYNC_DATA CLASSES - INTERNAL USAGE ONLY

/// Dont use it!
function __buffer_async_data_abstract(async_id, callback_done, callback_args, delete_buffer) constructor {
	__id = async_id;
	__callback_done = callback_done;
	__callback_args = callback_args;
	__buffer_delete = delete_buffer;
	__async_event_status = false;

	static set_async_event_status = function(status){
		__async_event_status = status;
	} 
	
	
	static execute = function(struct){
		__callback_done(struct)
		buffer_destroy();
	}
	
	static buffer_destroy = function(){
		if(__buffer_delete) 
			do_nothing();
	}
	
}

/// For saving and loading simple buffers
function __buffer_async_data(async_id, filename, buffer_id, callbackDone, callbackArgs, deleteBuffer) : __buffer_async_data_abstract(async_id, callbackDone, callbackArgs, deleteBuffer) constructor{
	__filename = filename;
	__buffer_id = buffer_id;

	/// @override
	static buffer_destroy = function(){
		if(__buffer_delete)
			buffer_delete(__buffer_id);
	}
}

function __save_buffer_compress_async_data (async_id, filename, buffer, buffer_compressed, callbackDone, callbackArgs, deleteBuffer) : __buffer_async_data (async_id, filename, buffer, callbackDone, callbackArgs, deleteBuffer) constructor {
	__buffer_compressed = buffer_compressed;
	
	// @override - Delete the load compressed buffer on finish
	static buffer_destroy = function(){
		buffer_delete(__buffer_compressed);
		if(__buffer_delete)
			buffer_delete(__buffer_id);
	}
}

function __load_buffer_compress_async_data (async_id, filename, buffer, callbackDone, callbackArgs, deleteBuffer) : __save_buffer_compress_async_data (async_id, filename, buffer, noone, callbackDone, callbackArgs, deleteBuffer) constructor {
	
	// @override - Descompress the buffer before passing it on the callback
	static execute = function(struct_self = self){
		__buffer_compressed = __buffer_id;
		__buffer_id = buffer_decompress(__buffer_id);
		__callback_done(struct_self);
		buffer_destroy();
	}
}

#endregion

/// @desc With this function you will handle the async save / load events. Put this on Async - Save/Load event on an persistent object
/// @return N/A
function async_save_load_watcher(){
	
	/// CHECK ASYNC LOAD
	var _id = async_load[? "id"];
	if(_id == undefined) return;
	
	/// CHECK IF ASYNC LOAD IS INSIDE OF THE SAVE LOAD MAP
	var _struct = global.async_save_load_map[? _id];
	if(_struct == undefined) return;
	
	/// RUN ASYNC EVENT CALLBACK -> SPECTS A 
	_struct.set_async_event_status(async_load[? "status"]);
	_struct.execute(_struct);
		
	ds_map_delete(global.async_save_load_map, _id);
}
