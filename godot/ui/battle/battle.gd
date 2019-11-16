extends ColorRect
class_name Battle

signal battle_won
signal battle_lost

onready var animation_player := $AnimationPlayer
onready var message_box := $MessageBox
onready var options_box := $OptionsBox

onready var engage_button := $Buttons/EngageButton
onready var inv_button := $Buttons/InvButton
onready var switch_button := $Buttons/SwitchButton
onready var flee_button := $Buttons/FleeButton

onready var ally_display := $Ally
onready var enemy_display := $Enemy

var ally: MAC = null
var enemy: MAC = null

func _ready() -> void:
	_visibility_changed()


func initiate(ally: MAC, enemy: MAC) -> void:
	show()
	self.ally = ally
	self.enemy = enemy
	
	ally_display.set_sprite(ally.mac_data.back_sprite, ally.mac_data.back_frames)
	ally_display.set_health(ally.health, ally.stats.max_health)
	ally_display.set_energy(ally.energy, ally.stats.max_energy)
	enemy_display.set_sprite(enemy.mac_data.front_sprite, enemy.mac_data.front_frames)
	enemy_display.set_health(enemy.health, enemy.stats.max_health)
	enemy_display.set_energy(enemy.energy, enemy.stats.max_energy)
	
	animation_player.play("state_initiate")


func _on_EngageButton_pressed() -> void:
	#TODO Open Menu for attacks
	# This is just a mockup. You should change these up!
	# Instead of automated attacks emit a signal for the user input and then "yield" for the response. Based on the response play animation and damage
	animation_player.play("state_text")
	message_box.display_text("You attacked the enemy!", .5)
	yield(message_box, "text_displayed")
	animation_player.play("ally_attack")
	yield(animation_player, "animation_finished")
	enemy.health -= rand_range(50, 100)
	enemy_display.set_health(enemy.health, enemy.stats.max_health)
	if enemy.health <= 0:
		message_box.display_text("You won!", .5)
		yield(message_box, "text_displayed")
		animation_player.play("enemy_defeat")
		yield(animation_player, "animation_finished")
		yield(get_tree().create_timer(.5), "timeout")
		emit_signal("battle_won")
		hide()
		return
	
	message_box.display_text("The enemy attacked you!", .5)
	yield(message_box, "text_displayed")
	animation_player.play("enemy_attack")
	yield(animation_player, "animation_finished")
	ally.health -= rand_range(50, 100)
	ally_display.set_health(ally.health, ally.stats.max_health)
	if ally.health <= 0:
		message_box.display_text("You lost!", .5)
		yield(message_box, "text_displayed")
		animation_player.play("ally_defeat")
		yield(animation_player, "animation_finished")
		yield(get_tree().create_timer(.5), "timeout")
		emit_signal("battle_lost")
		hide()
		return
	
	animation_player.play("state_initiate")
	


func _on_InvButton_pressed() -> void:
	options_box.display_text("Not implemented!", .5)


func _on_SwitchButton_pressed() -> void:
	options_box.display_text("Not implemented!", .5)


func _on_FleeButton_pressed() -> void:
	pass 


func _unhandled_input(event: InputEvent) -> void:
	get_tree().set_input_as_handled()


func _visibility_changed() -> void:
	set_process_unhandled_input(visible)
