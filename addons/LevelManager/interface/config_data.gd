tool
extends Resource

export var level_data_file:String setget _set_level_data_file

func save() -> void:
	var err = ResourceSaver.save(resource_path, self)
	if err:
		push_warning("Failed to save configuration data with error #"+String(err))


func _set_level_data_file(value:String) -> void:
	level_data_file = value
