extends CharacterBody2D
@export var ball: Ball
# Direction of movement (normalized vector)
var direction: Vector2 = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
# damage is necasary so we can call damage in the script BasicBrick.gd
var damage = 0
var speed = 0
var rdamage = 0
var rspeed = 0
var _velocity: Vector2 = Vector2.ZERO
var collision: KinematicCollision2D

func _physics_process(delta: float) -> void:
	# Calculate the movement vector
	
	damage = ball.getDamage()
	speed = ball.getSpeed()
	# Move the ball and handle collisions
	
	
	# If a collision occurs, bounce the ball
	if collision:
		rdamage = randi_range(1,10)
		damage = damage + rdamage
		rspeed = randi_range(1,2000)
		
		if collision.get_collider() == StaticBody2D:
			direction = direction.bounce((collision.get_normal() + Vector2(roll_nonzero(), roll_nonzero())).normalized())
		direction = direction.bounce(collision.get_normal())
		
	speed = speed + rspeed
	_velocity = direction * speed
	collision = move_and_collide(_velocity * delta)

func roll_nonzero() -> int:
	var value = 0
	while value == 0:
		value = randi_range(-1, 1)
	return value
