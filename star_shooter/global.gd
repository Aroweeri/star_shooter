extends Node

var hits
var time
var accuracy
var rng

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
