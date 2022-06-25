extends Node


# --------------------------    DECLARE VARIABLES     --------------------------

# ----------------------------    RUN THE CODE     -----------------------------

func _ready() -> void:
	Events.connect("game_over", self, "hide_ground")

# --------------------------    DECLARE FUNCTIONS     --------------------------

func hide_ground() -> void:
	$ColorRect.hide()
	$ColorRect2.hide()
