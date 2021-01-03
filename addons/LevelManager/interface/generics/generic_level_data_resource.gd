tool
extends Resource
class_name ResourceLevelData

export var levels:Array = []

func add_level(name:String, source:String):
	
	levels.append({
		"name":name,
		"source":source,
		})

	save()


func save() -> void:
	var err = ResourceSaver.save(resource_path, self)
	if err:
		push_warning("Failed to save levels data. Err#"+String(err))	
