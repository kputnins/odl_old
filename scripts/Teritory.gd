extends Node2D

class_name Teritory

# Signals
signal started
signal finished

# Public
export var size := Vector2(6, 6)  # Original: 6x6
export var teritory_seed := 42069

# Private
onready var _tile_map: TileMap = $TileMap
var _rng := RandomNumberGenerator.new()
var _tiles: Array
var _food_distribution: OpenSimplexNoise
var _wood_distribution: OpenSimplexNoise
var _energy_distribution: OpenSimplexNoise
var _iron_distribution: OpenSimplexNoise
var _endurium_distribution: OpenSimplexNoise


# Called when the node enters the scene tree for the first time.
func _ready():
	setup()
	generate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(_input_event):
	if Input.is_key_pressed(KEY_QUOTELEFT):
		for label in _tile_map.get_children():
			label.hide()

	elif Input.is_key_pressed(KEY_1):
		for i in _tiles.size():
			_tile_map.get_children()[i].show()
			_tile_map.get_children()[i].text = "Food: " + str(stepify(_tiles[i].food, 0.01))

	elif Input.is_key_pressed(KEY_2):
		for i in _tiles.size():
			_tile_map.get_children()[i].show()
			_tile_map.get_children()[i].text = "Wood: " + str(stepify(_tiles[i].wood, 0.01))

	elif Input.is_key_pressed(KEY_3):
		for i in _tiles.size():
			_tile_map.get_children()[i].show()
			_tile_map.get_children()[i].text = "Energy: " + str(stepify(_tiles[i].energy, 0.01))

	elif Input.is_key_pressed(KEY_4):
		for i in _tiles.size():
			_tile_map.get_children()[i].show()
			_tile_map.get_children()[i].text = "Iron: " + str(stepify(_tiles[i].iron, 0.01))

	elif Input.is_key_pressed(KEY_5):
		for i in _tiles.size():
			_tile_map.get_children()[i].show()
			_tile_map.get_children()[i].text = "Endurium: " + str(stepify(_tiles[i].endurium, 0.01))


func init_noise() -> void:
	_food_distribution = OpenSimplexNoise.new()
	_food_distribution.seed = _rng.randi()
	_food_distribution.octaves = 3
	_food_distribution.period = 1
	_food_distribution.persistence = 0.5

	_wood_distribution = OpenSimplexNoise.new()
	_wood_distribution.seed = _rng.randi()
	_wood_distribution.octaves = 3
	_wood_distribution.period = 1
	_wood_distribution.persistence = 0.5
	_wood_distribution.persistence = 0.5

	_energy_distribution = OpenSimplexNoise.new()
	_energy_distribution.seed = _rng.randi()
	_energy_distribution.octaves = 3
	_energy_distribution.period = 1
	_energy_distribution.persistence = 0.5
	_energy_distribution.persistence = 0.5

	_iron_distribution = OpenSimplexNoise.new()
	_iron_distribution.seed = _rng.randi()
	_iron_distribution.octaves = 3
	_iron_distribution.period = 1
	_iron_distribution.persistence = 0.5
	_iron_distribution.persistence = 0.5

	_endurium_distribution = OpenSimplexNoise.new()
	_endurium_distribution.seed = _rng.randi()
	_endurium_distribution.octaves = 3
	_endurium_distribution.period = 1
	_endurium_distribution.persistence = 0.5


func setup() -> void:
	_rng.seed = teritory_seed
	init_noise()


func generate() -> void:
	emit_signal("started")
	_generate_landscape()
	_set_landscape()
	_set_labels()
	emit_signal("finished")


func _generate_landscape() -> void:
	for x in range(0, size.x):
		for y in range(0, size.y):
			var food := (_food_distribution.get_noise_2d(x + 1, y + 1) + 1) / 2
			var wood := (_wood_distribution.get_noise_2d(x + 1, y + 1) + 1) / 2
			var energy := (_energy_distribution.get_noise_2d(x + 1, y + 1) + 1) / 2
			var iron := (_iron_distribution.get_noise_2d(x + 1, y + 1) + 1) / 2
			var endurium := (_endurium_distribution.get_noise_2d(x + 1, y + 1) + 1) / 2

			var type: int
			var tile_params := [food, wood, energy, iron, endurium]
			if tile_params.max() == food || tile_params.max() == wood:
				type = Terrain.type.GRASS
			elif tile_params.max() == energy:
				type = Terrain.type.SAND
			elif tile_params.max() == iron || tile_params.max() == endurium:
				type = Terrain.type.ROCK

			_tiles.append(Tile.new(type, x, y, food, wood, energy, iron, endurium))


func _set_landscape() -> void:
	for tile in _tiles:
		_tile_map.set_cell(tile.x, tile.y, tile.type)


func _set_labels() -> void:
	for tile in _tiles:
		var label = Label.new()
		_tile_map.add_child(label)
		label.text = "Food: " + str(stepify(tile.food, 0.01))

		var label_width = label.get_minimum_size().x
		var label_height = label.get_minimum_size().y
		label.set_position(
			(
				_tile_map.map_to_world(Vector2(tile.x, tile.y))
				+ Vector2(-label_width / 2, _tile_map.cell_size.y / 2 - label_height / 2)
			)
		)
