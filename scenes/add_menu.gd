extends Panel

@onready var total_items := 0
@onready var item := get_node(".").item as SaleItem # решить проблему

func _ready() -> void:
	print(item)
	%item_name.text = "Пополнить запасы: " + %item_name_card.text 
	%num_field.text = str(total_items)
	%num_field.caret_column = %num_field.text.length()
	%exit_button.pressed.connect(%add_menu.hide)
	%more_button.pressed.connect(add_values)
	%less_button.pressed.connect(subtract_values)
	
func _process(delta: float) -> void:
	total_items = int(%num_field.text)
	%total_price_lbl.text = str(item.item_price * total_items)

func add_values():
	total_items += 1

func subtract_values():
	total_items -= 1
