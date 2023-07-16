extends Node


var contador_pescado = 0
var contador_medusa = 0
var contador_pulpo = 0
var contador_pez_linterna = 0
var contador_anguila = 0
var contador_tortuga = 0
var contador_tiburon = 0

var volumen = 50.0

func getVolume():
	return -80 + (float(volumen/100)*104)

func restart():
	contador_pescado = 0
	contador_medusa = 0
	contador_pulpo = 0
	contador_pez_linterna = 0
	contador_anguila = 0
	contador_tortuga = 0
	contador_tiburon = 0
