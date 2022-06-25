extends AudioStreamPlayer


# --------------------------    DECLARE VARIABLES     --------------------------

# ----------------------------    RUN THE CODE     -----------------------------

func _ready() -> void:
	pass

func _physics_process(delta : float) -> void:
	pass

# --------------------------    DECLARE FUNCTIONS     --------------------------



func _on_Music_finished():
	self.play()
