/// This functions exists because of an GAME MAKER THING 

/// When saving or loading asyncronous data, with will look for a default folder on the OS.
/// Using async functions it will add "default/" to filepath, but in not all cases 
/// Like file_exists(file_name) will not add the "default/", so this functions will add the "default/" 
/// case it needs

#macro ASYNC_DEFAULT_FILE_PATH "default/"



/// @desc With this function you will add the "default/" on the given file name path case it needs
/// @param {String} fileName The file name path
/// @return {String} The final file name path.
function filename_add_default(fileName){
	
	// Case fileName already have the "default/" on it, leave 
	if(string_pos(ASYNC_DEFAULT_FILE_PATH, fileName) > 0) 
		return fileName;
	
	// Check if have to add the "default/" to the fileName 
	switch(os_type){
		case os_windows:
		case os_linux:
		case os_macosx:
		case os_operagx:
		case os_unknown:	
			fileName = ASYNC_DEFAULT_FILE_PATH + fileName;
		break;
	}
	
	return fileName;
}

function filename_remove_default(filename){
	var _pos = string_pos(ASYNC_DEFAULT_FILE_PATH, filename);
	
	if(_pos <= 0 || _pos > 1) 
		return filename;
	
	filename = string_delete(filename, 1, string_length(ASYNC_DEFAULT_FILE_PATH));
	return filename;
}


/// @desc With this function it will check if the given file exists. Add default/ case it needs
/// @param {String} fileName The file name path
/// @return {Bool} A flag if the file exists or not
function file_exists_default(filename){
	filename = filename_add_default(filename);
	return file_exists(filename);
}

/// @desc With this function you will try to delete a file. Add default/ case it needs
/// @param {String} fileName The file name path
/// @return N/A
function file_delete_default(filename){
	filename = filename_add_default(filename);
	if(file_exists(filename))
		file_delete(filename);
}

/// @desc With this funcion you can rename the given file to a new given name
/// @param {String} old_name The filename path to be changed
/// @param {String} new_name The filename new path name
/// @return N/A
function file_rename_default(old_name, new_name){
	old_name = filename_add_default(old_name);
	if(file_exists(old_name)){
		file_rename(old_name, filename_add_default(new_name) );
	}
}

/// @desc With this funcion you can rename the given file to a new given name
/// @param {String} file_to_copy The filename to copy from.
/// @param {String} copy_filename The filename to copy to.
/// @return {String} The new copy filename path or undefined case the file to copy doesn`t exists 
function file_copy_default(file_to_copy, copy_filename){
	file_to_copy = filename_add_default(file_to_copy);
	if(file_exists(file_to_copy)){
		file_copy(file_to_copy, filename_add_default(copy_filename));
		return file_to_copy
	}
	
	return undefined;
}

/// @desc With this function you can add default to a filename case it's a browser. 
/// Use this for async- save/load functions when the target is a browser. The GML doen't add default/ automatically case it's browser.
/// @param {String} filename The filename to check.
/// @return {String} The filename with default/ case it needs
function filename_default_browser(filename){
	
	if(string_pos(ASYNC_DEFAULT_FILE_PATH, fileName) == 1) 
		return fileName;
		
	if(	os_browser != browser_not_a_browser ){ 
		filename = ASYNC_DEFAULT_FILE_PATH + filename;
	}
		
	return filename;
}
