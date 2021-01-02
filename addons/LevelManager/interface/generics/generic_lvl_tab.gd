tool
extends Tabs

onready var _dir_label = $VBoxContainer/HBoxContainer3/EditLabels/DirLabel
onready var _name_label = $VBoxContainer/HBoxContainer3/EditLabels/NameLabel
onready var _index_label = $VBoxContainer/HBoxContainer/IndexLabel

var lvl_name
var lvl_dir
var lvl_index

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

