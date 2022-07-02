extends KinematicBody2D

class_name Creature

# --------------------------    DECLARE VARIABLES     --------------------------

export var current_speed : int = 200
export var max_health : int = 100

# Movement
var velocity : Vector2 = Vector2(0, 0)

var current_health : int setget set_current_health, get_current_health


# ----------------------------    RUN THE CODE     -----------------------------

func _ready() -> void:
	pass


func _physics_process(_delta : float) -> void:
	# Move
	velocity = move_and_slide(velocity)
#	if velocity == Vector2(0, 0):
#		print(self.name, " : Velocity: ", velocity)

# --------------------------    DECLARE FUNCTIONS     --------------------------


func flip_sprite_horizontally(boolean : bool) -> void:
	$Sprite.set_flip_h(boolean)


func move_left() -> void:
	velocity.x -= 1
	


func move_right() -> void:
	velocity.x += 1


# Health Management
func set_current_health(value) -> void:
	current_health = value


func get_current_health() -> int:
	return current_health


func replenish_current_health(value : int) -> void:
	 current_health += value


func deplete_current_health(value : int) -> void:
	current_health -= value
