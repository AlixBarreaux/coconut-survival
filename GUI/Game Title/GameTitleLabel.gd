class_name GameTitleLabel
extends Label


# ----------------- DECLARE VARIABLES -----------------



# ----------------- RUN CODE -----------------


func _ready() -> void:
	self.text = ProjectSettings.get("application/config/name")
	return


# ----------------- DECLARE FUNCTIONS -----------------

