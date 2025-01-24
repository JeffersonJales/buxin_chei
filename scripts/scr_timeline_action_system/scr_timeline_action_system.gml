#macro TIMELINE_INDEX_UNDEFINED -1

global.timeline_action = {}

function timeline_action_start(timeline, data = undefined, loop = false){
	var _inst = instance_create(obj_timeline_action);
	
	global.timeline_action[$ timeline_get_name(timeline)] = _inst;
	_inst.setup_timeline_object(timeline, data);
	_inst.timeline_loop = loop;
	
	mailpost_delivery(MESSAGE_TIMELINE_ACTION_START, timeline);
	return _inst;
}

function timeline_action_stop(timeline){
	var _inst = global.timeline_action[$ timeline_get_name(timeline)];
	if(_inst != undefined) with(_inst) __timeline_action_stop();
}

function __timeline_action_stop(){
	mailpost_delivery(MESSAGE_TIMELINE_ACTION_END, timeline_index);
	variable_struct_remove(global.timeline_action, timeline_name);
	instance_destroy();
}