class_name ManaStore extends Resource

signal mote_added(mote : Mote)
signal merged(congress)

@export var congress : Array = []

func _init():
	resource_local_to_scene = true


func add_mote(kind : Mote,units : int):
	var mote = kind.duplicate()
	mote.unit = units
	if congress.is_empty():
		congress.append(mote)
	elif like(mote):
		merge(mote)
	else:
		print_debug(like(mote))
		congress.append(mote)
		mote_added.emit(mote)

func density():
	var weight : int = 0
	for mote in congress:
		weight += mote.get_weight()
	return weight


func merge(kind : Mote):
	var coalescent = 0
	var union = kind.duplicate()
	for mote : Mote in congress:
		if mote.has_type() == kind.has_type():
			coalescent += mote.unit
			congress.pop_at(congress.find(mote))
	union.unit += coalescent
	congress.append(union)
	merged.emit(congress)


func like(kind : Mote) -> bool:
	var eh = 0
	for mote : Mote in congress:
		if mote.mote_name == kind.mote_name:
			eh += 1
	if eh > 0:
		return true
	else: return false


func report_added(port : Callable):
	mote_added.connect(port)


func report_merged(port : Callable):
	merged.connect(port)


func spend_mote(kind : Mote):
	var spent = kind.duplicate()
	if congress.has(kind):
		congress[congress.find(kind)].spend(1)
	if spent:
		return spent


func get_list():
	var mote_list : Dictionary = {}
	for mote in congress:
		mote_list[mote.confess(mote.type)] = mote.get_weight()
	return mote_list


func load_mote(mote : Mote):
	mote.report_exhausted(mote_exhausted)


func mote_exhausted(mote : Mote):
	congress.pop_at(congress.find(mote))
