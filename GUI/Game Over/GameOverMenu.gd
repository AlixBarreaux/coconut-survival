extends Control


# --------------------------    DECLARE VARIABLES     --------------------------

# ----------------------------    RUN THE CODE     -----------------------------

func _ready() -> void:
	hide_menu()
	# Listens for the game over signal (player's death)
	Events.connect("game_over", self, "show_menu")
	Events.connect("send_score", self, "update_score")
	
	SceneLoader.current_scene = self

# --------------------------    DECLARE FUNCTIONS     --------------------------

func update_score(value : int) -> void:
	$LabelsContainer/Score.text = str(value)


func show_menu() -> void:
	self.show()


func hide_menu() -> void:
	self.hide()


func _on_PlayAgain_pressed():
	self.get_parent().queue_free()
	SceneLoader.change_scene_to("res://Main.tscn")


func _on_Quit_pressed():
	SceneLoader.change_scene_to("res://GUI/Main Menu/MainMenu.tscn")


