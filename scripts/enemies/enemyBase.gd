extends Node
class_name enemyBase

var _type:Enums.enemyType
var _maxHp:int
var _hp:int
var _toughness:int
var _strength:int
var _armor:int

func _init(type:Enums.enemyType, hp:int, toughness:int, strength:int, armor:int) -> void:
	_type = type
	_hp = hp
	_maxHp = hp
	_toughness = toughness
	_strength = strength
	_armor = armor
