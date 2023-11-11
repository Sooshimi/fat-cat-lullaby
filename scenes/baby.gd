extends CharacterBody2D

var speed = 50
var player : Node
var relative_direction : Vector2
var collision
var chase : bool

func _physics_process(delta):
	player = get_parent().get_node("FatCat")
	
	# Get relative direction between player and enemy position.
	# Normalize so length of vector is 1.
	relative_direction = (player.position - position).normalized()
	
	collision = move_and_collide(velocity * delta)
	
	if collision:
		# Allows enemy to slide on walls
		velocity = velocity.slide(collision.get_normal())
	
	chase_player(player.position)

func chase_player(player_position:Vector2):
	# Sets chase condition if player is within range
	if position.distance_to(player_position) < 150:
		chase = true
	
	if chase:
		# Sets velocity which changes based on relative direction
		velocity = Vector2(relative_direction * speed)
