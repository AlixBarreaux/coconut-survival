extends Creature

class_name Flame
"""
This script controls the enemy flame.
The hit timer wait time defines the time it takes to damage the player again
when he is in the flame area.
A signal damage_player with the argument current_damage is emitted to damage the
player in the Events singleton. The player is listening for this signal and
receives the argument and substracts the current health by this argument.
"""
# --------------------------    DECLARE VARIABLES     --------------------------
enum MOVE_DIRECTION {LEFT = 0, RIGHT = 1}

export (MOVE_DIRECTION) var current_direction = MOVE_DIRECTION.LEFT

# Damage min and max that can be taken by the entity receiving it
export var random_current_damage_generator_min_range : int = 1
export var random_current_damage_generator_max_range : int = 5

# Damage
var current_damage : int setget set_current_damage, get_current_damage
var random_current_damage_generator = RandomNumberGenerator.new()

# ----------------------------    RUN THE CODE     -----------------------------

func _ready() -> void:
	$HitTimer.stop()
	set_current_health(max_health)
	$AnimationPlayer.play("move")
	Events.connect("damage_flame", self, "deplete_current_health")

	Events.connect("on_wall_destroyed", self, "stop_building_hit_timer")
	Events.connect("on_spike_destroyed", self, "stop_building_hit_timer")

func _physics_process(delta : float) -> void:
	velocity = Vector2(0, 0)
	choose_move_direction()
	velocity = velocity.normalized() * current_speed

# --------------------------    DECLARE FUNCTIONS     --------------------------

# Choose which direction the enemy will move to indefinitely
func choose_move_direction() -> void:
	current_direction = MOVE_DIRECTION.values()[current_direction]

	match current_direction:
		MOVE_DIRECTION.LEFT:
			move_left()
			$Sprite.set_flip_h(false)
		MOVE_DIRECTION.RIGHT:
			move_right()
			$Sprite.set_flip_h(true)
		_:
			printerr("(!) ERROR: No move direction selected in Flame.gd!")


func move_left() -> void:
	velocity.x -= 1


func move_right() -> void:
	velocity.x += 1



func randomize_current_damage() -> void:
	random_current_damage_generator.randomize()
	current_damage = random_current_damage_generator.randi_range(random_current_damage_generator_min_range, random_current_damage_generator_max_range)


# Damage Management
func set_current_damage(value : int) -> void:
	current_damage = value


func get_current_damage() -> int:
	return current_damage


func damage_entity() -> void:
	randomize_current_damage()
	Events.emit_signal("damage_player", current_damage)


# Health Management
func deplete_current_health(value : int) -> void:
	current_health -= value
	$AnimationPlayer.play("take_damage")
	check_if_alive()

func check_if_alive() -> void:
	if current_health <= 0:
		die()


func die() -> void:
	self.queue_free()
	Events.emit_signal("flame_died")


func _on_HitBox_body_entered(body : PhysicsBody2D) -> PhysicsBody2D:
	damage_entity()
	$HitTimer.start()
	return body


func _on_HitTimer_timeout():
	damage_entity()
	print("FIRE: TAKE THAT!")


func _on_HitBox_body_exited(body : PhysicsBody2D) -> PhysicsBody2D:
	$HitTimer.stop()
	return body



# Attack building
func _on_BuildingHitTimer_timeout() -> void:
	randomize_current_damage()
	print("Building hit timer timeout! Damage to be sent: ", current_damage)

#	Events.emit_signal("damage_building", current_damage)


func _on_BuildingDetector_body_entered(body : PhysicsBody2D) -> PhysicsBody2D:
	print("FLAME AREA HAS BEEN ENTERED: ", body.name)
	if not "Ground" in body.name:
		$BuildingHitTimer.start()
	return body


func _on_BuildingDetector_body_exited(body : PhysicsBody2D) -> PhysicsBody2D:
	print("FLAME AREA HAS BEEN EXITED: ", body.name)
	$BuildingHitTimer.stop()
	return body

var buildings_in_range : Array = []
# Spikes
func _on_BuildingDetector_area_entered(area : Area2D) -> Area2D:
	if not "aucet" in area.name:
		buildings_in_range.append(area)
		print("An Area2D entered flame building detector: ", area.name)
		area.deplete_current_health(5)
		$HurtTimer.start()
	return area

var body_to_remove
func _on_BuildingDetector_area_exited(area : Area2D) -> Area2D:
	if not "aucet" in area.name:
		if area in buildings_in_range:
			body_to_remove = buildings_in_range.find(area)
			buildings_in_range.remove(body_to_remove)

		print("An Area2D exited flame building detector: ", area.name)
		$HurtTimer.stop()
	return area


func stop_building_hit_timer() -> void:
	$BuildingHitTimer.stop()


func _on_HurtTimer_timeout():
	self.deplete_current_health(8)



