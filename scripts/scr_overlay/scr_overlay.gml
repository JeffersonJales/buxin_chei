
#region How It Works
/*
	Esse sistema funciona como o PREFAB de GUIs para o jogo.
	Em uma room do jogo, preferencialmente a inicial, montar como vão ser as interfaces do jogo de forma VISUAL. 
	Colocando os objetos na room e definindo seu posicionamento na tela, assim como sua posição e ancoragem (Variables)
	Essas informações serão salvas em global.overlay_data.overlay_gui_data, onde 
	Key = Nome da Layer, Valor = Um Array de __overlay_gui_instance_data contendo as informações sobre o objeto.
	
	Nessa room, deve ser chamado o script overlay_system_init. Ele irá procurar por todas as layers que iniciam com OVERLAY_LAYER_NAME_PREFIX.
	Em outra room, para instanciar essas internfaces, podem ser usados 2 funções
	- overlay_layer_create -> Apena cria a internface e posiciona os objetos em cena 
	- overlay_add -> Cria uma layer SOBREPOSTA a camada de layer atual. Fazendo tudo atrás dele ficar em desfoque, focando apenas na layer atual. 
		Pode ser adicionada N layers em cima dessa
		
	Para remover layers, temos: 
	- overlay_layer_destroy - Destroi uma layer manualmente, deve passar o nome dela
	- overlay_delete - Deleta a OVERLAYER atual, reativando a anterior
	
	SEMPRE, ao fim de uma room, deve ser resetado suas informações
	
	Esse sistema usa como base os FILHOS do objeto obj_ui_element
*/


#endregion

#macro OVERLAY_OBJECT_FADE obj_overlay_fade	/// The object will instantiate and do the black screen
#macro OVERLAY_OBJECT_BUTTON obj_button_gui	/// Must be a child of the button on GUI
#macro OVERLAY_DEPTH_START -10							/// The Start Depth of the overlay system in the room
#macro OVERLAY_INCREASE_ON_NEW -10					/// The amount of Depth it will gain for every overlayer created
#macro OVERLAY_BG_COLOR #CCCCCC							/// Te Background Color

#macro OVERLAY_LAYER_NAME_PREFIX "Overlay_"		/// The Overlay layer name prefix (See rm_boot_game to see)

/// The macro name for all overlay layers created (See rm_boot_game)
#macro OVERLAY_LAYER_PRESS_START "Overlay_Press_Start"
#macro OVERLAY_LAYER_MAIN_MENU "Overlay_Main_Menu"
#macro OVERLAY_LAYER_FIRST_TIME "Overlay_Game_First_Time"
#macro OVERLAY_LAYER_CHOOSE_STAGE "Overlay_Choose_Stage"
#macro OVERLAY_LAYER_GAME_HUD "Overlay_Game_Hud"
#macro OVERLAY_LAYER_PAUSE "Overlay_Game_Pause"
#macro OVERLAY_LAYER_END_GAME "Overlay_Game_End"
#macro OVERLAY_LAYER_GAME_QUIT "Overlay_Game_Quit"

#macro OVERLAY_LAYER_OPTIONS_AUDIO "Overlay_Options_Audio"
#macro OVERLAY_LAYER_OPTIONS_LANGUAGE "Overlay_Options_Language"

#macro OVERLAY_LAYER_FINISH_GAME "Overlay_Finish_Game"
#macro OVERLAY_LAYER_CREDITS "Overlay_Credits"


global.overlay_data = {
	actives : [],
	overlay_gui_data : {},
	overlay_data_by_name : {},
	depth : OVERLAY_DEPTH_START,
}

#region OVERLAY SYSTEM INIT

/// Init the overlay system. Call it from the room where all GUI Layers have this prefix in the name OVERLAY_LAYER_NAME_PREFIX
function overlay_system_init(){
	var _layers = layer_get_all();
	for(var i = 0; i < array_length(_layers); i++){
		var _name = layer_get_name(_layers[i]);
		if(string_pos(OVERLAY_LAYER_NAME_PREFIX, _name) > 0){
			global.overlay_data.overlay_gui_data[$ _name] = __overlay_gui_data(_layers[i]);
		}
	}
}

