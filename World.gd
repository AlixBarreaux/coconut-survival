extends Node2D


# --------------------------    DECLARE VARIABLES     --------------------------

# ----------------------------    RUN THE CODE     -----------------------------

func _ready() -> void:
	Events.connect("game_over", self, "on_game_over")

func _physics_process(_delta : float) -> void:
	if Input.is_action_just_pressed("build_spike"):
		print("Spike button!")
		build_spike()
	
	if Input.is_action_just_pressed("build_wall"):
		print("Wall button!")
		build_wall()

# --------------------------    DECLARE FUNCTIONS     --------------------------

func on_game_over() -> void:
	for node in self.get_children():
		node.queue_free()











export var required_stone_to_build_spike : int = 10
export var required_wood_to_build_wall : int = 10

export var stone_cost = 10
export var wood_cost = 10

func build_spike() -> void:
	if $Creatures/Players/Player.stone_amount >= required_stone_to_build_spike:
		spawn_spike()
	else:
		print("You do not have enough stone to build the spike!")

const SPIKE_PATH : String = "res://Buildings/Spike.tscn"
const SPIKE_PRELOAD = preload(SPIKE_PATH)

func spawn_spike() -> void:
	var spike_instance = SPIKE_PRELOAD.instance()
	if $Creatures/Players/Player/Sprite.is_flipped_h() == true:
		spike_instance.global_position = $Creatures/Players/Player/BuildingSlots/BuildingSlotRight.global_position
		
	else:
		spike_instance.global_position = $Creatures/Players/Player/BuildingSlots/BuildingSlotLeft.global_position
	self.add_child(spike_instance)
	
	$Creatures/Players/Player.deplete_stone_amount(stone_cost)



func build_wall() -> void:
	if $Creatures/Players/Player.wood_amount >= required_wood_to_build_wall:
		spawn_wall()
	else:
		print("You do not have enough wood to build the wall!")

const WALL_PATH : String = "res://Buildings/Wall.tscn"
const WALL_PRELOAD = preload(WALL_PATH)

func spawn_wall() -> void:
	var wall_instance = WALL_PRELOAD.instance()
	if $Creatures/Players/Player/Sprite.is_flipped_h() == true:
		wall_instance.global_position = $Creatures/Players/Player/BuildingSlots/BuildingSlotRight.global_position
		
	else:
		wall_instance.global_position = $Creatures/Players/Player/BuildingSlots/BuildingSlotLeft.global_position
	self.add_child(wall_instance)
	
	$Creatures/Players/Player.deplete_wood_amount(wood_cost)
