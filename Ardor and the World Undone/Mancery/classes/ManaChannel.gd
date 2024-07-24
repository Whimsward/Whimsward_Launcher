@icon("res://Intent.svg")
class_name ManaChannel extends Node2D
##Provides a type of mana access to a Mance module. Has a configurable volume,
##rate, and maximum capacity for how much mana can run through it.

signal filled ##Emits when the Channel is full.
signal grew(chan : ManaChannel,volume : float) ##Emits when the Channel accrues mana.
signal spent(target : Node2D,amount : float) ##Emits when the Channel's mana is tapped by an entity.
signal released(amount : float) ##Emits when the Channel would accrue but is at capacity.
signal type_shifted

var sigs : Array = [filled,grew,spent,released,type_shifted]

var accum : float = 0


@export var type : ManaSource.Medium: ##Allows configuring the relationship between Channel and Entity
	set(value):
		type = value
		if value == ManaSource.Medium.DOMAIN or value == ManaSource.Medium.COLLECTIVE:
			keeps_reserve = true
		elif ritual_reserve:
			keeps_reserve = true
		else: keeps_reserve = false
@export var radiance : Color
@export var tier : int = 1
@export var duration : float = 1.0

var base : Mote = load("res://mance/motes/Calm.tres")

@export var volume : float = 0.0 ##Quantity of mana present in the Channel. Configure for default.
@export var rate : int = 1 ##Configurable factor for accruing Mana in the Channel. 0 shuts off accrual.
@export var capacity : float = 10.0 ##Configurable maximum quantity of mana the Channel can hold.
var at_capacity : bool = false:
	set(value):
		at_capacity = value
		if at_capacity:
			filled.emit()
@export var does_runoff : bool = true ##Turn Overflow on or off.
var keeps_reserve : bool = false
@export var reserve : float
var ritual_reserve : bool = false
@export var store : ManaStore
var active : bool = false

@onready var rad = $ChannelRadiance
@onready var accrue_timer = $AccrueTimer

func _ready(): 
	rad.energy = volume
	rad.color = radiance
	if accrue_timer.autostart:
		active = true


func _physics_process(delta): 
	if active:
		accrue(delta)
	rad.energy = volume / 10


func type_shift(index): ##Called by higher tier nodes to change the selected medium.
	type = index
	type_shifted.emit()


func report(port : Callable):
	filled.connect(port)

func accrue(tick): ##Increases the value of volume based on rate, capacity, and delta of the physics process.
	var incr = (rate * 1) * tick
	accum += incr
	if accum > 1:
		gain(base)
		print_debug(store.congress)
		accum -= 1
		if does_runoff:
			var excess =  - capacity
			overflow(excess)
		volume = clampf(volume + store.density(),0,capacity)
	if volume == capacity:
		at_capacity = true
	grew.emit(self,volume)


func overflow(amt : float): ##Called by accrue() if does_runoff is true and the Channel is full.
	released.emit(amt)


func spend(target,amt : float): ##Called by higher tier nodes to pay for effects
	if volume - amt < 0:
		return volume
	else:
		volume = clampf(volume - amt,0,capacity)
		if at_capacity:
			at_capacity = false
		store.spend_mote(store.congress[-1])
		spent.emit(target,amt)
		return volume


func has_reserve() -> bool:
	if keeps_reserve:
		return true
	else: return false


func gain(mote : Mote):
	if not at_capacity:
		store.add_mote(mote,mote.unit)
	else:
		overflow(mote.unit)
		deactivate()


func activate(one_shot : bool = false):
	if one_shot:
		accrue(1)
	elif duration:
		accrue_timer.wait_time = duration
		accrue_timer.start()
		active = true


func deactivate():
	active = false


func _on_accrue_timer_timeout():
	if not accrue_timer.autostart:
		deactivate()
