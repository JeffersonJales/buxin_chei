/// @description Ir até a lixeira e se destruir
if(instance_exists(obj_lixeira)){
	var inst = instance_find(obj_lixeira, 0);
	TweenEasyScale(image_xscale, image_yscale, image_xscale - 0.2, image_yscale - 0.2, 0, 30, EaseLinear, 0);
	TweenEasyFade(image_alpha, image_alpha - 0.25, 0, 30, EaseLinear, 0);
	var t = TweenEasyMove(x, y, inst.x, inst.y, 0, 30, EaseInBack, 0);
	TweenAddCallback(t, TWEEN_EV_FINISH, id, function(){
		sfx_play_simple(sfx_trash);
		instance_destroy();
	});
}
else 
	instance_destroy()