/// Will return an array with all instances data 
/// @return {Array.__overlay_gui_instance_data} 
function __overlay_gui_data(layer_id){
	var _insts = layer_instance_get_instances(layer_id);
	
	array_sort(_insts, function(el1, el2){
		return sign(el2.depth_priority - el1.depth_priority)
	})
	
	var _len = array_length(_insts);
	var _arr = array_create(_len);
	
	for(var i = 0; i < _len; i++){
		_arr[i] = new __overlay_gui_instance_data(_insts[i]);
		instance_destroy(_insts[i]);
	}
	
	return _arr;
}

/// The instance basic variables to pass through
function __overlay_gui_instance_data(instance) constructor {
	x = instance.x;
	y = instance.y;
	scale_x = instance.image_xscale;
	scale_y = instance.image_yscale;
	angle = instance.image_angle;
	object = instance.object_index;
	anchor = instance.anchor;
	is_button = object_is_ancestor(object, OVERLAY_OBJECT_BUTTON);

	static instantiate = function(layer_id){
		return instance_create_layer(x, y, layer_id, object, {
			image_xscale : scale_x, 
			image_yscale : scale_y,
			image_angle : angle,
			anchor : anchor
		});
	}
}

#endregion

#region OVERLAY SYSTEM FUNCTIONS 

/// Creates a new OVERLAYER. Creates a GUI layer "prefab" with the given overlay layer name. Also creates a background color to fade away the instances behind.
/// @return {Struct.__overlay_data}
function overlay_add(overlay_layer_name, deactive_layer = noone, bg_fade = 0.95, bg_color = OVERLAY_BG_COLOR){
	var _overlay_data = new __overlay_data(overlay_layer_name),	/// The overlay layer data all information about the layer
			_layer_id = layer_create(global.overlay_data.depth, overlay_layer_name);	/// The layer where will be placed the instances

	_overlay_data.layer_id = _layer_id;
	_overlay_data.set_disable_layer(deactive_layer);

	__overlay_instantiate_objects(overlay_layer_name, _overlay_data);
	
	_overlay_data.background_instance_id =	instance_create_layer(0, 0, _layer_id, OVERLAY_OBJECT_FADE, {
		image_alpha : bg_fade, image_blend : bg_color
	});
	
	__overlay_deactive_last_layer();
	
	global.overlay_data.depth += OVERLAY_INCREASE_ON_NEW;
	array_push(global.overlay_data.actives, _overlay_data);
	mailpost_delivery(MESSAGE_OVERLAYER_CREATE, _overlay_data);
	global.overlay_data.overlay_data_by_name[$ overlay_layer_name] = _overlay_data;

	return _overlay_data;
}	

/// Deletes the current active OVERLAYER. The last overlayer created by overlay_add
function overlay_delete(){
	var _last_overlay = array_last(global.overlay_data.actives);
	if(_last_overlay == undefined) return;

	mailpost_delivery(MESSAGE_OVERLAYER_DESTROY, _last_overlay);

	_last_overlay.set_disable_layer_visible(true);
	_last_overlay.destroy_layer_instances();
	
	array_delete(global.overlay_data.actives, array_length(global.overlay_data.actives) - 1, 1);
	
	var _last_overlay = array_last(global.overlay_data.actives);
	if(_last_overlay != undefined)
		_last_overlay.revive_buttons();
	else
		mailpost_delivery(MESSAGE_OVERLAYER_DESTROY_ALL);
}

/// Takes advantage of the overlay system to crease basic GUI layers with the given overlay layer name
/// @return {Struct.__overlay_data}
function overlay_layer_create(overlay_layer_name){
	var _overlay_data = new __overlay_data(overlay_layer_name),	/// The overlay layer data all information about the layer
			_layer_id = layer_create(global.overlay_data.depth, overlay_layer_name);	/// The layer where will be placed the instances

	_overlay_data.layer_id = _layer_id;
	__overlay_instantiate_objects(overlay_layer_name, _overlay_data);
	
	global.overlay_data.depth += OVERLAY_INCREASE_ON_NEW;
	mailpost_delivery(MESSAGE_LAYER_CREATE, _overlay_data);
	global.overlay_data.overlay_data_by_name[$ overlay_layer_name] = _overlay_data;
	
	return _overlay_data;
}

