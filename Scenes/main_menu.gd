extends Node

# Variáveis globais
var SCORE: int = 0
var BOOT: bool = false


func _ready():
	if Global.BOOT:
		print("Boot já foi inicializada. SCORE mantido: ", Global.SCORE)
	else:
		print("Primeira vez no jogo. Inicializando valores.")
		SCORE = 0
		Global.BOOT = true
