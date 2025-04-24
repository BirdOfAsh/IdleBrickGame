extends Node
## for each ball we need the basic base of it so that we can update it
@export var ball_base: Ball
@export var GameManClass: GameManager
@onready var GameMan = $"../../../GameManager"

func canPay(price: int) -> bool:
	return GameManClass.getCrystal() >= price

## TODO set values to be real price in files

func _on_double_damage_pressed() -> void:
	if canPay(1):
		GameManClass.removeCrystal(1)
		ball_base.setDoubleDamage(true)
		var timer = get_tree().create_timer(30)
		timer.timeout.connect(_on_dd_timer_timeout)

	else:
		print("Cannot Pay for Item")

func _on_dd_timer_timeout() -> void:
	ball_base.setDoubleDamage(false)

func _on_double_speed_pressed() -> void:
	if canPay(1):
		GameManClass.removeCrystal(1)
		ball_base.setDoubleSpeedB(true)
		var timer = get_tree().create_timer(30)
		timer.timeout.connect(_on_ds_timer_timeout)
	else:
		print("Cannot Pay for Item")

func _on_ds_timer_timeout() -> void:
	ball_base.setDoubleSpeedB(false)

func _on_double_cash_pressed() -> void:
	if canPay(1):
		GameManClass.addMoney(GameManClass.getMoney())
	else:
		print("Cannot Pay for Item")

func _on_skip_level_pressed() -> void:
	if canPay(1):
		GameManClass.removeCrystal(1)
		GameMan.moveNextLevel()
	else:
		print("Cannot Pay for Item")
