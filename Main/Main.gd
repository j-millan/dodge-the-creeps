extends Node

export (PackedScene) var Mob
var score

func _ready() -> void:
	$HUD.connect('start_game', self, 'new_game')
	$Player.connect('hit', self, 'game_over')
	$StartTimer.connect('timeout', self, '_on_StartTimer_timeout')
	$MobTimer.connect('timeout', self, '_on_MobTimer_timeout')
	$ScoreTimer.connect('timeout', self, '_on_ScoreTimer_timeout')
	
	$Background.rect_size = get_viewport().size
	
	randomize()

func new_game() -> void:
	score = 0
	
	$HUD.show_message('Get ready!')
	$HUD.update_score(score)
	
	$Player.start($StartPosition.position)
	$StartTimer.start()

func game_over() -> void :
	$HUD.show_game_over()
	$ScoreTimer.stop()
	$MobTimer.stop()
	
func _on_StartTimer_timeout() -> void:
	$ScoreTimer.start()
	$MobTimer.start()

func _on_ScoreTimer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_MobTimer_timeout() -> void:
	var mob_location = $MobPath/MobSpawnLocation
	mob_location.offset = randi()

	var mob = Mob.instance()
	add_child(mob)
	var direction = mob_location.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	mob.position = mob_location.position
	mob.rotation = direction
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0).rotated(direction)
