class_name PauseMenu
extends Control


# ----------------- DECLARE VARIABLES -----------------

onready var first_element_to_focus: Button = $Panel/VBoxContainer/ResumeButton

var main_menu_scene_path: String = "res://GUI/Main Menu/MainMenu.tscn"

# ----------------- RUN CODE -----------------


func _ready() -> void:
	self.hide()
	return


func _unhandled_key_input(_event: InputEventKey) -> void:
	if Input.is_action_just_pressed("pause_game"):
		self.visible = !self.visible


# ----------------- DECLARE FUNCTIONS -----------------


func _on_ResumeButton_pressed() -> void:
	self.hide()
	return


func _on_QuitToMainMenuButton_pressed() -> void:
#	print("Quit to main menu button clicked!")
	get_tree().paused = false
	get_tree().change_scene(main_menu_scene_path)
	return


func _on_QuiToDesktopButton_pressed() -> void:
	get_tree().quit()
	return


func _on_visibility_changed() -> void:
	if self.visible:
		first_element_to_focus.grab_focus()
		get_tree().paused = true
	else:
		first_element_to_focus.release_focus()
		get_tree().paused = false
	return
