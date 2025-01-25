/// @description Destruir icones
array_foreach(icones, function(item) {
	instance_destroy_exists(item);
})