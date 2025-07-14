extends CharacterBody2D


const SPEED = 300.0
const SPEEDFROG = 260.0
const JUMP_VELOCITY = -400.0
var cat;
var chase = false;
@onready var frog = get_node("AnimatedSprite2D");

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	cat = get_node("../Cat");
	var direction = (cat.global_position - self.global_position).normalized();
	if chase == true:
		if (direction.x > 0):
			frog.flip_h = true;
		else:
			frog.flip_h = false;
		if frog.animation != 'death':
			frog.play('jump');
		
			# left of the frog
		velocity.x = direction.x * SPEEDFROG
		
	else:
		velocity.x = 0;
		if frog.animation != 'death':
			frog.play("idle");
	move_and_slide()


func _on_player_detection_region_body_entered(body: Node2D) -> void:
	if (body.name == 'Cat'):
		chase = true;
			

func frog_damage():
	Game.playHP -= 3;
	Game.Gold += 3;
	Utils.saveGame();
func _on_player_detection_region_body_exited(body: Node2D) -> void:
	if (body.name == 'Cat'):
		chase = false;


func _on_player_death_detection_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Cat":
		body.velocity.y = JUMP_VELOCITY;
		velocity.x = 0;
		frog.play('death');
		frog_damage();
		await frog.animation_finished
		self.queue_free();
