extends Node


# --------------------------    DECLARE VARIABLES     --------------------------

export var time_stamps : PoolIntArray = [20, 15, 10, 5]
var waves_counter : int = -1
var current_index = 0

# ----------------------------    RUN THE CODE     -----------------------------

func _ready() -> void:
	modify_time_stamps()

# --------------------------    DECLARE FUNCTIONS     --------------------------

func modify_time_stamps() -> void:
	print("Spawning enemy!")
	waves_counter += 1
	if current_index >= time_stamps.size():
			current_index -= 1
	
	if waves_counter <= 4:
		$Timer.set_wait_time(time_stamps[current_index])
		$Timer.start()
		print("Waves counter: ", waves_counter)
	else:
		waves_counter = 0
		if current_index <= time_stamps.size():
			current_index += 1
			print("current_index <= time_stamps.size() ! current_index")
			modify_time_stamps()


var random_spawn_side = RandomNumberGenerator.new()
var spawn_side : int = 0
func choose_random_spawn_side() -> void:
	random_spawn_side.randomize()
	spawn_side = random_spawn_side.randi_range(0, 1)

func _on_Timer_timeout() -> void:
	$Timer.stop()
	choose_random_spawn_side()
	print("Enemy spawning at side: ", spawn_side)
	Events.emit_signal("spawn_enemy", spawn_side)
	modify_time_stamps()
