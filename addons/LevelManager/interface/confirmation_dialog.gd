tool
extends ConfirmationDialog

signal cancelled

var name_label
var source_label
var cancel_btn_pressed = false

onready var error_label_empty = $VBoxContainer/ErrorLabel_Empty
onready var error_label_invalid_file = $VBoxContainer/ErrorLabel_InvalidFile

func _ready():
	($VBoxContainer.NameEditButton as Button).disabled = true
	($VBoxContainer.NameEditButton as Button).flat = true
	name_label = $VBoxContainer.NameLabel
	source_label = $VBoxContainer.SourceLabel
	get_cancel().connect("pressed", self, "_cancelled")

func is_valid_data() -> bool:
	var valid_data = false
	if name_label.text != "":
		valid_data = true
		error_label_empty.visible = false
	else:
		valid_data = false
		error_label_empty.visible = true
	if source_label.text != "":
		valid_data = true
		
		var file :File= File.new()
		if not file.file_exists(source_label.text):
			valid_data = false
			error_label_invalid_file.visible = true
	else:
		valid_data = false
		error_label_empty.visible = true

	return valid_data


func _cancelled():
	emit_signal("cancelled")
	cancel_btn_pressed = true


func _on_VBoxContainer_SourceEditButton_pressed():
	($FileDialog as FileDialog).popup_centered_ratio()


func _on_FileDialog_file_selected(path):
	source_label.text = path


func _on_ConfirmationDialog_confirmed():
	cancel_btn_pressed = false
	if is_valid_data():
		hide()
