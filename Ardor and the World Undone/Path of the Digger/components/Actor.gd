class_name Actor extends FieldEntity
##Class for Player-Controlled Characters in the Game

signal attacked(attack: Attack)

@export var hp : HealthComponent
@export var dir : UserInputComponent
@export var go : MoveComponent
#@export var hit_box : HitBox
@export var atk : AttackComponent
@export var primary_atk : Attack
@export var secondary_atk : Attack



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if dying:
		print_debug("Game Over Man...")
		died.emit()
	
	if dir.direction:
		go.direction = dir.direction
		if hp.armor > 0:
			velocity.move_toward(go.accelerate(velocity) * 2, delta)
		velocity = go.accelerate(velocity)
	elif dir.direction == Vector2.ZERO:
		go.direction = dir.direction
		velocity = go.decelerate(velocity) * delta
	move_and_slide()


func attack():
	primary_atk = load(atk.atk_1).instantiate()
	if primary_atk.type == Attack.types.SHOT:
		attacked.emit(primary_atk)
		primary_atk.go.direction = position.direction_to(get_global_mouse_position())
		primary_atk.show()
	elif primary_atk.type == Attack.types.SLASH:
		pass
	elif primary_atk.type == Attack.types.AURA:
		add_child(primary_atk)
		if primary_atk.armor > 0:
			hp.armor += primary_atk.armor


func alt_attack():
	if atk:
		secondary_atk = load(atk.atk_2).instantiate()
		if secondary_atk.type == Attack.types.SLASH:
			var aimer = secondary_atk.position.direction_to(get_local_mouse_position()).normalized()
			if aimer.y > 0:
				secondary_atk.sprite.flip_v = true
			if aimer.x < 0:
				secondary_atk.sprite.flip_h = true
			print_debug(aimer, " says what?")
			secondary_atk.position = 120 * aimer

			add_child(secondary_atk)


func _unhandled_input(event):
	if event.is_action_pressed("primary"):
		attack()
	if event.is_action_pressed("secondary"):
		alt_attack()

func _on_hit_box_body_entered(body):
	if body is Attack:
		if body.get_parent() is Foe:
			print_debug(hp.current_health)


func _on_health_component_death_knell():
	dying = true
