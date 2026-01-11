class_name money_system extends Node

signal money_changed

@export var money_resource: MoneyResource = null

func _ready():
	money_resource = SaveSystem.save_game.money_resource
	money_resource.changed.connect(func():
		money_resource = SaveSystem.save_game.money_resource
		money_changed.emit())

## Вычисляет деньги. В [param expression] нужно указать выражение, например:
## [codeblock]
## money += (-4 * 5)
## [/codeblock]
## Получится [b]money += - 20[/b] или [b]money -= 20[/b].
##
## Подключите сигнал [param money_changed], если хотите наглядно отслеживать количество
func calculate_money(expression: int):
	money_resource.money += expression
	money_changed.emit()
