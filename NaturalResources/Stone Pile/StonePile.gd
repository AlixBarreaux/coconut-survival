extends StaticBody2D


# --------------------------    DECLARE VARIABLES     --------------------------
var current_health setget set_current_health, get_current_health
export var max_health : int = 1

var random_max_health_generator = RandomNumberGenerator.new()
export var random_max_health_generator_min_range : int = 15
export var random_max_health_generator_max_range : int = 20

# ----------------------------    RUN THE CODE     -----------------------------

func _ready() -> void:
#	Events.connect("stone_pile_mined", self, "on_stone_pile_mined")
	
	set_randomized_max_health()
	set_current_health(max_health)
	check_if_alive()


# --------------------------    DECLARE FUNCTIONS     --------------------------
func set_randomized_max_health() -> void:
	random_max_health_generator.randomize()
	max_health = random_max_health_generator.randi_range(random_max_health_generator_min_range, random_max_health_generator_max_range)


func set_current_health(value : int) -> void:
	current_health = value


func get_current_health() -> int:
	return current_health


#var alive : bool = true
func check_if_alive() -> void:
	if current_health <= 0:
		die()

func on_stone_pile_mined() -> void:
	self.current_health -= 1
	check_if_alive()


func die() -> void:
	self.queue_free()


func _on_NaturalResourceDetector_area_entered(area : Area2D) -> Area2D:
	print(self.name, " collided with a natural resource: ", area.name, " and is now deleted! See StonePile Scene!")
	self.queue_free()
	return area
