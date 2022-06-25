extends StaticBody2D


# --------------------------    DECLARE VARIABLES     --------------------------

export var current_health : int = 50

# ----------------------------    RUN THE CODE     -----------------------------

func _ready() -> void:
	Events.connect("damage_building", self, "deplete_current_health")

# --------------------------    DECLARE FUNCTIONS     --------------------------

func deplete_current_health(value : int) -> void:
	current_health -= value
	check_if_alive()
	print("Wall ", self.name, " took damage!")


func check_if_alive() -> void:
	if current_health <= 0:
		die()


func die() -> void:
	Events.emit_signal("on_wall_destroyed")
	self.queue_free()


func _on_SelfDestroyTimer_timeout():
	die()
