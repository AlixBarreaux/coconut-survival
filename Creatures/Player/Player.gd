extends Creature

class_name Player

# --------------------------    DECLARE VARIABLES     --------------------------
export var wood_amount : int = 0
export var stone_amount : int = 0

# Movements
var is_moving : bool = false
var can_use_tool : bool = true

# ----------------------------    RUN THE CODE     -----------------------------

func _ready() -> void:
	Events.connect("tree_cut", self, "on_tree_cut")
	Events.connect("stone_pile_mined", self, "on_stone_pile_mined")
	Events.connect("damage_player", self, "deplete_current_health")
	Events.connect("update_time_survived", self, "on_update_time_survived")
	Events.connect("faucet_animation_started", self, "set_tool_mode_to_false")
	Events.connect("faucet_animation_finished", self, "set_tool_mode_to_true")


	# Set the creature's health to max health
	set_current_health(max_health)
	
	self.rotate_tools_to_left()

func set_tool_mode_to_false() -> void:
	can_use_tool = false


func set_tool_mode_to_true() -> void:
	can_use_tool = true



func _physics_process(delta : float) -> void:
	get_inputs()
	check_if_player_is_moving()
	if self.is_moving:
		disable_tools()
	else:
		if self.can_use_tool:
			enable_tools()

# --------------------------    DECLARE FUNCTIONS     --------------------------

func disable_tools() -> void:
	# Disable Axe
	$Sprite/HeldItems/Axe.set_monitoring(false)
	$Sprite/HeldItems/Axe.set_monitorable(false)
	$Sprite/HeldItems/Axe.set_physics_process(false)
	$Sprite/HeldItems/Axe.set_process(false)

	# Disable Pickaxe
	$Sprite/HeldItems/Pickaxe.set_monitoring(false)
	$Sprite/HeldItems/Pickaxe.set_monitorable(false)
	$Sprite/HeldItems/Pickaxe.set_physics_process(false)
	$Sprite/HeldItems/Pickaxe.set_process(false)


func enable_tools() -> void:
	# Enable Axe
	$Sprite/HeldItems/Axe.set_monitoring(true)
	$Sprite/HeldItems/Axe.set_monitorable(true)
	$Sprite/HeldItems/Axe.set_physics_process(true)
	$Sprite/HeldItems/Axe.set_process(true)

	# Enable Pickaxe
	$Sprite/HeldItems/Pickaxe.set_monitoring(true)
	$Sprite/HeldItems/Pickaxe.set_monitorable(true)
	$Sprite/HeldItems/Pickaxe.set_physics_process(true)
	$Sprite/HeldItems/Pickaxe.set_process(true)


# Movements
var tools_animations : Array = ["rotate", "rotate_right"]
var selected_tool_animation

func get_movement_inputs() -> void:
	velocity = Vector2()
	if Input.is_action_pressed("move_left"):
		move_left()
		rotate_player_to_left()
		rotate_tools_to_left()
		$AnimationPlayer.play("move")



	if Input.is_action_pressed("move_right"):
		move_right()
		self.flip_sprite_horizontally(true)
		rotate_tools_to_right()
		$AnimationPlayer.play("move")

	velocity = velocity.normalized() * current_speed

var is_player_flipped : bool

func rotate_player_to_left() -> void:
	self.flip_sprite_horizontally(false)
	is_player_flipped = false


func rotate_player_to_right() -> void:
	self.flip_sprite_horizontally(true)
	is_player_flipped = true


# Flip items and self left
func rotate_tools_to_left() -> void:
	for item in $Sprite/HeldItems.get_children():
			item.position = $HeldItemsPositions/LeftSlot.get_position()
			item.get_child(1).position = $HeldItemsPositions/LeftSlot.get_position()
			selected_tool_animation = tools_animations[0]
			Events.emit_signal("tool_animation_selected", selected_tool_animation)
#			print("Selected animation: ", selected_tool_animation)


# Flip items and self right
func rotate_tools_to_right() -> void:
	for item in $Sprite/HeldItems.get_children():
			item.position = $HeldItemsPositions/RightSlot.get_position()
			item.get_child(1).position = $HeldItemsPositions/RightSlot.get_position()
			selected_tool_animation = tools_animations[1]
			Events.emit_signal("tool_animation_selected", selected_tool_animation)
#			print("Selected animation: ", selected_tool_animation)


func get_action_inputs() -> void:
	if Input.is_action_just_pressed("attack"):
		$Sprite/HeldItems/Faucet.attack()
		disable_tools()


func get_inputs() -> void:
	get_movement_inputs()
	get_action_inputs()


func check_if_player_is_moving() -> void:
	if velocity != Vector2(0, 0):
		is_moving = true
	else:
		is_moving = false


# Health Management (Override creature's function)

func set_current_health(value : int) -> void:
	current_health = value
	$CanvasLayer/Control/HealthBar.value = current_health


func replenish_current_health(value : int) -> void:
	current_health += value
	$CanvasLayer/Control/HealthBar.value = current_health

	# Clamp between 0 and max_health so that the player doesn't
	# have more current_health than max_health
	current_health = clamp(current_health, 0, max_health)


func deplete_current_health(value : int) -> void:
	current_health -= value
	$CanvasLayer/Control/HealthBar.value = current_health
#	print("PLAYER HURT!")

	# Clamp between 0 and max_health so that the player doesn't
	# have less current_health than 0
	current_health = clamp(current_health, 0, max_health)

	check_if_player_dead()


func check_if_player_dead() -> void:
	if current_health <= 0:
		die()
		set_physics_process(false)
	else:
		$AnimationPlayer.play("take_damage")


func die() -> void:
#	print("The player is dead!")
	$AnimationPlayer.play("die")
	yield(get_tree().create_timer(3.5), "timeout")
	Events.emit_signal("send_score", time_survived)
	self.queue_free()
	Events.emit_signal("game_over")


# Resources Management

func on_tree_cut() -> void:
	wood_amount += 1
	$CanvasLayer/Control/ItemsContainer/WoodContainer/WoodAmount.text = str(wood_amount)


func on_stone_pile_mined() -> void:
	stone_amount += 1
	$CanvasLayer/Control/ItemsContainer/StoneContainer/StoneAmount.text = str(stone_amount)


# Time Management
var time_survived : float = 0
func on_update_time_survived(time : float) -> void:
	time_survived = time
	$CanvasLayer/Control/TimeSurvived.text = str(time)


func _on_ItemPickupZone_body_entered(body : PhysicsBody2D) -> void:
	if "Coconut" in body.name:
#		print("Coconut picked up!")
		if self.current_health >= self.max_health:
#			print("Coconut not picked since the health bar is full")
			return
		$Coconut.play()
		# Replenish some health
		replenish_current_health(body.get_health_replenish_value())
#		print("Current health is now: ", current_health)
		body.queue_free()
	else:
#		print("Another item has been picked up in player: ", body.name)
		pass


func deplete_stone_amount(value : int) -> void:
	stone_amount -= value
	$CanvasLayer/Control/ItemsContainer/StoneContainer/StoneAmount.text = str(stone_amount)


func deplete_wood_amount(value : int) -> void:
	wood_amount -= value
	$CanvasLayer/Control/ItemsContainer/WoodContainer/WoodAmount.text = str(wood_amount)
