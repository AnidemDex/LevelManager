tool
extends Control

const GenericLvlTab:PackedScene = preload("generics/generic_lvl_tab.tscn")
const GenericLvlData = preload("generics/generic_level_data_resource.tres")
const ConfigDir:= preload("config_data.tres")

var level_data_resource : ResourceLevelData
var created_tabs = []

onready var _config_file_dir_label = $MarginContainer/VBoxContainer/TabContainer/Config/VBoxContainer/HBoxContainer/EditLabel/ConfigLabelEdit
onready var _level_file_dir_label = $MarginContainer/VBoxContainer/TabContainer/Config/VBoxContainer/HBoxContainer/EditLabel/LvlLabelEdit
onready var _file_dialog = $FileDialog
onready var _tab_container = $MarginContainer/VBoxContainer/TabContainer
onready var _add_lvl_btn = $MarginContainer/VBoxContainer/TabContainer/Config/VBoxContainer/AddLvlButton
onready var _new_lvl_popup = $ConfirmationDialog

func _ready():
	ConfigDir.connect("changed", self, "_on_ConfigDir_changed")
	_verify_level_data_file()
	_update_labels()
	_create_tabs()


func _verify_level_data_file():
	if ConfigDir.level_data_file:
		var file = File.new()
		if file.file_exists(ConfigDir.level_data_file):
			level_data_resource = load(ConfigDir.level_data_file)
		else:
			ConfigDir.level_data_file = ""
			ConfigDir.save()
			push_warning("El archivo previamente seleccionado "+ConfigDir.level_data_file+" no existe")
	

func _update_labels():
	_config_file_dir_label.text = ConfigDir.resource_path
	_level_file_dir_label.text = ConfigDir.level_data_file
	if level_data_resource:
		_add_lvl_btn.disabled = false
	else:
		_add_lvl_btn.disabled = true


func _update_tabs() -> void:
	_clean_tabs()
	_create_tabs()


func _create_tabs():
	if level_data_resource:
		for level in level_data_resource.levels:
			var tab = GenericLvlTab.instance()
			tab.lvl_name = level.name
			tab.lvl_dir = level.source
			tab.lvl_index = level_data_resource.levels.find(level)
			tab.lvl_data_resource = level_data_resource
			tab.name = tab.lvl_name
			tab.connect("data_changed", self, "_update_tabs")
			created_tabs.append(tab)
			_tab_container.add_child(tab)
	else:
		push_warning("No existe un archivo de niveles. Crea uno nuevo")
	pass


func _clean_tabs():
	for tab in created_tabs:
		remove_child(tab)
		tab.queue_free()
	created_tabs.clear()


func _modify_configuration_data(data:Dictionary) -> void:
	ConfigDir.level_data_file = data.path
	ConfigDir.save()
	_verify_level_data_file()
	_update_labels()
	_clean_tabs()
	_create_tabs()


func _on_OpenFileButton_pressed() -> void:
	_file_dialog.mode = FileDialog.MODE_OPEN_FILE
	_file_dialog.popup_centered_ratio()


func _on_FileDialog_file_selected(path:String) -> void:
	var file = File.new()
	if file.file_exists(path):
		if load(path) is ResourceLevelData:
			_modify_configuration_data({"path":path})
		else:
			push_warning("File doesn't match with the expected type")
	else:
		ResourceSaver.save(path, GenericLvlData)
		_modify_configuration_data({"path":path})


func _on_ConfigDir_changed():
	# Never called, use _on_FileDialog_file_selected
	_update_labels()


func _on_CreateFileButton_pressed():
	_file_dialog.mode = FileDialog.MODE_SAVE_FILE
	_file_dialog.popup_centered_ratio()


func _on_LevelManager_draw():
	pass


func _on_AddLvlButton_pressed():
	_new_lvl_popup.popup_centered()


func _on_ConfirmationDialog_popup_hide():
	var name_text:String = $ConfirmationDialog.name_label.text
	var dir_text:String = $ConfirmationDialog.source_label.text
	if not $ConfirmationDialog.cancel_btn_pressed:
		level_data_resource.add_level(
			name_text,
			dir_text
			)
		_update_tabs()
