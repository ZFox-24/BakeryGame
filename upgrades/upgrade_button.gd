extends Panel

<<<<<<< HEAD
@export var upgrade : Upgrade = preload("res://upgrades/popularity/popularity.tres")#("res://upgrades/upgrade.tres")
=======
<<<<<<< HEAD
@export var upgrade : Upgrade = preload("res://upgrades/popularity/popularity.tres")#("res://upgrades/upgrade.tres")
=======
@export var upgrade := Upgrade.new()
>>>>>>> 0ce500b7dafb441ff0d9391fd76887f9a18e10ce
>>>>>>> 722384cefce475d52ccea57713d3ac23ee1ad129

var nodes_array := 0
var total_upgrades := len(upgrade.upgrades) # почему-то выдает 0

@export var upgrade_bought := false

func _ready() -> void:
<<<<<<< HEAD
	#upgrade = upgrade
=======
<<<<<<< HEAD
	#upgrade = upgrade
=======
>>>>>>> 0ce500b7dafb441ff0d9391fd76887f9a18e10ce
>>>>>>> 722384cefce475d52ccea57713d3ac23ee1ad129
	%buy_button.pressed.connect(invoke_upgrade)
	if upgrade_bought:
		%AnimationPlayer.play("bought")
	%upgrade_name.text = upgrade.upg_name
	%upgrade_description.text = upgrade.upg_desc
	%buy_button.text = str(upgrade.upg_price)

func invoke_upgrade():
	print(total_upgrades)
	if upgrade.upg_price <= Money.money:
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 722384cefce475d52ccea57713d3ac23ee1ad129
		var p_upgrades = Node.new()
		add_child(p_upgrades)
		for u in upgrade.upgrades: # пофиксить нерабочий массив (или цикл)
			if nodes_array < total_upgrades:
				var node = Node.new()
				p_upgrades.add_child(node)
				nodes_array += 1
				node.set_script(u)
				print(node)
<<<<<<< HEAD
=======
=======
		var p_upgrades := Node.new()
		add_child(p_upgrades)
		for u in upgrade.upgrades: # пофиксить нерабочий массив (или цикл)
			if nodes_array < total_upgrades:
				var node := Node.new()
				p_upgrades.add_child(node)
				nodes_array += 1
				node.set_script(u)
>>>>>>> 0ce500b7dafb441ff0d9391fd76887f9a18e10ce
>>>>>>> 722384cefce475d52ccea57713d3ac23ee1ad129
		#p_upgrades.queue_free()
		#print("узлы удалены")
		upgrade_bought = true
		%AnimationPlayer.play("bought")
	else:
		%AnimationPlayer.play("nem")
