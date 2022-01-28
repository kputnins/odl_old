class_name Tile

var type: int
var x: int
var y: int
# TODO change frlom float to int
var food: float
var wood: float
var energy: float
var iron: float
var endurium: float


func _init(param1, param2, param3, param4, param5, param6, param7, param8):
	self.type = param1
	self.x = param2
	self.y = param3
	self.food = param4
	self.wood = param5
	self.energy = param6
	self.iron = param7
	self.endurium = param8
