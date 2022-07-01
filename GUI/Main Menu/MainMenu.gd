extends Control


# --------------------------    DECLARE VARIABLES     --------------------------

onready var first_button_to_focus: Button = $MainMenuButtonsContainer/Play

# ----------------------------    RUN THE CODE     -----------------------------

# --------------------------    DECLARE FUNCTIONS     --------------------------

func _ready() -> void:
	SceneLoader.current_scene = self
	self.initialize()


func initialize() -> void:
	first_button_to_focus.grab_focus()
	return


func _on_Play_pressed() -> void:
	SceneLoader.current_scene = self
	SceneLoader.change_scene_to("res://Main.tscn")


func _on_Quit_pressed() -> void:
	self.get_tree().quit()


func _on_HowToPlay_pressed() -> void:
	for node in get_children():
		node.hide()
	$ColorRect.show()
	$Label.show()
	$Label/GotIt.grab_focus()


func _on_GotIt_pressed():
	for node in get_children():
		node.show()
	$Label.hide()
	$MainMenuButtonsContainer/Play.grab_focus()
