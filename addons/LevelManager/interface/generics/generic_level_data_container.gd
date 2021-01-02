tool
extends VBoxContainer

signal NameEditButton_pressed
signal SourceEditButton_pressed

onready var NameEditButton = $HBoxContainer3/Buttons/NameEditButton
onready var SourceEditButton = $HBoxContainer3/Buttons/SourceEditButton
onready var SourceLabel = $HBoxContainer3/EditLabels/DirLabel
onready var NameLabel = $HBoxContainer3/EditLabels/NameLabel


func _on_NameEditButton_pressed():
	emit_signal("NameEditButton_pressed")


func _on_SourceEditButton_pressed():
	emit_signal("SourceEditButton_pressed")
