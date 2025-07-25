extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@onready var catAnim = get_node('AnimationPlayer');

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		
		velocity += get_gravity() * delta
		

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		catAnim.play("jump")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true;
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false;
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			catAnim.play("run");
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			catAnim.play('idle');
	if (velocity.y > 0):
		catAnim.play('fall')
	move_and_slide()
	if Game.playHP <= 0:
		self.queue_free()
		get_tree().change_scene_to_file("res://main.tscn");
