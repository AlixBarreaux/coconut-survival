extends Node


# --------------------------    DECLARE VARIABLES     --------------------------

export var min_tree_amount : int = 15
export var max_tree_amount : int = 10

var map_edges_length : PoolIntArray = [-10000, 10000]
#var map_edges_length : PoolIntArray = [-1000, 1000]

const PALM_TREE_PATH : String = "res://NaturalResources/Trees/Palm Tree/PalmTree.tscn"
const PALM_TREE_PRELOAD = preload(PALM_TREE_PATH)
var palm_tree_instance

const COCONUT_PATH : String = "res://Items/Coconut/Coconut.tscn"
const COCONUT_PRELOAD = preload(COCONUT_PATH)
var coconut_instance

# ----------------------------    RUN THE CODE     -----------------------------

func _ready() -> void:
	generate_trees()
	generate_stone_piles()

# --------------------------    DECLARE FUNCTIONS     --------------------------
# Palm Trees generation
var random_tree_amount_generator = RandomNumberGenerator.new()
var tree_amount : int = 0


var random_spawn_position_generator = RandomNumberGenerator.new()
var random_spawn_position : Vector2 = Vector2(0, 0)


func generate_trees() -> void:
	define_random_tree_amount()
	for generated_tree in range (0, tree_amount):
		random_spawn_position_generator.randomize()
		random_spawn_position.x = random_spawn_position_generator.randi_range(map_edges_length[0], map_edges_length[1])
#		print("Tree generated at: ", random_spawn_position)
		
		palm_tree_instance = PALM_TREE_PRELOAD.instance()
		self.add_child(palm_tree_instance)
		palm_tree_instance.global_position = random_spawn_position
		palm_tree_instance.name = str("PalmTree", generated_tree)
		
		coconut_instance = COCONUT_PRELOAD.instance()
		self.add_child(coconut_instance)
		coconut_instance.global_position = random_spawn_position
		coconut_instance.global_position.y = 0
		coconut_instance.name = str("Coconut", generated_tree)
		
#	print("Total trees generated: ", tree_amount)


func define_random_tree_amount() -> void:
	random_tree_amount_generator.randomize()
	tree_amount = random_tree_amount_generator.randi_range(min_tree_amount, max_tree_amount)





# Stone Piles generation

export var min_stone_amount : int = 10
export var max_stone_amount : int = 15

const STONE_PATH = "res://NaturalResources/Stone Pile/StonePile.tscn"
const STONE_PRELOAD = preload(STONE_PATH)
var stone_instance

var random_stone_amount_generator = RandomNumberGenerator.new()
var stone_amount : int = 0


func generate_stone_piles() -> void:
	define_random_stone_piles_amount()
	for generated_stone in range (0, stone_amount):
		random_spawn_position_generator.randomize()
		random_spawn_position.x = random_spawn_position_generator.randi_range(map_edges_length[0], map_edges_length[1])
#		print("stone generated at: ", random_spawn_position)
		
		stone_instance = STONE_PRELOAD.instance()
		stone_instance.global_position = random_spawn_position
		stone_instance.name = str("StonePile", generated_stone)
		self.add_child(stone_instance)
#	print("Total stones generated: ", stone_amount)


func define_random_stone_piles_amount() -> void:
	random_stone_amount_generator.randomize()
	stone_amount = random_stone_amount_generator.randi_range(min_stone_amount, max_stone_amount)
