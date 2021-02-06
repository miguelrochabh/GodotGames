extends Node

var candyPre = preload("res://scenes/Candy.tscn")
var matrix = []

var obj1
var obj2

func _ready():
	clear_matrix()
	rand_matrix()

func clear_matrix():
	for x in range(9):
		matrix.append([])
		matrix[x] = []
		
		for y in range(12):
			matrix[x].append([])
			matrix[x][y] = null

func rand_matrix():
	for x in range(9):
		for y in range(12):
			if matrix[x][y] == null:
				matrix[x][y] = gen_candy(x, y)

func gen_candy(x, y):
	var newCandy = candyPre.instance()
	newCandy.set_data(x, y)
	newCandy.connect("selected", self, "obj_sel")
	add_child(newCandy)
	return newCandy

func obj_sel(obj, b):
	if b:
		if obj1 == null:
			obj1 = obj
		else:
			obj2 = obj
			
			if(test_prox()):
				obj1.move_to(obj2.x, obj2.y)
				obj2.move_to(obj1.x, obj1.y)
				matrix[obj1.x][obj1.y] = obj2
				matrix[obj2.x][obj2.y] = obj1
				
				get_node("Timer").start()

			else:
				obj1.desel()
				obj2.desel()
				obj1 = null
				obj2 = null

func test_prox():
	if obj1.x == obj2.x and abs(obj1.y - obj2.y) == 1 or obj1.y == obj2.y and abs(obj1.x - obj2.x) == 1:
		return true
	else:
		return false


func _on_Timer_timeout():
	if(find_pattern()):
		#valida
		pass
	else:
		obj1.move_to(obj2.x, obj2.y)
		obj2.move_to(obj1.x, obj1.y)
		matrix[obj1.x][obj1.y] = obj2
		matrix[obj2.x][obj2.y] = obj1

	obj1.desel()
	obj2.desel()
	obj1 = null
	obj2 = null

func find_pattern():
	var to_remove = []
	var valid = false
	for y in range(12):
		for x in range(1, 8):
			var c0 = matrix[x-1][y].color
			var c1 = matrix[x][y].color
			var c2 = matrix[x+1][y].color
			if c0 == c1 and c1 == c2:
				add_to_remove(to_remove, matrix[x-1][y])
				add_to_remove(to_remove, matrix[x][y])
				add_to_remove(to_remove, matrix[x+1][y])
				valid = true
	for x in range(9):
		for y in range(1, 11):
			var c0 = matrix[x][y-1].color
			var c1 = matrix[x][y].color
			var c2 = matrix[x][y+1].color
			if c0 == c1 and c1 == c2:
				add_to_remove(to_remove, matrix[x][y-1])
				add_to_remove(to_remove, matrix[x][y])
				add_to_remove(to_remove, matrix[x][y+1])
				valid = true
	for t in to_remove:
		remove_child(t)
		matrix[t.x][t.y] = null
	
	return valid

func add_to_remove(list, obj):
	if list.has(obj):
		list.append(obj)
		