extends HeldItem

class_name Faucet

# --------------------------    DECLARE VARIABLES     --------------------------

export var faucet_attack_value : int = 20

var can_attack : bool = true

# ----------------------------    RUN THE CODE     -----------------------------

func _ready() -> void:
	self.hide()
	Events.connect("tool_animation_selected", self, "choose_animation")

func _physics_process(delta : float) -> void:
	pass

# --------------------------    DECLARE FUNCTIONS     --------------------------

var choosen_animation : String
func choose_animation(animation_name : String) -> void:
	choosen_animation = animation_name

func attack() -> void:
	if can_attack:
		can_attack = false
		disable_other_items()
		
		
		
		self.show()
		$AnimationPlayer.play(choosen_animation)
#	else:
#		print("You cannot attack right now!")


func hide_item() -> void:
	self.hide()


# Block the other tools from being used when attacking
func disable_other_items() -> void:
	self.get_parent().get_child(0).set_monitoring(false)
	self.get_parent().get_child(1).set_monitoring(false)


# Re-enable the ability to use other tools
func enable_other_items() -> void:
	self.get_parent().get_child(0).set_monitoring(true)
	self.get_parent().get_child(1).set_monitoring(true)


func _on_AnimationPlayer_animation_finished(anim_name : String) -> void:
	self.hide_item()
	enable_other_items()
	if collided_bodies != []:
		collided_bodies[0].deplete_current_health(faucet_attack_value)
#	else:
#		print("Animation finished! Collided body is null!")
	can_attack = true
	Events.emit_signal("faucet_animation_finished")


func _on_AnimationPlayer_animation_started(anim_name):
	Events.emit_signal("faucet_animation_started")
#	if collided_bodies != []:
#		print("Animation started! Faucet collided with a physicsbody2D: ", collided_bodies[0].name)
#	else:
#		print("collided_bodies list is empty!")


# This var is temporary just to handle the body in these functions.
# It stores the current target.
var collided_bodies : Array
func _on_Faucet_body_entered(body : PhysicsBody2D) -> void:
	if not body in collided_bodies:
		collided_bodies.append(body)
#		print("Entered! Faucet collided with a physicsbody2D: ", body.name)
#		print("Collided bodies list: ", collided_bodies)


# Forget the body stored in collided_body
func _on_Faucet_body_exited(body : PhysicsBody2D) -> void:
	var body_to_remove
	if body in collided_bodies:
		body_to_remove = collided_bodies.find(body)
#		print("Body to remove: ", body_to_remove)
		collided_bodies.remove(body_to_remove)
#		print("List after removal: ", collided_bodies)
