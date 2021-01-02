tool
extends Resource
class_name ResourceLevelData

export var levels = {}
export var index = 0

func add_level(name:String, source:String):
	
	levels[name] = {
		"source":source,
		"index":index,
		}

	index = self.index + 1
	var err = ResourceSaver.save(resource_path, self)
	if err:
		push_warning("Failed to save levels data. Err#"+String(err))
