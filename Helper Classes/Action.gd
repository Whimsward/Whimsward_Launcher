class_name Action extends Resource
##Resource to represent actions Characters can take during Encounters.

@export_group("About")
@export var name : String
@export var description : Thesis
@export var icon : Texture2D
@export var model : PackedScene
@export_group("")

@export var valid_during : Array[Action]
@export var base_duration : float = 0.5
@export var duration : float = base_duration
