class_name VersionLabel
extends Label


# ----------------- DECLARE VARIABLES -----------------



# ----------------- RUN CODE -----------------


func _ready() -> void:
	self.text = "Version " + ProjectSettings.get("application/config/version")
	return


# ----------------- DECLARE FUNCTIONS -----------------

