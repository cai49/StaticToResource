
extends EditorScript

const FILE: String = "res://resources/testDB.cdb"

func _run() -> void:
	var file = FileAccess.open(FILE, FileAccess.READ)
	if file:
		var dict: Dictionary = JSON.parse_string(file.get_as_text()) as Dictionary
		var resources: Array = dict.get("sheets")[0].get("lines") as Array
		for resource in resources:
			print(resource)
			
