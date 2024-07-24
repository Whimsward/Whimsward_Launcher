class_name Vendor
extends Node


# TODO: finalize other todo items...

@export_enum("VENDOR","CONTROL","NODE2D") var vend_type : String
@export_dir var vend_dir : String
@export var items : Inventory = Inventory.new()


func _ready():
	dock_subvendors()
	pass


#use for docking child vendor nodes at runtime
func dock_subvendors():
	# TODO: Load Items from this vendor's directory into its inventory
	for file in DirAccess.get_files_at(vend_dir):
		if file.is_absolute_path():
			var item = load(file)
			items.add_item(item)
		else: print("Get the absolute path you nerd")
	if items.get_items().is_empty():
		print("No Items Found in ",self.name,"'s Inventory!")
	pass
#region Defunct subvendors code
	#if subvendors.is_empty():
	#	print("No SubVendors!")
		
		#print(items)
		#for item in items:
		#	var ext = "."+item.get_extension()
		#	var item_name = item.trim_suffix(ext)
		#	subvendors[item_name] = vendors+"/"+item
		#print(subvendors)
	#	choice_dialog()
#endregion





#Use for docking canvas items at runtime
func dock_items():
	pass
