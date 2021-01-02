tool
extends EditorPlugin

var interface

func _enter_tree():
	interface = preload("res://addons/LevelManager/interface/level_manager.tscn").instance()
	var panel_btn = add_control_to_bottom_panel(interface, "Level Manager")


func _exit_tree():
	remove_control_from_bottom_panel(interface)
	interface.free()
	pass
