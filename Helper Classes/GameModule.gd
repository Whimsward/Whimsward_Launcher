class_name Game extends Node
##Establishes a class of game-running nodes that can be swapped by the "Launcher" ur-app.
#TODO establish the base set of shared functions in a game-runner node.

@export var game_thesis : Thesis
@export var user_input : UserInputComponent
enum Perspective {SIDELONG, TOPDOWN, ISOMETRIC}
@export var view : Perspective

@export_group("Setup","set")
@export var set_lead : Character
@export var set_ui : Control
@export var set_scene : CanvasLayer #world and field entities
@export var set_cam : Camera2D


func make_connections(): ##This function holds the automatic connections a game should make on_ready
	print_debug("I'm connecting to my inputs")
	if user_input:
		user_input.directed.connect(_on_user_directed)
		user_input.v_directed.connect(_on_user_v_directed)




func _ready():
	make_connections()


func _on_user_directed(_direction : Vector2):
	pass


func _on_user_v_directed(_direction : Vector2):
	pass
