extends Node


# --------------------------    DECLARE VARIABLES     --------------------------

var edges : PoolIntArray = [-9000, 11000]

var random_cloud_amount_generator = RandomNumberGenerator.new()

export var min_cloud_amount = 30
export var max_cloud_amount = 50

var cloud_amount : int = 0



# ----------------------------    RUN THE CODE     -----------------------------

func _ready() -> void:
	generate_clouds()

# --------------------------    DECLARE FUNCTIONS     --------------------------

const CLOUD_PATH : String = "res://Assets/Textures/Ambient/Cloud.tscn"
const CLOUD_PRELOAD = preload(CLOUD_PATH)
var cloud_instance

func generate_clouds() -> void:
	random_cloud_amount_generator.randomize()
	cloud_amount = random_cloud_amount_generator.randi_range(min_cloud_amount, max_cloud_amount)

	for cloud in range (0, cloud_amount):
		cloud_instance = CLOUD_PRELOAD.instance()
		randomize_cloud_position()
		cloud_instance.global_position.x = random_position_x
		cloud_instance.global_position.y = random_position_y
		
		self.add_child(cloud_instance)

var position_x_randomizer = RandomNumberGenerator.new()
export var min_cloud_edge : int = -11000
export var max_cloud_edge : int = 11000
var random_position_x : int = 0

var position_y_randomizer = RandomNumberGenerator.new()
export var min_random_position_y : int = -700
export var max_random_position_y : int = -850
var random_position_y : int = 0



func randomize_cloud_position() -> void:
	position_x_randomizer.randomize()
	random_position_x = position_x_randomizer.randi_range(min_cloud_edge, max_cloud_edge)
	
	position_y_randomizer.randomize()
	random_position_y = position_y_randomizer.randi_range(min_random_position_y, max_random_position_y)
