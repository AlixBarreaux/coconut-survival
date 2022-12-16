extends RigidBody2D
class_name Coconut


# --------------------------    DECLARE VARIABLES     --------------------------


var health_replenish_value setget , get_health_replenish_value

var random_health_replenish_value = RandomNumberGenerator.new()
export var random_health_replenish_value_min_range : int = 5
export var random_health_replenish_value_max_range : int = 10


# Node References
onready var visibility_notifier_2d: VisibilityNotifier2D = $VisibilityEnabler2D


# ----------------------------    RUN THE CODE     -----------------------------


func _ready() -> void:
	self._initialize_signals()
	randomize_health_replenish_value()


# --------------------------    DECLARE FUNCTIONS     --------------------------

func _physics_process(delta: float) -> void:
	apply_central_impulse(Vector2(-1.0, 0.0))

func _initialize_signals() -> void:
	visibility_notifier_2d.connect("screen_entered", self, "on_visibility_notifier_2d_screen_entered")
	visibility_notifier_2d.connect("screen_exited", self, "on_visibility_notifier_2d_screen_exited")
	return


func on_visibility_notifier_2d_screen_entered() -> void:
	self.show()
	print("Show ", self.name)
	return


func on_visibility_notifier_2d_screen_exited() -> void:
	self.hide()
	print("Hide ", self.name)
	return


func randomize_health_replenish_value() -> void:
	random_health_replenish_value.randomize()
	health_replenish_value = random_health_replenish_value.randi_range(random_health_replenish_value_min_range, random_health_replenish_value_max_range)


func get_health_replenish_value() -> int:
	return health_replenish_value
