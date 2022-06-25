extends Sprite


# --------------------------    DECLARE VARIABLES     --------------------------

var textures : PoolStringArray = ["res://Assets/Textures/Ambient/cloud.png", "res://Assets/Textures/Ambient/cloud_2.png", "res://Assets/Textures/Ambient/cloud_3.png"]

var random_texture_picker = RandomNumberGenerator.new()
var current_texture

# ----------------------------    RUN THE CODE     -----------------------------

func _ready() -> void:
	pick_random_texture()

func _physics_process(delta : float) -> void:
	pass

# --------------------------    DECLARE FUNCTIONS     --------------------------

func pick_random_texture() -> void:
	random_texture_picker.randomize()
	current_texture = random_texture_picker.randi_range(0, textures.size() - 1)
	
	var current_texture_load = load(textures[current_texture])
	self.set_texture(current_texture_load)
