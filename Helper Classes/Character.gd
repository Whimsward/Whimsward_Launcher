class_name Character extends Resource
##Carries the reference information relevant to a given character.
##
##This version of the class defines name, bio, actor, and avatar. It also allows for configuring
##the character's various default Affinities. Being marked experimental... as an experiment.
##
##@experimental

static var id_count : int = 1


@export var name : StringName ##Give the Character a [StringName] for reference
@export var id : int ##Give the Character a unique id, esp. for reference in an Encounter

##Refer to a [Thesis] with a modular number of [Argument]s for describing various other relevant
##info about the Character
@export var bio : Thesis

@export var attributes : Dictionary ##Should container references to things like move speed etc.

##Refer to a PackedScene with physics and collision-handling used to represent the Character in gameplay
@export var model : PackedScene

##The Character's default appearance. [br] [br]
##* Might be used in the future for Dialogue portraits or getting the character's base sprite. [br][br] 
##* May be updated from a [Texture2D] reference to a [Sprite2D] to allow for that, depending.
@export var avatar : Texture2D

@export var instr : Instructions

@export_category("Default Affinities")
@export_group("Bears","has")
@export var has_element : bool = false ##Whether the Character starts with an Elemental affinity
@export var has_alignment : bool = false
@export var has_rite : bool = false
@export var has_aspect : bool = false
@export var has_medium : bool = false
@export_group("")

#region Affinity
@export_group("Affinity")
@export_enum("Fire","Lightning","Earth","Water","Void") var elemental ##See [enum Mote.Element].

@export_enum("Association","Extension","Dominion","Edification","Separation") var paradigmatic ##Starting [Alignment].

@export_enum("Spirit","Mind","Will","Body","Parting") var ritual ##Starting [Rite].

@export_enum("Relation", "Intention","Control","Binding","Isolation") var aspect ##Starting [Aspect].

@export_enum("Domain","Study","Innate","Collective","Artifact") var medium ##Primary [ManaSource.Medium].

@export_enum("Hex","Shoot","Strike","Dash","Slash") var violation ##Starting encounter Action.
@export_group("")
#endregion



#region Verbs
@export_group("Verbs")
@export_subgroup("Move")
##Used to determine what Movement Actions a character can take
@export var walk : bool = false:
	set(value):
		walk = value
		if value == true:
			moves["Walk"] = walk
@export var run : bool = false:
	set(value):
		run = value
		if value == true:
			moves["Run"] = run
@export var dash : bool = false:
	set(value):
		dash = value
		if value == true:
			moves["Dash"] = dash
@export var jump : bool = false:
	set(value):
		jump = value
		if value == true:
			moves["Jump"] = jump
@export var fly : bool = false:
	set(value):
		fly = value
		if value == true:
			moves["Fly"] = fly
@export var dodge : bool = false:
	set(value):
		dodge = value
		if value == true:
			moves["Dodge"] = dodge
@export_subgroup("Act")
##Used to determine what Interactive Actions a character can take
@export var mance : bool = false:
	set(value):
		mance = value
		if value == true:
			acts["Mance"] = mance
@export var interact : bool = false:
	set(value):
		interact = value
		if value == true:
			acts["Interact"] = interact
@export var shove : bool = false:
	set(value):
		shove = value
		if value == true:
			acts["Shove"] = shove
@export var climb : bool = false:
	set(value):
		climb = value
		if value == true:
			acts["Climb"] = climb
@export var attack : bool = false:
	set(value):
		attack = value
		if value == true:
			acts["Attack"] = attack
@export_group("")
#endregion

var moves : Dictionary
var acts : Dictionary

func _init():
	id = id_count
	id_count += 1


func present_verbs() -> Array:
	var list = [present_moves(),present_acts()]
	return list


func present_moves():
	return moves.duplicate()


func present_acts():
	return acts.duplicate()


func apparate():
	if model:
		var instance = model.instantiate()
		if instance is FieldEntity:
			instance.char_id = id
			if instance.go is MoveComponent:
				var spd = attributes["Speed"] * 100
				instance.go.max_speed = spd
		return instance
