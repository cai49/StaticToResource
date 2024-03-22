@tool
extends EditorScript

const FILE: String = "res://static_data/testDB.cdb"
const RES_FOLDER: String = "resources/"

func _run() -> void:
	var file = FileAccess.open(FILE, FileAccess.READ)
	if file:
		var dict: Dictionary = JSON.parse_string(file.get_as_text()) as Dictionary
		var resources: Array = dict.get("sheets")[0].get("lines") as Array
		
		for resource in resources:
			var new_res: BaseResource = BaseResource.new()
			new_res.id = resource.get("id")
			new_res.name = resource.get("name")
			new_res.rarity = int(resource.get("rarity"))
			new_res.description = resource.get("description")
			
			var res_name: String = '%s%s%s%s' % ['res://', RES_FOLDER, new_res.name, '.tres']
			
			# Have not found a way to make the updated resources to show until restarting editor
			if ResourceLoader.exists(res_name):
				EditorInterface.restart_editor(true)

			var saveRes: Error = ResourceSaver.save(new_res, res_name)
			if saveRes != OK:
				print(error_string(saveRes))
			
