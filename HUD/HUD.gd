extends CanvasLayer

signal start_game

func _ready() -> void:	
	$MessageTimer.connect('timeout', self, '_on_MessageTimer_timeout')
	$StartButton.connect('pressed', self, '_on_StartButton_pressed')

func show_message(message: String) -> void:
	$Message.show()
	$Message.text = message
	$MessageTimer.start()

func show_game_over() -> void:
	show_message('Game over')
	yield($MessageTimer, 'timeout')
	
	$Message.text = 'Dodge the \nCreeps!'
	$Message.show()
	yield(get_tree().create_timer(1), 'timeout')
	$StartButton.show()

func update_score(score: int) -> void:
	$ScoreLabel.text = str(score)

func _on_StartButton_pressed() -> void:
	$StartButton.hide()
	emit_signal('start_game')

func _on_MessageTimer_timeout() -> void:
	$Message.hide()
