extends Panel

@export var slot: UpgSlot

var nodes_array := 0
var total_upgrades # почему-то выдает 0

func _ready() -> void:
	# TODO проблема: при загрузке игры уже купленный апгрейд не возвращает значения.
	# попытки это исправить приводят к выполнению апгрейда каждый раз
	# при включении планшета
	%buy_button.pressed.connect(invoke_upgrade)
	total_upgrades = len(slot.item.upgrades)
	if slot.upg_bought:
		var p_upgrades = Node.new()
		add_child(p_upgrades)
		for u in slot.item.upgrades:
			if nodes_array < total_upgrades:
				var node = Node.new()
				p_upgrades.add_child(node)
				nodes_array += 1
				node.set_script(u)
				print(node)
		p_upgrades.queue_free()
		%AnimationPlayer.play("bought")
	update_slot()

func update_slot():
	%upgrade_icon.texture = slot.item.upg_icon
	%upgrade_name.text = "[i]" + tr(slot.item.upg_name) + "[/i]"
	%upgrade_description.text = slot.item.upg_desc
	%buy_button.text = str(slot.item.upg_price)

func invoke_upgrade():
	if slot.item.upg_price <= Money.money_resource.money:
		var p_upgrades = Node.new()
		add_child(p_upgrades)
		for u in slot.item.upgrades:
			if nodes_array < total_upgrades:
				var node = Node.new()
				p_upgrades.add_child(node)
				nodes_array += 1
				node.set_script(u)
				print(node)
		p_upgrades.queue_free()
		Money.calculate_money(-slot.item.upg_price)
		slot.upg_bought = true
		%AnimationPlayer.play("bought")
		%buy_button.text = tr("TEXT_BOUGHT")
		SaveSystem.save()
	else:
		%AnimationPlayer.play("nem")
