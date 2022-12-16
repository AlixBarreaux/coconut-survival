extends Node


# --------------------------    DECLARE VARIABLES     --------------------------



# ----------------------------    RUN THE CODE     -----------------------------


# --------------------------    DECLARE FUNCTIONS     --------------------------

var current_scene = null
var scene_to_load

func change_scene_to(scene : String) -> void:
	current_scene.queue_free()

	scene_to_load = load(scene)

	current_scene = scene_to_load.instance()


	self.add_child(current_scene)
