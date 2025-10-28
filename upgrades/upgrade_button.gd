extends Panel

@export var upgrade : Upgrade

var nodes_array := 0
var total_upgrades # почему-то выдает 0

func _ready() -> void:
	await Warehouse.load_upgrades
	total_upgrades = len(upgrade.upgrades)
	%buy_button.pressed.connect(invoke_upgrade)
	if upgrade.upgrade_bought:
		%AnimationPlayer.play("bought")
	%upgrade_name.text = upgrade.upg_name
	%upgrade_description.text = upgrade.upg_desc
	%buy_button.text = str(upgrade.upg_price)

func invoke_upgrade():
	print(total_upgrades)
	if upgrade.upg_price <= Money.money:
		upgrade.upgrade_bought = true
		var p_upgrades = Node.new()
		add_child(p_upgrades)
		for u in upgrade.upgrades:
			if nodes_array < total_upgrades:
				var node = Node.new()
				p_upgrades.add_child(node)
				nodes_array += 1
				node.set_script(u)
				print(node)
		p_upgrades.queue_free()
		print("узлы удалены")
		Money.money -= upgrade.upg_price
		Money.update_money.emit()
		%AnimationPlayer.play("bought")
		#var upg_item = Warehouse.upgrades_list.find(upgrade,0)
		#Warehouse.upgrades_list.erase(upg_item)
		#Warehouse.upgrades_list.append(upgrade)
	else:
		%AnimationPlayer.play("nem")
