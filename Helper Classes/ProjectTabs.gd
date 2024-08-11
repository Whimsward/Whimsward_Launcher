class_name ProjectTabs extends TabContainer
##Displays tabs for noted folders of a project
#TODO Selecting certain Items in a tab will open those scenes.
	#TODO Create signals that will carry enough information up to accomplish that task.

signal activated(list : ItemList,index : int)

@export_dir var project
@export var inval_strings : Array[String]

class Pane extends PanelContainer:
	signal activated(list : ItemList,index : int)
	var file_path
	func take_name(namestring : String):
		name = namestring.to_pascal_case()
	
	func take_file_path(path : String):
		if path.is_absolute_path():
			file_path = path
			return file_path
		elif path.is_relative_path():
			file_path = path
			return file_path
		else:
			return null
	
	func populate(invalid_strings : Array[String] = [""]):
		var list = ItemList.new()
		list.same_column_width = true
		for d in GameRegister.constrain_directories(file_path,invalid_strings):
			var dire = list.add_item(d.get_basename())
			list.set_item_disabled(dire,true)
			for fi in DirAccess.get_files_at(file_path+"/"+d):
				if fi.get_extension() == "tscn":
					list.add_item(fi.get_basename())
		for f in DirAccess.get_files_at(file_path):
			list.add_item(f.get_basename())
		if not list.item_activated.is_connected(_on_list_item_activated):
			list.item_activated.connect(_on_list_item_activated.bind(list))
		add_child(list)


	func tree_view(path : String = file_path, invalid_strings : Array[String] = [""]):
		var view = Tree.new()
		var root = view.create_item()
		root.set_text(0,path)
		for d in GameRegister.constrain_directories(path,invalid_strings):
			var branch = root.create_child()
			branch.set_text(0,d)
			for f in DirAccess.get_files_at(path+"/"+d):
				var leaf = branch.create_child()
				leaf.set_text(0,f)
			for dd in GameRegister.constrain_directories(d,invalid_strings):
				var stem = branch.create_child()
				stem.set_text(0,"Dir - "+dd)
		add_child(view)

	##Pass the item activation signal from the generated ItemList up.
	func _on_list_item_activated(index : int,list):
		activated.emit(list, index)

#region Private Functions
func _ready():
	_display_subdirectories()
	_display_tree_view(project)


func _display_subdirectories(array : PackedStringArray = ProjectTabs.get_subdirectories(project,true,inval_strings)):
	for dir in array:
		var dir_panel = Pane.new()
		dir_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
		dir_panel.take_name(dir)
		dir_panel.take_file_path(project+"/"+dir)
		dir_panel.populate()
		dir_panel.activated.connect(_on_pane_activated)
		add_child(dir_panel)


func _on_pane_activated(list : ItemList,index : int):
	activated.emit(list,index)


func _display_tree_view(path : String = project):
	var tree_pane = Pane.new()
	tree_pane.take_name("Tree View")
	tree_pane.take_file_path(path)
	tree_pane.tree_view(path,inval_strings)
	add_child(tree_pane)
#endregion


#region Public Functions
func get_directory_files(dir : String = project):
	var files = DirAccess.get_files_at(dir)
	return files


func report_activation(react : Callable):
	activated.connect(react)


static func get_subdirectories(dir : String = "res://",validate : bool = false,invalid_strings := [""]) -> PackedStringArray:
	var agent = DirAccess.open(dir)
	if agent:
		agent.include_hidden = false
		agent.include_navigational = false
		var subdirs
		if validate:
			subdirs = GameRegister.constrain_directories(dir,invalid_strings)
			return subdirs
		else:
			subdirs = agent.get_directories().duplicate()
			return subdirs
	else: return PackedStringArray(["No Valid Directory found"])

#endregion
