class_name Actor extends FieldEntity
##Class for Player-Controlled Characters in the Game

signal attacked(attack: AttackModel)

@export_group("Components")
@export var hp : HealthComponent ##[HealthComponent]
#@export var dir : UserInputComponent
@export var go : MoveComponent
@export var hit_box : HitBox
@export_subgroup("Attacks")
@export var atk : AttackComponent
@export var primary_atk : AttackModel
@export var secondary_atk : AttackModel
@export_group("")

@export var wandering : bool = false


func _ready():
	pass



func _physics_process(delta):
	if dying:
		print_debug("Game Over Man...")
		died.emit()
	if wandering:
		if not is_on_floor():
			if go.air_state == go.Air.JUMP:
				if not Input.is_action_pressed("jump"):
					fall()
			else: fall()

		if Input.is_action_just_pressed("jump"):
			jump()	

		elif is_on_floor():
			go.recover_jumps()
			if go.direction.x:
				go.move_state = go.Moves.RUN
			else: go.move_state = go.Moves.IDLE

		if set_direction():
			if hp.armor > 0:
				velocity.move_toward(go.accelerate(velocity) * 2, delta)
			else: velocity = go.accelerate(velocity)
		elif go.direction == Vector2.ZERO:
			velocity = go.decelerate(velocity)# * delta
		
		move_and_slide()


func jump():
	go.jump(velocity)


func fall():
	go.air_state = go.Air.FALL


func attack():
	if atk:
		primary_atk = load(atk.atk_1).instantiate()
		if primary_atk.type == AttackModel.types.SHOT:
			attacked.emit(primary_atk)
			primary_atk.go.direction = position.direction_to(get_global_mouse_position())
			primary_atk.show()
		elif primary_atk.type == AttackModel.types.SLASH:
			pass
		elif primary_atk.type == AttackModel.types.AURA:
			add_child(primary_atk)
			if primary_atk.armor > 0:
				hp.armor += primary_atk.armor


func alt_attack():
	if atk:
		secondary_atk = load(atk.atk_2).instantiate()
		if secondary_atk.type == AttackModel.types.SLASH:
			var aimer = secondary_atk.position.direction_to(get_local_mouse_position()).normalized()
			if aimer.y > 0:
				secondary_atk.sprite.flip_v = true
			if aimer.x < 0:
				secondary_atk.sprite.flip_h = true
			print_debug(aimer, " says what?")
			secondary_atk.position = 120 * aimer
			add_child(secondary_atk)


func set_direction():
	var direction =  Input.get_axis("Left","Right")
	if go:
		go.direction.x = direction
	return direction


func _unhandled_input(event):
	if event.is_action_pressed("primary"):
		attack()
	if event.is_action_pressed("secondary"):
		alt_attack()


func _on_hit_box_body_entered(body):
	if body is AttackModel:
		if body.get_parent() is Foe:
			print_debug(hp.current_health)


func _on_health_component_death_knell():
	dying = true
