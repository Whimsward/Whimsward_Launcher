class_name Foe extends FieldEntity
##Class for Enemy Characters in the Game

@export var hp : HealthComponent
@export var go : MoveComponent
@export var act : TargetComponent
#@export var hit_box : HitBox
@export var attacks : Array[Attack]

# Called when the node enters the scene tree for the first time.
func _ready():
	if attacks:
		load_attacks()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if dying:
		die()
	if act.state == act.behavior.ALERT:
		chase(position.direction_to(act.target.position))
	if act.state == act.behavior.ATTACK:
		attack()
	move_and_slide()


func attack():
	attacks[0].show()
	pass


func chase(target: Vector2):
	go.direction = target
	velocity = go.accelerate(velocity)


func load_attacks():
	pass


func _on_detect_range_body_entered(body):
	if body is Actor:
		print_debug("Target Acquired!")
		act.target = body


#func _on_hit_box_body_entered(body):
	#if body is Attack:
		#if body.get_parent() is Actor:
			#hp.take_damage(body.dmg)


func _on_health_component_death_knell():
	print_debug(self.name, " died!")
	dying = true


func _on_attack_range_body_entered(body):
	if body is Actor:
		act.state = act.behavior.ATTACK
