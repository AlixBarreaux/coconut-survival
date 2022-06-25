extends RigidBody2D


# --------------------------    DECLARE VARIABLES     --------------------------
var health_replenish_value setget , get_health_replenish_value

var random_health_replenish_value = RandomNumberGenerator.new()
export var random_health_replenish_value_min_range : int = 5
export var random_health_replenish_value_max_range : int = 10

# ----------------------------    RUN THE CODE     -----------------------------

func _ready() -> void:
	randomize_health_replenish_value()


# --------------------------    DECLARE FUNCTIONS     --------------------------

func randomize_health_replenish_value() -> void:
	random_health_replenish_value.randomize()
	health_replenish_value = random_health_replenish_value.randi_range(random_health_replenish_value_min_range, random_health_replenish_value_max_range)


func get_health_replenish_value() -> int:
	return health_replenish_value
