extends KinematicBody2D

onready var battle := $CanvasLayer/Battle
onready var animation_tree := $AnimationTree

var in_movement := false

onready var party := [MAC.new(preload("res://assets/mac_data/typhlosion.tres"))]


func _physics_process(delta: float) -> void:
	if battle.visible || in_movement:
		return
	
	var x := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y := Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	animation_tree.active = x || y
	animation_tree.set("parameters/blend_position", Vector2(x, -y))
	move_and_collide(Vector2(x, y).normalized())

func _unhandled_input(event: InputEvent) -> void:
	if in_movement:
		return
	

func initiate_battle(enemy) -> void:
	party[0].health = party[0].stats.max_health
	battle.initiate(party[0], enemy)
