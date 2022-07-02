extends Node


# --------------------------    DECLARE VARIABLES     --------------------------

export onready var spawn_positions : PoolVector2Array = [$SpawnPointLeft.global_position, $SpawnPointRight.global_position]

const ENEMY_PATH : String = "res://Creatures/Enemies/Flame/Flame.tscn"
const ENEMY_PRELOAD = preload(ENEMY_PATH)


# ----------------------------    RUN THE CODE     -----------------------------

func _ready() -> void:
	Events.connect("spawn_enemy", self, "spawn_enemies")


# --------------------------    DECLARE FUNCTIONS     --------------------------

func spawn_enemies(side : int) -> void:
	var enemy_instance = ENEMY_PRELOAD.instance()
	if side == 0:
#		print("The enemy in node Enemies will spawn left!")
		enemy_instance.global_position = spawn_positions[0]
		# Move right
		enemy_instance.current_direction = 1
	else:
#		print("The enemy in node Enemies will spawn right!")
		enemy_instance.global_position = spawn_positions[1]
		# Move left
		enemy_instance.current_direction = 0



	self.add_child(enemy_instance)
#	print(enemy_instance)


#	self.add_child(enemy)
