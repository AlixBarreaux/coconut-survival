extends HeldItem

class_name Pickaxe

# --------------------------    DECLARE VARIABLES     --------------------------

# ----------------------------    RUN THE CODE     -----------------------------

func _ready() -> void:
	self.hide()
	$Label.hide()
	Events.connect("tool_animation_selected", self, "choose_animation")
#	flip_horizontally()
	

# --------------------------    DECLARE FUNCTIONS     --------------------------

var choosen_animation : String
func choose_animation(animation_name : String) -> void:
	choosen_animation = animation_name


func _on_Pickaxe_body_entered(body : PhysicsBody2D) -> void:
#	print(body.name)
	if "StonePile" in body.name:
		self.show()
		$AnimationPlayer.play(choosen_animation)
		collided_body = body
#		print("Entered! Collided body: ", collided_body.name)


var collided_body
func _on_Pickaxe_body_exited(body : PhysicsBody2D) -> void:
		self.hide()
		$AnimationPlayer.stop()
		collided_body = -1
#		print("Exited! Body is now null.")


func _on_AnimationPlayer_animation_started(anim_name):
#	print("Pickaxe has started animation: ", anim_name)
	return anim_name


func _on_AnimationPlayer_animation_finished(anim_name):
#	print("Pickaxe finished animation: ", anim_name)
	$AnimationPlayer.play(choosen_animation)
	Events.emit_signal("stone_pile_mined")
	collided_body.on_stone_pile_mined()
	return anim_name
