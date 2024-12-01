extends Control

# Declaração de variáveis de instância
var enemy_rock
var enemy_paper
var enemy_scissors

var you_rock
var you_paper
var you_scissors

var youwin
var youlose
var youdraw

var playagain
var menu

func _ready():
	#Exibindo placar
	$ScoreLabel.text = "SCORE: " + str(Global.SCORE)
	# Inicializando corretamente as variáveis com os nós da cena
	enemy_rock = $EnermyRock
	enemy_paper = $EnermyPaper
	enemy_scissors = $EnermyScissors
	
	you_rock = $RockButton
	you_paper = $PaperButton
	you_scissors = $scissorsButton
	
	youwin = $YouWin
	youlose = $YouLose
	youdraw = $YouDraw
	
	playagain = $PlayAgain
	menu = $Menu
	
	# Adicionar sinais para cada botão manualmente
	you_rock.connect("pressed",Callable(self,"_on_rock_pressed"))
	you_paper.connect("pressed",Callable(self,"_on_paper_pressed"))
	you_scissors.connect("pressed",Callable(self,"_on_scissors_pressed"))
	
	playagain.connect("pressed",Callable(self,"_on_play_again_pressed"))
	menu.connect("pressed",Callable(self,"_on_menu_pressed"))
	
	# Esconde os resultados e inimigos no início
	_reset_game()
	


	
# Botão Menu
func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
# Botão Play Again
func _on_play_again_pressed():
	_reset_game()
	
# Botão de pedra
func _on_rock_pressed():
	_on_button_pressed("rock")

# Botão de papel
func _on_paper_pressed():
	_on_button_pressed("paper")

# Botão de tesoura
func _on_scissors_pressed():
	_on_button_pressed("scissors")

# Função principal
func _on_button_pressed(choice):
	# 1 - Apagar os outros botões
	_hide_buttons(choice)
	
	# 2 - Randomizar uma resposta do computador
	var enemy_choices = ["rock", "paper", "scissors"]
	var enemy_choice_str = enemy_choices[randi() % enemy_choices.size()]  # Escolhe aleatoriamente

	# Torna a resposta do inimigo visível
	_show_enemy_choice(enemy_choice_str)
	
	# 3 - Calcular quem ganhou quem perdeu
	var result = _calculate_winner(choice, enemy_choice_str)
	
	# 4 - Exibir resultado
	_show_result(result)

# Ocultar os botões de escolha
func _hide_buttons(choice):
	if is_instance_valid(you_rock) and choice != "rock":
		you_rock.visible = false
	if is_instance_valid(you_paper) and choice != "paper":
		you_paper.visible = false
	if is_instance_valid(you_scissors) and choice != "scissors":
		you_scissors.visible = false

# Mostrar escolha do inimigo
func _show_enemy_choice(choice):
	if choice == "rock" and is_instance_valid(enemy_rock):
		enemy_rock.visible = true
	elif choice == "paper" and is_instance_valid(enemy_paper):
		enemy_paper.visible = true
	elif choice == "scissors" and is_instance_valid(enemy_scissors):
		enemy_scissors.visible = true

# Mostrar resultado
func _show_result(result):
	if is_instance_valid(playagain):
		playagain.visible = true
	if is_instance_valid(menu):
		menu.visible = true
	if result == "win" and is_instance_valid(youwin):
		youwin.visible = true
		Global.SCORE = Global.SCORE + 1
		$ScoreLabel.text = "SCORE: " + str(Global.SCORE)
		if is_instance_valid(youlose):
			youlose.visible = false
	elif result == "lose" and is_instance_valid(youlose):
		Global.SCORE = Global.SCORE - 1
		$ScoreLabel.text = "SCORE: " + str(Global.SCORE)
		youlose.visible = true
		if is_instance_valid(youwin):
			youwin.visible = false
	else:
		if is_instance_valid(youwin):
			youwin.visible = false
		if is_instance_valid(youlose):
			youlose.visible = false
		if is_instance_valid(youdraw):
			youdraw.visible = true

# Resetar o jogo
func _reset_game():
	if is_instance_valid(playagain):
		playagain.visible = false
	if is_instance_valid(menu):
		menu.visible = false
	if is_instance_valid(youwin):
		youwin.visible = false
	if is_instance_valid(youdraw):
		youdraw.visible = false
	if is_instance_valid(youlose):
		youlose.visible = false
	if is_instance_valid(enemy_rock):
		enemy_rock.visible = false
	if is_instance_valid(enemy_paper):
		enemy_paper.visible = false
	if is_instance_valid(enemy_scissors):
		enemy_scissors.visible = false
	if is_instance_valid(you_rock):
		you_rock.visible = true
	if is_instance_valid(you_paper):
		you_paper.visible = true
	if is_instance_valid(you_scissors):
		you_scissors.visible = true

# Calcular vencedor
func _calculate_winner(player_choice, enemy_choice):
	if player_choice == enemy_choice:
		return "draw"
	elif ((player_choice == "rock" and enemy_choice == "scissors") or
		 (player_choice == "paper" and enemy_choice == "rock") or
		 (player_choice == "scissors" and enemy_choice == "paper")):
		return "win"
	else:
		return "lose"



#Falta apenas desabilitar o botao depois que escolhei pedra papel ou tesoura
#Pq se nao da pra ficar apertando
