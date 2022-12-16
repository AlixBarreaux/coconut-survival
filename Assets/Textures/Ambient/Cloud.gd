extends Sprite


# --------------------------    DECLARE VARIABLES     --------------------------


var textures : PoolStringArray = ["res://Assets/Textures/Ambient/cloud.png", "res://Assets/Textures/Ambient/cloud_2.png", "res://Assets/Textures/Ambient/cloud_3.png"]

var random_texture_picker = RandomNumberGenerator.new()
var current_texture


# Node References
onready var visibility_notifier_2d: VisibilityNotifier2D = $VisibilityNotifier2D


# ----------------------------    RUN THE CODE     -----------------------------


func _ready() -> void:
	self._initialize_signals()
	self._initialize()


# --------------------------    DECLARE FUNCTIONS     --------------------------


func _initialize_signals() -> void:
	visibility_notifier_2d.connect("screen_entered", self, "on_visibility_notifier_2d_screen_entered")
	visibility_notifier_2d.connect("screen_exited", self, "on_visibility_notifier_2d_screen_exited")
	return


func _initialize() -> void:
	pick_random_texture()
	self.hide()
	return


func on_visibility_notifier_2d_screen_entered() -> void:
	print("Show")
	self.show()
	return


func on_visibility_notifier_2d_screen_exited() -> void:
	print("Hide")
	self.hide()
	return


func pick_random_texture() -> void:
	random_texture_picker.randomize()
	current_texture = random_texture_picker.randi_range(0, textures.size() - 1)
	
	var current_texture_load = load(textures[current_texture])
	self.set_texture(current_texture_load)
