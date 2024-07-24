class_name Mance extends Node2D
##Module Head for Entities to interact with Mana

signal vented(amt : float)
signal drew(chan : ManaChannel,volume : float)
signal score_changed
signal channel_added(chan : ManaChannel)

@export_group("Alignment Scores")
@export var Association : int = 0
@export var Extension : int = 0
@export var Domination : int = 0
@export var Edification : int = 0
@export var Separation : int = 0
@export_group("")

@export var channels : Array[ManaChannel]

func _ready():
	get_channels()


#region Channel Methods
func gain_channel(chan : ManaChannel):
	channels.append(chan)
	if not get_children().has(chan):
		add_child(chan)
		chan.grew.connect(_on_channel_grew)
	if not chan.has_reserve():
		chan.released.connect(_on_channel_released)
	if not chan.grew.is_connected(_on_channel_grew):
		chan.grew.connect(_on_channel_grew)
	if not chan.spent.is_connected(_on_channel_spent):
		chan.spent.connect(_on_channel_spent)
	if not chan.type_shifted.is_connected(_on_channel_type_shifted):
		chan.type_shifted.connect(_on_channel_type_shifted)
	pull_scores(chan.type,chan.tier)
	channel_added.emit(chan)


func get_channels():
	for c in get_children():
		if c is ManaChannel:
			if not channels.has(c):
				gain_channel(c)


func reset_channels():
	for c in channels:
		if c.grew.is_connected(_on_channel_grew):
			c.grew.disconnect(_on_channel_grew)
		if c.released.is_connected(_on_channel_released):
			c.released.disconnect(_on_channel_released)
		if c.spent.is_connected(_on_channel_spent):
			c.spent.disconnect(_on_channel_spent)
	channels.clear()
	reset_scores()
	get_channels()
#endregion


#region Scores Methods
func pull_scores(index : int,tier : int):
	if index == 0:
		Association += tier
	elif index == 1:
		Extension += tier
	elif index == 2:
		Domination += tier
	elif index == 3:
		Edification += tier
	elif index == 4:
		Separation += tier

	score_changed.emit()


func reset_scores():
	Association = 0
	Extension = 0
	Domination = 0
	Edification = 0
	Separation = 0
#endregion


#region Signal Methods
func _on_channel_released(amt : float):
	vented.emit(amt)


func _on_channel_grew(chan,volume):
	drew.emit(chan,volume)


func _on_channel_spent(target,amount):
	pass


func _on_channel_type_shifted():
	print_debug("Received channel type shift signal")
	reset_channels()
#endregion

