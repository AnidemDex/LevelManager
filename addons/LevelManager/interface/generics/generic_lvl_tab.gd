tool
extends Tabs

signal data_changed

onready var _dir_label = $VBoxContainer/HBoxContainer3/EditLabels/DirLabel
onready var _name_label = $VBoxContainer/HBoxContainer3/EditLabels/NameLabel
onready var _index_label = $VBoxContainer/HBoxContainer/IndexLabel
onready var _save_button = $VBoxContainer/SaveButton

var lvl_name
var lvl_dir
var lvl_index
var lvl_data_resource:ResourceLevelData

func _ready():
	_name_label.editable = false
	_dir_label.editable = false
	if lvl_name:
		_name_label.text = String(lvl_name)
	if lvl_dir:
		_dir_label.text = String(lvl_dir)
	if lvl_index:
		_index_label.text = String(lvl_index)
	else:
		_index_label.text = String(0)



func _on_VBoxContainer_NameEditButton_pressed():
	_name_label.editable = true
	_save_button.disabled = false


func _on_VBoxContainer_SourceEditButton_pressed():
	_dir_label.editable = true
	_save_button.disabled = false


func _on_SaveButton_pressed():
	_name_label.editable = false
	_dir_label.editable = false
	
	lvl_data_resource.levels[int(_index_label.text)].name = _name_label.text
	lvl_data_resource.levels[int(_index_label.text)].source = _dir_label.text
	lvl_data_resource.save()
	emit_signal("data_changed")
