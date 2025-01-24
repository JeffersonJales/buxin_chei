function ds_list_delete_search(list, value){
	if(ds_exists(list, ds_type_list)){
		var pos = ds_list_find_index(list, value);
		if(pos >= 0) ds_list_delete(list, pos);
	}
}