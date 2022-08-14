extends Node2D

var cell_grid = [[], [], []]
var turn = 1
export(PackedScene) var cell_scene

func _ready():
	for i in 3:
		for j in 3:
			cell_grid[i].append(cell_scene.instance())
			cell_grid[i][j].init(Vector2(j, i))
			cell_grid[i][j].connect('on_cell_click', self, '_on_cell_click')
			add_child(cell_grid[i][j])

func check_win():
	var result = 0
	for player in [1, 2]:
		for i in 3:
			var win = [true, true]
			for j in 3:
				win[0] = cell_grid[i][j].state == player if win[0] else false
				win[1] = cell_grid[j][i].state == player if win[1] else false
			if win[0] or win[1]:
				return player
		var win = [true, true]
		for i in 3:
			win[0] = cell_grid[i][i].state == player if win[0] else false
			win[1] = cell_grid[i][2-i].state == player if win[1] else false
		if win[0] or win[1]:
			return player
	return 0

# check no winner

func _on_cell_click(index):
	if cell_grid[index.y][index.x].state == 0 and turn != -1:
		cell_grid[index.y][index.x].state = turn
		turn = 2 if turn == 1 else 1
		get_node('Container/Label').text = 'Player %s\'s turn' % turn
		var win = check_win()
		if win != 0:
			get_node('Container/Label').text = 'Player %s\'s win' % win
			turn = -1
