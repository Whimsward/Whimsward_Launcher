class_name Attack extends FieldEntity

signal struck(body)



enum types {SHOT,SLASH,AURA}
@export var type : types
@export var dmg : int = 1
@export var armor : int = 0
@export var friendly_fire : bool

func _ready():
	if not visible:
		$HitBox.visible = false



func _physics_process(_delta):
	if visible:
		$HitBox.visible = true



func _on_hit_box_body_entered(body):
	
	if not body == self:
		struck.emit(body)
		if friendly_fire:
			deal_damage(body)
		elif not body == owner:
			deal_damage(body)
		else:
			pass

func deal_damage(target : Node):
	if target.get_indexed("hp"):
		target.hp.take_damage(dmg)
