extends Rite
##The Rite of Channeling enables its parent to have a Channel.

var draw : Mote = load("res://mance/motes/Calm.tres")
var channel = load("res://mance/channel/channel.tscn")

func get_channel_type():
	pass


func guide_draw() -> Mote:
	return draw


func install_channel(node : Node): ##Yes it calls up, but it is meant to be called by higher nodes.
	var gen_channel = channel.instantiate()
	node.add_child(gen_channel)
