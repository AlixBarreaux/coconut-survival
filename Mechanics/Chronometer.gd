extends Node


# --------------------------    DECLARE VARIABLES     --------------------------
var time_survived : float = 0
# ----------------------------    RUN THE CODE     -----------------------------



# --------------------------    DECLARE FUNCTIONS     --------------------------

func add_second(value : int) -> void:
	time_survived += value
	Events.emit_signal("update_time_survived", time_survived)

func _on_Chronometer_timeout():
	add_second(1)