/// Takes advantage of the overlay system to destroy basic GUI layer with the given overlay layer name
function overlay_layer_destroy(overlay_name){
	var _overlay_data = global.overlay_data.overlay_data_by_name[$ overlay_name];
	if(_overlay_data == undefined) return;
	
	mailpost_delivery(MESSAGE_OVERLAYER_DESTROY, _overlay_data);
	_overlay_data.destroy_layer_instances();
}

function overlay_get_data(overlay_name){
	return global.overlay_data.overlay_data_by_name[$ overlay_name];
}

#region DONT TOUCH IT

/// Check if have already an overlay layer active to disable it
function __overlay_deactive_last_layer(){
	var _last_data = array_last(global.overlay_data.actives);
	if(_last_data != undefined) _last_data.kill_buttons();
}

/// Instantiate the objects of the given overlay layer and updating the overlay data 
function __overlay_instantiate_objects(overlay_layer_name, overlay_data){
	var _inst, _ldata, 
			_lid = overlay_data.layer_id,
			_gui_instances_data = global.overlay_data.overlay_gui_data[$ overlay_layer_name];	/// An Array with the gui layer objects information (see __overlay_gui_instance_data)

	/// From last to first for depth sorting purposes
	var _len = array_length(_gui_instances_data);
	for(var i = 0; i < _len; i++){
		//_ldata = _gui_instances_data[_len - i - 1];
		_ldata = _gui_instances_data[i];
		
		_inst = _ldata.instantiate(_lid);
		
		_inst.on_overlay_init();
		
		array_push(overlay_data.all_instances, _inst);
		if(_ldata.is_button) 
			array_push(overlay_data.all_button_instances, _inst);
		else
			array_push(overlay_data.all_other_instances, _inst);
	}
}

/// The overlay data. All information about the instances of the overlay system will be stored here
function __overlay_data(overlay_name) constructor{
	layer_id = noone;		/// The layer id where all those instances will be stored
	overlay_layer_name = overlay_name;	/// The overlay name reference.

	disabled_layer_id = noone;	/// The layer it disables when created
	background_instance_id = noone;	/// The black background instance id reference

	all_instances = [];	/// All layers in this layer
	all_other_instances = [];	/// All objects that are NOT buttons
	all_button_instances = [];	/// All buttons in the layer

	/// @func set_disable_layer
	/// When setting a disabled layer, it will try to disable all buttons from the given layer, also setting them to invisible
	static set_disable_layer = function(layer_id){
		if(layer_id == noone) return;
		if(!is_real(layer_id)) layer_id = layer_get_id(layer_id);
		
		disabled_layer_id = layer_id;
		set_disable_layer_visible(false);
	}
	
	/// @func set_disable_layer_visible 
	/// Toggle the visibility of the disabled layer (true - Visible + Button clickables)
	static set_disable_layer_visible = function(boolean){
		if(disabled_layer_id == noone) return;
		
		layer_set_visible(disabled_layer_id, boolean);
		if(boolean) 
			revive_buttons(disabled_layer_id);
		else
			kill_buttons(disabled_layer_id);
	}
	
	/// @func kill_buttons
	/// Kill all buttons of the given layer
	static kill_buttons = function(_layer = layer_id){
		var _elems = layer_instance_get_instances(_layer);
		for (var i = 0; i < array_length(_elems); ++i) {
			if(object_is_ancestor(_elems[i].object_index, OVERLAY_OBJECT_BUTTON)){
				_elems[i].button_kill();
			}
		}
	}
	
	/// @func revive_buttons 
	/// Revive all buttons of the given layer
	static revive_buttons = function(_layer = layer_id){
		var _elems = layer_instance_get_instances(_layer);
		for (var i = 0; i < array_length(_elems); ++i) {
			if(object_is_ancestor(_elems[i].object_index, OVERLAY_OBJECT_BUTTON)){
				_elems[i].button_revive();
			}
		}
	}
	
	/// @func destroy_layer_instances
	/// Destroy all instances of this overlay_data
	static destroy_layer_instances = function(){
		for(var i = 0; i < array_length(all_instances); i++){
			if(instance_exists(all_instances[i])) 
				all_instances[i].on_overlay_disable();
		}
		
		instance_destroy(background_instance_id);
	}
		
}

#endregion

#endregion

/// Call it when the room ends to reset some variables
function overlay_reset(){
	global.overlay_data.actives = [];
	global.overlay_data.overlay_data_by_name = {};
	global.overlay_data.depth = OVERLAY_DEPTH_START;
}
	