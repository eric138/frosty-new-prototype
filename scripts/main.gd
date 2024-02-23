extends Node

@export var enemy_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_over():
	$ScoreTimer.stop()
	$EnemyTimer.stop()

func _on_start_timer_timeout():
	$EnemyTimer.start()
	$ScoreTimer.start()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

func _on_enemy_timer_timeout():
	# Create a new enemy instance
	var enemy = enemy_scene.instantiate()

	# Choose random location on Path2D
	var enemy_spawn_location = $EnemyPath/EnemySpawnLocation
	enemy_spawn_location.progress_ratio = randf()

	# set the enemy's direction perpendicular to the path direction
	var direction = enemy_spawn_location.rotation + PI / 2

	# set the enemy's position
	enemy.position = enemy_spawn_location.position

	# add randomness to the direction
	direction += randf_range(-PI / 4, PI / 4)
	enemy.rotation = direction

	# choose velocity for the enemy
	var velocity = Vector2(randf_range(150, 250), 0)
	enemy.linear_velocity = velocity.rotated(direction)

	# Add the enemy to the scene
	add_child(enemy)

func _on_score_timer_timeout():
	score += 1
