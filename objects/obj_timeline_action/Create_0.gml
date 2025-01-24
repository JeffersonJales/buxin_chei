/// @desc 
timeline_name = "";
timeline_data = undefined;
timeline_lenght = 0;

setup_timeline_object = function(timeline, data){
	timeline_name = timeline_get_name(timeline);
	timeline_data = data;
	timeline_lenght = timeline_max_moment(timeline)
	timeline_index = timeline;
	timeline_running = true;
}